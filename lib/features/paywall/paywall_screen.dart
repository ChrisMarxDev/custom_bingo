import 'dart:async';

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/revenue_cat_service.dart';
import 'package:custom_bingo/common/services/user_id.dart';
import 'package:custom_bingo/common/widgets/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:url_launcher/url_launcher.dart';

const _supportEmail = 'bingo@christopher-marx.de';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  RevenueCatPurchaseOption? _option;
  var _isLoadingOption = true;
  var _hasLoadedConfiguredOption = false;
  var _isPurchasing = false;
  var _isRestoring = false;

  @override
  void initState() {
    super.initState();
    unawaited(_loadOption());
  }

  Future<void> _loadOption() async {
    try {
      final state = revenueCatStateBeacon.value;
      if (!state.isConfigured) {
        if (!mounted) return;

        setState(() {
          _option = null;
          _isLoadingOption = false;
        });
        return;
      }

      setState(() {
        _isLoadingOption = true;
        _hasLoadedConfiguredOption = true;
      });

      final option = await fetchRevenueCatLifetimeOption();
      if (!mounted) return;

      setState(() {
        _option = option;
        _isLoadingOption = false;
      });
    } on Object catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'custom_bingo.paywall',
        ),
      );
      if (!mounted) return;

      setState(() => _isLoadingOption = false);
      await showErrorToast(context, _messageFromRevenueCatError(error));
    }
  }

  Future<void> _purchase() async {
    final option = _option;
    if (option == null) return;

    setState(() => _isPurchasing = true);
    try {
      final customerInfo = await purchaseRevenueCatOption(option);
      if (!mounted) return;

      if (hasRevenueCatProAccess(customerInfo)) {
        await showSuccessToast(context, 'Custom Bingo Pro is active.');
      } else {
        await showNeutralToast(
          context,
          'Purchase finished, but Pro is not active.',
        );
      }
    } on Object catch (error) {
      if (!mounted || error is RevenueCatPurchaseCancelled) return;

      await showErrorToast(context, _messageFromRevenueCatError(error));
    } finally {
      if (mounted) {
        setState(() => _isPurchasing = false);
      }
    }
  }

  Future<void> _restore() async {
    setState(() => _isRestoring = true);
    try {
      final customerInfo = await restoreRevenueCatPurchases();
      if (!mounted) return;

      if (hasRevenueCatProAccess(customerInfo)) {
        await showSuccessToast(context, 'Custom Bingo Pro restored.');
      } else {
        await showNeutralToast(context, 'No Pro purchase found.');
      }
    } on Object catch (error) {
      if (!mounted || error is RevenueCatPurchaseCancelled) return;

      await showErrorToast(context, _messageFromRevenueCatError(error));
    } finally {
      if (mounted) {
        setState(() => _isRestoring = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final revenueCatId = userIdBeacon.value;
    final revenueCatState = revenueCatStateBeacon.watch(context);
    final hasProAccess = revenueCatState.hasProAccess;
    if (revenueCatState.isConfigured &&
        !_hasLoadedConfiguredOption &&
        !_isLoadingOption) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          unawaited(_loadOption());
        }
      });
    }

    final canPurchase =
        revenueCatState.isConfigured &&
        _option != null &&
        !_isLoadingOption &&
        !hasProAccess;
    final canRestore = revenueCatState.isConfigured && !_isRestoring;

    return Scaffold(
      appBar: AppBar(title: Text('Custom Bingo Pro', style: context.h2)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Custom Bingo Pro',
            style: context.h2.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Lifetime access, no account required.',
            style: context.p1.copyWith(color: context.weakTextColor),
          ),
          const SizedBox(height: 20),
          _RevenueCatStatusCard(state: revenueCatState),
          const SizedBox(height: 16),
          _LifetimeOptionCard(
            option: _option,
            isLoading: _isLoadingOption,
            hasProAccess: hasProAccess,
            onPurchase: canPurchase ? _purchase : null,
            isPurchasing: _isPurchasing,
          ),
          const SizedBox(height: 16),
          _ProFeatureList(),
          const SizedBox(height: 16),
          _RestoreCard(
            canRestore: canRestore,
            isRestoring: _isRestoring,
            onRestore: _restore,
          ),
          const SizedBox(height: 16),
          _AccessRequestCard(revenueCatId: revenueCatId),
        ],
      ),
    );
  }
}

