import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/premium_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:state_beacon/state_beacon.dart';

class PremiumGate extends StatelessWidget {
  const PremiumGate({
    required this.child,
    super.key,
    this.onUnlockedTap,
    this.showBadge = true,
  });

  final Widget child;
  final VoidCallback? onUnlockedTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final isPremium = isPremiumUserBeacon.watch(context);

    return InkWell(
      onTap: isPremium
          ? onUnlockedTap
          : () => context.push(AppRoutePaths.paywall),
      borderRadius: kBorderRadius,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          child,
          if (!isPremium && showBadge)
            Positioned(
              top: -6,
              right: -6,
              child: _PremiumBadge(
                backgroundColor: context.primary,
                foregroundColor: context.onPrimary,
              ),
            ),
        ],
      ),
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  const _PremiumBadge({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: context.cardColor, width: 2),
      ),
      child: Icon(Icons.lock_rounded, size: 12, color: foregroundColor),
    );
  }
}
