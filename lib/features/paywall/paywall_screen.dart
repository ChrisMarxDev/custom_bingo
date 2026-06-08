import 'dart:async';

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/revenue_cat_service.dart';
import 'package:custom_bingo/common/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';

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
    } on Object catch (error) {
      revenueCatStateBeacon.value = revenueCatStateBeacon.value.copyWith(
        status: RevenueCatStatus.error,
        message: _messageFromRevenueCatError(error),
      );
      if (!mounted) return;

      setState(() {
        _option = null;
        _isLoadingOption = false;
      });
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
    final price = _option?.priceString;
    final availabilityMessage = _availabilityMessage(revenueCatState);

    return Scaffold(
      appBar: AppBar(title: Text('Support Custom Bingo', style: context.h2)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              _SupportSummary(hasProAccess: hasProAccess),
              const Spacer(),
              _PaywallActions(
                canPurchase: canPurchase,
                canRestore: canRestore,
                hasProAccess: hasProAccess,
                isLoadingOption: _isLoadingOption,
                isPurchasing: _isPurchasing,
                isRestoring: _isRestoring,
                price: price,
                availabilityMessage: availabilityMessage,
                onPurchase: _purchase,
                onRestore: _restore,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportSummary extends StatelessWidget {
  const _SupportSummary({required this.hasProAccess});

  final bool hasProAccess;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          hasProAccess ? Icons.favorite : Icons.volunteer_activism,
          color: hasProAccess ? context.success : context.primary,
          size: 52,
        ),
        const SizedBox(height: 16),
        Text(
          hasProAccess ? 'Thank you' : 'Support Custom Bingo',
          textAlign: TextAlign.center,
          style: context.h2.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Text(
          'This purchase supports me, the developer, directly. You get my '
          'gratitude and a few small bonus things for your boards.',
          textAlign: TextAlign.center,
          style: context.p1.copyWith(color: context.weakTextColor),
        ),
        const SizedBox(height: 22),
        const _BonusLine(
          icon: Icons.favorite,
          text: 'My gratitude, sincerely.',
        ),
        const _BonusLine(
          icon: Icons.palette,
          text: 'A few extra board colors.',
        ),
        const _BonusLine(
          icon: Icons.auto_awesome,
          text: 'Small supporter extras over time.',
        ),
      ],
    );
  }
}

class _BonusLine extends StatelessWidget {
  const _BonusLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: context.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: context.p2.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaywallActions extends StatelessWidget {
  const _PaywallActions({
    required this.canPurchase,
    required this.canRestore,
    required this.hasProAccess,
    required this.isLoadingOption,
    required this.isPurchasing,
    required this.isRestoring,
    required this.price,
    required this.availabilityMessage,
    required this.onPurchase,
    required this.onRestore,
  });

  final bool canPurchase;
  final bool canRestore;
  final bool hasProAccess;
  final bool isLoadingOption;
  final bool isPurchasing;
  final bool isRestoring;
  final String? price;
  final String? availabilityMessage;
  final Future<void> Function() onPurchase;
  final Future<void> Function() onRestore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'No one ever needs to pay for this app. Custom Bingo stays usable '
          'for everyone.',
          textAlign: TextAlign.center,
          style: context.p2.copyWith(color: context.weakTextColor),
        ),
        const SizedBox(height: 14),
        FilledButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          onPressed: canPurchase ? onPurchase : null,
          icon: isPurchasing
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(hasProAccess ? Icons.check_circle : Icons.favorite),
          label: Text(_purchaseButtonLabel(isLoadingOption, price)),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: canRestore ? onRestore : null,
          icon: isRestoring
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.restore),
          label: const Text('Restore purchase'),
        ),
        if (availabilityMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            availabilityMessage!,
            textAlign: TextAlign.center,
            style: context.caption.copyWith(color: context.weakTextColor),
          ),
        ],
      ],
    );
  }
}

String _purchaseButtonLabel(bool isLoading, String? price) {
  if (isLoading) return 'Loading price';
  if (price == null) return 'Unavailable';
  return 'Support once - $price';
}

String? _availabilityMessage(RevenueCatState state) {
  return switch (state.status) {
    RevenueCatStatus.error =>
      state.message ?? 'Purchases are unavailable right now.',
    RevenueCatStatus.unavailable =>
      state.message ?? 'Purchases are unavailable on this platform.',
    _ => null,
  };
}

String _messageFromRevenueCatError(Object error) {
  if (error is RevenueCatException) return error.message;
  return 'Could not load purchase information.';
}
