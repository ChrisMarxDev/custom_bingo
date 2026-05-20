import 'package:custom_bingo/common/widgets/toast.dart';
import 'package:custom_bingo/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows a toast when called with navigator context', (
    tester,
  ) async {
    final navigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: SizedBox.shrink()),
      ),
    );

    final navigatorContext = navigatorKey.currentContext;
    expect(navigatorContext, isNotNull);

    await showNeutralToast(navigatorContext!, 'Imported as Wedding Bingo (2)');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(tester.takeException(), isNull);
    expect(find.text('Info'), findsOneWidget);
    expect(find.text('Imported as Wedding Bingo (2)'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });

  testWidgets('shows a toast when called with route context', (tester) async {
    late BuildContext routeContext;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            routeContext = context;
            return const Scaffold(body: SizedBox.shrink());
          },
        ),
      ),
    );

    await showNeutralToast(routeContext, 'Imported as Wedding Bingo (2)');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(tester.takeException(), isNull);
    expect(find.text('Info'), findsOneWidget);
    expect(find.text('Imported as Wedding Bingo (2)'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
