import 'dart:io';
import 'dart:ui' as ui;

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_static_preview.dart';
import 'package:custom_bingo/l10n/arb/app_localizations.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(_loadScreenshotFonts);

  for (final locale in _requestedLocales()) {
    for (final scene in _ScreenshotScene.values) {
      testWidgets(
        'generates ${locale.languageCode} ${scene.fileName} screenshot',
        (tester) async {
          tester.view.physicalSize = const Size(390, 844);
          tester.view.devicePixelRatio = 1;
          addTearDown(() {
            tester.view.resetPhysicalSize();
            tester.view.resetDevicePixelRatio();
          });

          final boundaryKey = GlobalKey();
          await tester.pumpWidget(
            _ScreenshotApp(
              locale: locale,
              boundaryKey: boundaryKey,
              child: _ScreenshotCanvas(scene: scene),
            ),
          );
          await tester.pump(const Duration(milliseconds: 100));

          await tester.runAsync(
            () => _writeScreenshot(
              boundaryKey: boundaryKey,
              locale: locale,
              fileName: scene.fileName,
            ),
          );
        },
      );
    }
  }
}

const _screenshotFontFamily = 'ScreenshotSans';

Future<void> _loadScreenshotFonts() async {
  final flutterRoot =
      Platform.environment['FLUTTER_ROOT'] ??
      '/Users/christophermarx/fvm/versions/3.41.9';
  final pubCache =
      Platform.environment['PUB_CACHE'] ??
      '${Platform.environment['HOME']}/.pub-cache';

  final loader = FontLoader(_screenshotFontFamily)
    ..addFont(_fontData('/System/Library/Fonts/Supplemental/Arial.ttf'))
    ..addFont(_fontData('/System/Library/Fonts/Supplemental/Arial Bold.ttf'));
  await loader.load();

  final materialIconsLoader = FontLoader('MaterialIcons')
    ..addFont(
      _fontData(
        '$flutterRoot/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
      ),
    );
  await materialIconsLoader.load();

  final phosphorRegularLoader = FontLoader('PhosphorRegular')
    ..addFont(
      _fontData(
        '$pubCache/hosted/pub.dev/phosphor_flutter-2.1.0/lib/fonts/Phosphor.ttf',
      ),
    );
  await phosphorRegularLoader.load();
  final packagedPhosphorRegularLoader =
      FontLoader('packages/phosphor_flutter/PhosphorRegular')..addFont(
        _fontData(
          '$pubCache/hosted/pub.dev/phosphor_flutter-2.1.0/lib/fonts/Phosphor.ttf',
        ),
      );
  await packagedPhosphorRegularLoader.load();

  final phosphorFillLoader = FontLoader('PhosphorFill')
    ..addFont(
      _fontData(
        '$pubCache/hosted/pub.dev/phosphor_flutter-2.1.0/lib/fonts/Phosphor-Fill.ttf',
      ),
    );
  await phosphorFillLoader.load();
  final packagedPhosphorFillLoader =
      FontLoader('packages/phosphor_flutter/PhosphorFill')..addFont(
        _fontData(
          '$pubCache/hosted/pub.dev/phosphor_flutter-2.1.0/lib/fonts/Phosphor-Fill.ttf',
        ),
      );
  await packagedPhosphorFillLoader.load();
}

Future<ByteData> _fontData(String path) async {
  return ByteData.sublistView(File(path).readAsBytesSync());
}

List<Locale> _requestedLocales() {
  const raw = String.fromEnvironment('SCREENSHOT_LOCALES', defaultValue: 'en');
  return raw
      .split(',')
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .map((value) {
        final parts = value.split(RegExp('[-_]'));
        return Locale(parts.first, parts.length > 1 ? parts[1] : null);
      })
      .toList(growable: false);
}

Future<void> _writeScreenshot({
  required GlobalKey boundaryKey,
  required Locale locale,
  required String fileName,
}) async {
  final boundary =
      boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 2);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = byteData!.buffer.asUint8List();
  image.dispose();

  final directory = Directory(
    'build/screenshots/${locale.toLanguageTag().toLowerCase()}',
  )..createSync(recursive: true);
  File('${directory.path}/$fileName.png').writeAsBytesSync(bytes);
}

class _ScreenshotApp extends StatelessWidget {
  const _ScreenshotApp({
    required this.locale,
    required this.boundaryKey,
    required this.child,
  });

  final Locale locale;
  final GlobalKey boundaryKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _screenshotTheme,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RepaintBoundary(
        key: boundaryKey,
        child: MediaQuery(
          data: const MediaQueryData(size: Size(390, 844)),
          child: child,
        ),
      ),
    );
  }
}

final _screenshotTheme = ThemeData(
  useMaterial3: true,
  fontFamily: _screenshotFontFamily,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    onSurfaceVariant: Color(0xFF4C4C4C),
    outline: Color(0xFF888888),
    outlineVariant: Color(0xFFBBBBBB),
    surfaceContainerLow: Color(0xFFF5F5F5),
    surfaceContainerHigh: Color(0xFFE1E1E1),
  ),
  cardTheme: const CardThemeData(color: Colors.white),
  textTheme:
      const TextTheme(
        headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),
        labelMedium: TextStyle(fontSize: 12),
        labelSmall: TextStyle(fontSize: 10),
      ).apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
        fontFamily: _screenshotFontFamily,
      ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBBBBBB)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: Colors.black),
    ),
  ),
);

class _ScreenshotCanvas extends StatelessWidget {
  const _ScreenshotCanvas({required this.scene});

  final _ScreenshotScene scene;

