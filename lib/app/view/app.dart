import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:custom_bingo/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final hasBingoCard = currentSelectedBingoCardName.value != null;
    return MaterialApp(
      theme: getThemeData(),
      themeMode: ThemeMode.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: hasBingoCard ? const BingoCardScreen() : const NewCardScreen(),
    );
  }
}