class _RevenueCatStatusCard extends StatelessWidget {
  const _RevenueCatStatusCard({required this.state});

  final RevenueCatState state;

  @override
  Widget build(BuildContext context) {
    final (icon, title, message, color) = switch (state.status) {
      RevenueCatStatus.configured when state.hasProAccess => (
        Icons.verified,
        'Pro active',
        'Lifetime access is unlocked on this device.',
        context.success,
      ),
      RevenueCatStatus.configured => (
        Icons.lock_open,
        'Ready',
        'Purchases and restores are available.',
        context.primary,
      ),
      RevenueCatStatus.configuring => (
        Icons.hourglass_empty,
        'Loading',
        'Preparing purchase options.',
        context.primary,
      ),
      RevenueCatStatus.error => (
        Icons.error_outline,
        'Purchases unavailable',
        _visibleStatusMessage(state),
        context.error,
      ),
      RevenueCatStatus.unavailable => (
        Icons.info_outline,
        'Purchases unavailable',
        _visibleStatusMessage(state),
        context.weakTextColor,
      ),
    };

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: kBorderRadius,
        border: Border.all(color: color.withValues(alpha: 0.42), width: 2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.h5.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
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

class _LifetimeOptionCard extends StatelessWidget {
  const _LifetimeOptionCard({
    required this.option,
    required this.isLoading,
    required this.hasProAccess,
    required this.onPurchase,
    required this.isPurchasing,
  });

  final RevenueCatPurchaseOption? option;
  final bool isLoading;
  final bool hasProAccess;
  final Future<void> Function()? onPurchase;
  final bool isPurchasing;

  @override
  Widget build(BuildContext context) {
    final option = this.option;
    final price = option?.priceString;
    final productTitle = option?.title;
    final productId = option?.identifier ?? revenueCatLifetimeProductId;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: kBorderRadius,
        border: Border.all(color: context.primary, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                            style: context.h4.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        _ProductBadge(label: productId),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      productTitle ?? 'One option for lifetime Pro access.',
                      style: context.p2.copyWith(color: context.weakTextColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (hasProAccess)
            FilledButton.icon(
              onPressed: null,
              icon: const Icon(Icons.check_circle),
              label: const Text('Purchased'),
            )
          else
            FilledButton.icon(
              onPressed: onPurchase,
              icon: isPurchasing
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.workspace_premium),
              label: Text(_purchaseButtonLabel(isLoading, price)),
            ),
        ],
      ),
    );
  }
}

class _ProFeatureList extends StatelessWidget {
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
            'Included',
            style: context.h4.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          _FeatureRow(
            icon: Icons.palette,
            title: 'Extra colors',
            body: 'A few more color options for your boards.',
          ),
          _FeatureRow(
            icon: Icons.favorite,
            title: 'My gratitude',
            body: 'Thanks for supporting Custom Bingo.',
          ),
          _FeatureRow(
            icon: Icons.lock_open,
            title: 'No premium required',
            body: 'No premium feature will ever be needed for this app.',
          ),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: context.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.p1.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
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

class _RestoreCard extends StatelessWidget {
  const _RestoreCard({
    required this.canRestore,
    required this.isRestoring,
    required this.onRestore,
  });

  final bool canRestore;
  final bool isRestoring;
  final Future<void> Function() onRestore;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: canRestore ? onRestore : null,
      icon: isRestoring
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.restore),
      label: const Text('Restore purchases'),
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

String _purchaseButtonLabel(bool isLoading, String? price) {
  if (isLoading) return 'Loading price';
  if (price == null) return 'Unavailable';
  return 'Buy once - $price';
}

String _visibleStatusMessage(RevenueCatState state) {
  if (kDebugMode) return state.message ?? 'RevenueCat is unavailable.';

  return 'Purchases are unavailable in this build.';
}

String _messageFromRevenueCatError(Object error) {
  if (error is RevenueCatException) return error.message;
  return 'Could not load purchase information.';
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
        'I would like Custom Bingo Pro access.',
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
