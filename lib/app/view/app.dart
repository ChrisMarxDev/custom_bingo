import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/app_router.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/premium_service.dart';
import 'package:custom_bingo/features/bingo_card/share_link.dart';
import 'package:custom_bingo/features/settings/theme_settings.dart';
import 'package:custom_bingo/l10n/arb/app_localizations.dart';
import 'package:custom_bingo/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:state_beacon/state_beacon.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppLinks _appLinks;
  late final GoRouter _router;
  StreamSubscription<Uri>? _linkSub;
  Uri? _lastHandled;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter();
    _appLinks = AppLinks();
    logI(
      'App initialized: platformDefaultRoute='
      '${_describeRouteNameForLog(WidgetsBinding.instance.platformDispatcher.defaultRouteName)} uriBase=${describeShareUriForLog(Uri.base)}',
    );
    // app_links exposes the initial link and all further link events through
    // the singleton stream, so we only subscribe once here.
    _linkSub = _appLinks.uriLinkStream.listen(
      (uri) => _handleIncomingLink(uri, source: 'app_links'),
      onError: (Object error, StackTrace stackTrace) {
        logError('App link stream error', error, stackTrace);
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _handleIncomingLink(Uri.base, source: 'uri_base');
      }
    });
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    _router.dispose();
    super.dispose();
  }

  void _handleIncomingLink(Uri uri, {required String source}) {
    final result = decodeShareLink(uri);
    if (result case DecodedShareLinkInvalid()) {
      logD(
        'Ignoring non-share link from $source: '
        '${describeShareUriForLog(uri)}',
      );
      return;
    }

    // Dedup: initial URL handling and the app_links stream can surface the
    // same URL more than once. Only route to the import screen once.
    if (_lastHandled == uri) {
      logD(
        'Skipping duplicate share link from $source: '
        '${describeShareUriForLog(uri)}',
      );
      return;
    }
    _lastHandled = uri;

    final routeLocation = Uri(
      path: AppRoutePaths.importCard,
      queryParameters: uri.queryParameters,
    ).toString();
    logI(
      'Routing share link from $source: '
      'outcome=${describeShareLinkOutcomeForLog(result)} '
      'uri=${describeShareUriForLog(uri)} '
      'routePath=${AppRoutePaths.importCard}',
    );
    _router.go(routeLocation);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = appThemeModeBeacon.watch(context);
    final palette = appThemePaletteBeacon.watch(context);
    final isPremiumUser = isPremiumUserBeacon.watch(context);
    final effectivePalette = availableAppThemePalette(
      palette,
      isPremiumUser: isPremiumUser,
    );
    return MaterialApp.router(
      routerConfig: _router,
      theme: getThemeData(palette: effectivePalette),
      darkTheme: getThemeData(isDarkMode: true, palette: effectivePalette),
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
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
