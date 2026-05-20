import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/app/view/root_navigation.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/import_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/share_link.dart';
import 'package:custom_bingo/features/settings/theme_settings.dart';
import 'package:custom_bingo/l10n/arb/app_localizations.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:state_beacon/state_beacon.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSub;
  Uri? _lastHandled;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    // app_links exposes the initial link and all further link events through
    // the singleton stream, so we only subscribe once here.
    _linkSub = _appLinks.uriLinkStream.listen(_handleIncomingLink);
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }

  void _handleIncomingLink(Uri uri) {
    if (uri.scheme != shareLinkScheme) return;
    // Dedup: getInitialLink + getLatestLink + the stream may all surface the
    // same URL. Only push the import screen once per unique link.
    if (_lastHandled == uri) return;
    _lastHandled = uri;

    final navigator = rootNavigatorKey.currentState;
    final rootContext = rootNavigatorKey.currentContext;
    if (navigator == null || rootContext == null) return;

    final result = decodeShareLink(uri);
    switch (result) {
      case DecodedShareLinkOk(:final state):
        navigator.push(
          MaterialPageRoute(builder: (_) => ImportCardScreen(incoming: state)),
        );
      case DecodedShareLinkUnsupported():
        showRootErrorToast(rootContext.l10n.importOutdatedAppToast);
      case DecodedShareLinkInvalid():
        showRootErrorToast(rootContext.l10n.importBadLinkToast);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = appThemeModeBeacon.watch(context);
    final palette = appThemePaletteBeacon.watch(context);
    final hasBingoCard = currentSelectedBingoCardName.value != null;
    return MaterialApp(
      navigatorKey: rootNavigatorKey,
      navigatorObservers: [routeContextObserver],
      theme: getThemeData(palette: palette),
      darkTheme: getThemeData(isDarkMode: true, palette: palette),
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: hasBingoCard ? const BingoCardScreen() : const NewCardScreen(),
    );
  }
}