  @override
  Widget build(BuildContext context) {
    final copy = _ScreenshotCopy.fromL10n(context.l10n);
    final captions = copy.captions[scene]!;

    return SizedBox(
      width: 390,
      height: 844,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 48, 20, 28),
          child: Column(
            children: [
              SizedBox(
                height: 156,
                child: Center(
                  child: Text(
                    captions,
                    textAlign: TextAlign.center,
                    style: context.h2.copyWith(
                      fontSize: 24,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: _PhoneFrame(
                    child: switch (scene) {
                      _ScreenshotScene.playing => _PlayingBoardScreen(
                        copy: copy,
                        isEditing: false,
                      ),
                      _ScreenshotScene.create => _CreateBoardScreen(copy: copy),
                      _ScreenshotScene.locked => _PlayingBoardScreen(
                        copy: copy,
                        isEditing: true,
                      ),
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  const _PhoneFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      height: 606,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(42),
        border: Border.all(width: 4, color: Colors.black),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                const _StatusBar(),
                Expanded(child: child),
                const _HomeIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          children: [
            Text(
              '12:08',
              style: context.p3.copyWith(fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            const Icon(Icons.signal_cellular_4_bar, size: 13),
            const SizedBox(width: 4),
            const Icon(Icons.wifi, size: 13),
            const SizedBox(width: 4),
            const Icon(Icons.battery_full, size: 15),
          ],
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 24,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: SizedBox(width: 86, height: 4),
        ),
      ),
    );
  }
}

class _PlayingBoardScreen extends StatelessWidget {
  const _PlayingBoardScreen({required this.copy, required this.isEditing});

  final _ScreenshotCopy copy;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 54, 20, 94),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BingoCardStaticView(
                  gridItems: isEditing ? copy.unmarkedGrid : copy.markedGrid,
                  cellSize: 52,
                  boardName: copy.boardName,
                  titleStyle: context.h6,
                  lastChangeDateTime: DateTime(2025, 6, 5, 11, 51),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 28,
          right: 18,
          child: Icon(Icons.more_vert, size: 22, color: context.textColor),
        ),
        if (isEditing)
          Positioned(
            left: 16,
            right: 16,
            bottom: 70,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: context.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: context.p3.copyWith(
                      color: context.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(text: context.l10n.editingHintBefore),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          PhosphorIcons.lockKeyOpen(),
                          color: context.onPrimary,
                          size: 13,
                        ),
                      ),
                      TextSpan(text: context.l10n.editingHintAfter),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 34,
          child: BoardActionBarVisual(
            isEditing: isEditing,
            menu: SizedBox(
              width: 48,
              height: 48,
              child: Icon(Icons.more_vert, color: context.onPrimary),
            ),
            onZoomOut: () {},
            onZoomIn: () {},
            onToggleEditing: () {},
          ),
        ),
      ],
    );
  }
}

class _CreateBoardScreen extends StatefulWidget {
  const _CreateBoardScreen({required this.copy});

  final _ScreenshotCopy copy;

  @override
  State<_CreateBoardScreen> createState() => _CreateBoardScreenState();
}

class _CreateBoardScreenState extends State<_CreateBoardScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.copy.boardName);
  }

  @override
  void didUpdateWidget(covariant _CreateBoardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_nameController.text != widget.copy.boardName) {
      _nameController.text = widget.copy.boardName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(l10n.newCardTitle, style: context.h6)),
              Icon(Icons.more_vert, size: 22, color: context.textColor),
            ],
          ),
          const SizedBox(height: 20),
          NewCardForm(
            nameController: _nameController,
            gridSize: 5,
            isEditingExistingBoard: false,
            appliedPreMadeTexts: const [],
            onNameChanged: (_) {},
            onGridSizeChanged: (_) {},
            onSubmit: () async {},
            showPreMadeSection: false,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}

enum _ScreenshotScene {
  playing('01-playing-board'),
  create('02-create-board'),
  locked('03-locked-board');

  const _ScreenshotScene(this.fileName);

  final String fileName;
}

class _ScreenshotCopy {
  const _ScreenshotCopy({
    required this.captions,
    required this.boardName,
    required this.markedGrid,
    required this.unmarkedGrid,
  });

  final Map<_ScreenshotScene, String> captions;
  final String boardName;
  final List<List<BingoItem>> markedGrid;
  final List<List<BingoItem>> unmarkedGrid;

  static _ScreenshotCopy fromL10n(AppLocalizations l10n) {
    final items = [
      l10n.screenshotTilePhoneDuringVows,
      l10n.screenshotTileChampagneSpilled,
      l10n.screenshotTileSpeechTears,
      l10n.screenshotTileDramaticEntrance,
      l10n.screenshotTileKidsDanceFloor,
      l10n.screenshotTileGuestToast,
      l10n.screenshotTileCrowdClapsEarly,
      l10n.screenshotTileDjClassic,
      l10n.screenshotTileGroupPhotoChaos,
    ];

    return _ScreenshotCopy(
      captions: {
        _ScreenshotScene.playing: l10n.screenshotCaptionPlaying,
        _ScreenshotScene.create: l10n.screenshotCaptionCreate,
        _ScreenshotScene.locked: l10n.screenshotCaptionLocked,
      },
      boardName: l10n.screenshotBoardName,
      markedGrid: _grid(items, doneIndexes: {1, 2, 3, 8, 9}),
      unmarkedGrid: _grid(items),
    );
  }
}

List<List<BingoItem>> _grid(
  List<String> texts, {
  Set<int> doneIndexes = const {},
}) {
  return List.generate(3, (row) {
    return List.generate(3, (column) {
      final index = row * 3 + column;
      return BingoItem(
        id: 'item-$index',
        text: texts[index],
        fullfilledAt: doneIndexes.contains(index)
            ? DateTime(2025, 6, 5, 11, 51)
            : null,
      );
    });
  });
}
