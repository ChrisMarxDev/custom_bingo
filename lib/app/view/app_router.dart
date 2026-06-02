import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/root_navigation.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:custom_bingo/features/paywall/paywall_screen.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tile_controller.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tiles_screen.dart';
import 'package:custom_bingo/features/settings/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:state_beacon/state_beacon.dart';

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [routeContextObserver],
    routes: [
      GoRoute(
        path: AppRoutePaths.home,
        builder: (_, __) => const _HomeRouteScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.settings,
        builder: (_, __) => const SettingsScreen(),
      ),
      if (kDebugMode)
        GoRoute(
          path: AppRoutePaths.paywall,
          builder: (_, __) => const PaywallScreen(),
        ),
      if (kDebugMode)
        GoRoute(
          path: AppRoutePaths.preMadeTiles,
          builder: (_, state) =>
              PreMadeTilesScreen(initialMode: _preMadeTileModeFrom(state)),
        ),
    ],
  );
}

PreMadeTileMode _preMadeTileModeFrom(GoRouterState state) {
  return switch (state.uri.queryParameters['mode']) {
    'select' => PreMadeTileMode.selecting,
    _ => PreMadeTileMode.editing,
  };
}

class _HomeRouteScreen extends StatelessWidget {
  const _HomeRouteScreen();

  @override
  Widget build(BuildContext context) {
    final hasBingoCard = currentSelectedBingoCardName.watch(context) != null;
    return hasBingoCard ? const BingoCardScreen() : const NewCardScreen();
  }
}
