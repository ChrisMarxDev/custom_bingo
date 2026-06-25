import 'dart:async';

import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:custom_bingo/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:state_beacon/state_beacon.dart';

final ratingPromptServiceBeacon = Beacon.writable<RatingPromptService>(
  RatingPromptService(),
);

class RatingPromptService {
  RatingPromptService({InAppReview? inAppReview})
    : _inAppReview = inAppReview ?? InAppReview.instance;

  static const _requestedKey = 'rating_prompt_requested';

  final InAppReview _inAppReview;
  bool _requestInProgress = false;

  Future<void> maybeRequestAfterBingo(BuildContext context) async {
    await _maybeRequestReview(context, delay: const Duration(seconds: 2));
  }

  Future<void> maybeRequestFromSupportPrompt(BuildContext context) async {
    await _maybeRequestReview(context);
  }

  Future<void> _maybeRequestReview(
    BuildContext context, {
    Duration delay = Duration.zero,
  }) async {
    if (_requestInProgress) return;

    final prefs = sharedPrefsBeacon.value;
    if (prefs.getBool(_requestedKey) ?? false) return;

    _requestInProgress = true;
    try {
      await prefs.setBool(_requestedKey, true);
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
        if (!context.mounted) return;
      }

      final l10n = context.l10n;
      final wantsReview = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(l10n.ratingPromptTitle),
          content: Text(l10n.ratingPromptBody),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext, rootNavigator: true).pop(false),
              child: Text(l10n.ratingPromptNo),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(dialogContext, rootNavigator: true).pop(true),
              child: Text(l10n.ratingPromptYes),
            ),
          ],
        ),
      );

      if (wantsReview != true) return;

      await Future<void>.delayed(const Duration(milliseconds: 250));
      if (!context.mounted) return;
      if (!await _inAppReview.isAvailable()) return;

      await _inAppReview.requestReview();
    } catch (error, stackTrace) {
      logError('Failed to request app review', error, stackTrace);
    } finally {
      _requestInProgress = false;
    }
  }
}
