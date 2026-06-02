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

  Future<void> maybeRequestAfterBingo(BuildContext context) async {
    final prefs = sharedPrefsBeacon.value;
    if (prefs.getBool(_requestedKey) ?? false) return;

    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      if (!context.mounted) return;

      final l10n = context.l10n;
      final wantsReview = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.ratingPromptTitle),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.ratingPromptNo),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.ratingPromptYes),
            ),
          ],
        ),
      );

      await prefs.setBool(_requestedKey, true);
      if (wantsReview != true) return;
      if (!await _inAppReview.isAvailable()) return;

      await _inAppReview.requestReview();
    } catch (error, stackTrace) {
      logError('Failed to request app review', error, stackTrace);
    }
  }
}
