import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/root_navigation.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/import_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/share_link.dart';
import 'package:custom_bingo/features/home/home_screen.dart';
import 'package:custom_bingo/features/paywall/paywall_screen.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tile_controller.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tiles_screen.dart';
import 'package:custom_bingo/features/settings/settings.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:custom_bingo/util/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter() {
  final initialLocation = getBingoCardNames().isNotEmpty
      ? AppRoutePaths.home
      : AppRoutePaths.root;
  logI(
    'Creating app router: platformDefaultRoute='
    '${_describeRouteNameForLog(WidgetsBinding.instance.platformDispatcher.defaultRouteName)} '
    'initialLocation=$initialLocation',
  );
  return GoRouter(
    initialLocation: initialLocation,
    observers: [routeContextObserver],
    errorBuilder: (_, state) =>
        _RouterErrorScreen(uri: state.uri, error: state.error),
    routes: [
      GoRoute(
        path: AppRoutePaths.root,
        builder: (_, state) => NewCardScreen(
          initialBoardState: state.extra is BingoCardState
              ? state.extra! as BingoCardState
              : null,
        ),
      ),
      GoRoute(path: AppRoutePaths.home, builder: (_, __) => const HomeScreen()),
      GoRoute(
        path: AppRoutePaths.bingoCard,
        builder: (_, __) => const BingoCardScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.importCard,
        builder: (_, state) => _ImportRouteScreen(uri: state.uri),
      ),
      GoRoute(
        path: AppRoutePaths.settings,
        builder: (_, __) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.paywall,
        builder: (_, __) => const PaywallScreen(),
      ),
      GoRoute(
        path: AppRoutePaths.preMadeTiles,
        builder: (_, state) => PreMadeTilesScreen(
          initialMode: state.uri.queryParameters['mode'] == 'select'
              ? PreMadeTileMode.selecting
              : PreMadeTileMode.editing,
        ),
      ),
    ],
  );
}

class _RouterErrorScreen extends StatefulWidget {
  const _RouterErrorScreen({required this.uri, required this.error});

  final Uri uri;
  final Exception? error;

  @override
  State<_RouterErrorScreen> createState() => _RouterErrorScreenState();
}

class _RouterErrorScreenState extends State<_RouterErrorScreen> {
  Uri? _loggedUri;

  @override
  void initState() {
    super.initState();
    _logError();
  }

  @override
  void didUpdateWidget(covariant _RouterErrorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uri != widget.uri || oldWidget.error != widget.error) {
      _logError();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.pageNotFoundTitle),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.go(AppRoutePaths.home),
                child: Text(l10n.homeButton),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logError() {
    if (_loggedUri == widget.uri) return;
    _loggedUri = widget.uri;
    final message = 'Router error: uri=${describeShareUriForLog(widget.uri)}';
    final error = widget.error;
    if (error == null) {
      logW(message);
    } else {
      logError(message, error);
    }
  }
}

class _ImportRouteScreen extends StatefulWidget {
  const _ImportRouteScreen({required this.uri});

  final Uri uri;

  @override
  State<_ImportRouteScreen> createState() => _ImportRouteScreenState();
}

class _ImportRouteScreenState extends State<_ImportRouteScreen> {
  bool _sideEffectQueued = false;
  Uri? _loggedUri;

  @override
  void didUpdateWidget(covariant _ImportRouteScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uri != widget.uri) {
      _sideEffectQueued = false;
      _loggedUri = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = decodeShareLink(widget.uri);
    _logRouteMatch(result);

    return switch (result) {
      DecodedShareLinkOk(:final state) when kIsWeb => _buildWebAutoImport(
        context,
        state,
      ),
      DecodedShareLinkOk(:final state) => ImportCardScreen(incoming: state),
      DecodedShareLinkUnsupported() => _buildToastFallback(
        context,
        context.l10n.importOutdatedAppToast,
      ),
      DecodedShareLinkInvalid() => _buildToastFallback(
        context,
        context.l10n.importBadLinkToast,
      ),
    };
  }

  Widget _buildWebAutoImport(BuildContext context, BingoCardState incoming) {
    if (!_sideEffectQueued) {
      _sideEffectQueued = true;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        logI(
          'Auto-importing web share link: '
          '${describeShareUriForLog(widget.uri)}',
        );
        try {
          await importIncomingBingoCard(
            context,
            incoming,
            source: 'web_auto_import',
          );
          logI(
            'Finished web share link import: '
            '${describeShareUriForLog(widget.uri)}',
          );
        } catch (error, stackTrace) {
          logError('Failed to auto-import web share link', error, stackTrace);
        }
      });
    }
    return const HomeScreen();
  }

  Widget _buildToastFallback(BuildContext context, String message) {
    if (!_sideEffectQueued) {
      _sideEffectQueued = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        showRootErrorToast(message);
      });
    }
    return const HomeScreen();
  }

  void _logRouteMatch(DecodedShareLink result) {
    if (_loggedUri == widget.uri) return;
    _loggedUri = widget.uri;
    logI(
      'Import route matched: '
      'outcome=${describeShareLinkOutcomeForLog(result)} '
      'uri=${describeShareUriForLog(widget.uri)}',
    );
  }
}

String _describeRouteNameForLog(String routeName) {
  try {
    return describeShareUriForLog(Uri.parse(routeName));
  } on FormatException {
    return '<unparseable chars=${routeName.length}>';
  }
}
