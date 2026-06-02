import 'dart:async';

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/user_id.dart';
import 'package:custom_bingo/common/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

const _supportEmail = 'bingo@christopher-marx.de';
const _lifetimeProductId = 'lifetime';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final revenueCatId = userIdBeacon.value;

    return Scaffold(
      appBar: AppBar(title: Text('Custom Bingo Pro', style: context.h2)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Custom Bingo | No signup Pro',
            style: context.h2.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Lifetime access, no account required.',
            style: context.p1.copyWith(color: context.weakTextColor),
          ),
          const SizedBox(height: 24),
          _LifetimeOptionCard(),
          const SizedBox(height: 16),
          _AccessRequestCard(revenueCatId: revenueCatId),
        ],
      ),
    );
  }
}

class _LifetimeOptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: kBorderRadius,
        border: Border.all(color: context.primary, width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.12),
              borderRadius: kBorderradiusSmall,
            ),
            child: Icon(Icons.all_inclusive, color: context.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Lifetime',
                        style: context.h4.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    _ProductBadge(label: _lifetimeProductId),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'One option for lifetime Pro access.',
                  style: context.p2.copyWith(color: context.weakTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessRequestCard extends StatelessWidget {
  const _AccessRequestCard({required this.revenueCatId});

  final String revenueCatId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: kBorderRadius,
        border: Border.all(color: context.weakestTextColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "If you don't want to pay and want the premium features, you can "
            'just ask me.',
            style: context.p1,
          ),
          const SizedBox(height: 12),
          Text('Send a mail with your user id here:', style: context.p1),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _openAccessRequestEmail(context, revenueCatId),
            icon: const Icon(Icons.mail_outline),
            label: const Text('Send a mail'),
          ),
          const SizedBox(height: 16),
          _RevenueCatIdBox(revenueCatId: revenueCatId),
        ],
      ),
    );
  }
}

class _RevenueCatIdBox extends StatelessWidget {
  const _RevenueCatIdBox({required this.revenueCatId});

  final String revenueCatId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.surfaceContainerLow,
        borderRadius: kBorderradiusSmall,
        border: Border.all(color: context.outlineColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'RevenueCat ID',
                  style: context.caption.copyWith(
                    color: context.weakTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Copy RevenueCat ID',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: revenueCatId));
                  unawaited(showSuccessToast(context, 'RevenueCat ID copied.'));
                },
                icon: const Icon(Icons.copy),
              ),
            ],
          ),
          SelectableText(
            revenueCatId,
            style: context.p2.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _ProductBadge extends StatelessWidget {
  const _ProductBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: context.surfaceContainerLow,
        borderRadius: const BorderRadius.all(Radius.circular(999)),
        border: Border.all(color: context.outlineColor),
      ),
      child: Text(
        label,
        style: context.caption.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}

Future<void> _openAccessRequestEmail(
  BuildContext context,
  String revenueCatId,
) async {
  final uri = Uri(
    scheme: 'mailto',
    path: _supportEmail,
    queryParameters: {
      'subject': 'Custom Bingo Pro access',
      'body': [
        'Hi,',
        '',
        'I would like Custom Bingo | No signup Pro access.',
        '',
        'RevenueCat ID:',
        revenueCatId,
      ].join('\n'),
    },
  );

  try {
    final launched = await launchUrl(uri);
    if (!launched && context.mounted) {
      await showErrorToast(context, 'Could not open your mail app.');
    }
  } on Object catch (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'custom_bingo.paywall',
      ),
    );
    if (context.mounted) {
      await showErrorToast(context, 'Could not open your mail app.');
    }
  }
}
