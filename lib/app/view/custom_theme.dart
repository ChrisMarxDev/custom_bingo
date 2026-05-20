// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kWhite = Color(0xFFFFFFFF);
// const Color kBlack = Color(0xFF000000);
const Color kGrey1 = Color(0xFF1f1f1f);
const Color kGrey1_5 = Color(0xFF2f2f2f);
const Color kGrey2 = Color(0xFF4c4c4c);
const Color kGrey3 = Color(0xFF888888);
const Color kGrey4 = Color(0xFFbbbbbb);
const Color kGrey5 = Color(0xFFe1e1e1);
const Color kGrey55 = Color(0xFFe9e9e9);
const Color kGrey6 = Color(0xFFf5f5f5);
const Color kGrey7 = Color.fromRGBO(250, 250, 250, 1);

const kGreen = Color(0xff008000);
const kRed = Color(0xffF6511D);
const kYellow = Color(0xffFFB400);
const kBlue = Color(0xFF3D57E0);

final kColorsBase = [
  const Color(0xffFFBE0B), // Primary Yellow
  const Color(0xffFF5722), // Deep Orange
  const Color(0xffFF69B4), // Hot Pink
  const Color(0xffFF1493), // Deep Pink
  const Color(0xffBA55D3), // Medium Orchid
  const Color(0xff48D1CC), // Medium Turquoise
  const Color(0xff00FA9A), // Light Green
  const Color(0xff00BFFF), // Deep Sky Blue
  const Color(0xffFFD700), // Gold
  const Color(0xffFF8C00), // Dark Orange
  const Color(0xffDC143C), // Crimson
  const Color(0xff8A2BE2), // Blue Violet
  const Color(0xff5F9EA0), // Cadet Blue
  const Color(0xff4169E1), //
];

final kColorExpanded = [
  ...kColorsBase,
  const Color(0xffFF9800), // Dark Orange
  const Color(0xffFF6347), // Tomato
  const Color(0xff87CEFA), // Light Sky Blue
  const Color(0xff7FFF00), // Chartreuse
  const Color(0xffFF4500), // Orange Red
  const Color(0xffC71585), // Medium Violet Red
  const Color(0xff1E90FF), // Dodger Blue
  const Color(0xff9932CC), // Dark Orchid
  const Color(0xff8B0000), // Dark Red
  const Color(0xff483D8B), // Dark Slate Blue
  const Color(0xffFF8C00), // Dark Orange
  const Color(0xff32CD32), // Lime Green
  const Color(0xff20B2AA), // Light Sea Green
  const Color(0xff7B68EE), // Medium Slate Blue
  const Color(0xffDA70D6), // Orchid
  const Color(0xff9ACD32), // Yellow Green
  const Color(0xffFF69B4), // Hot Pink
  const Color(0xff00CED1), // Dark Turquoise
];

const kDarkBlack = Color(0xff000000);

const kBackgroundColorLight = Color(0xffffffff);

class AppThemePalette {
  const AppThemePalette({
    required this.id,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    this.darkPrimary,
    this.darkOnPrimary,
    this.darkSecondary,
    this.darkOnSecondary,
  });

  final String id;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color? darkPrimary;
  final Color? darkOnPrimary;
  final Color? darkSecondary;
  final Color? darkOnSecondary;

  Color resolvePrimary(bool isDarkMode) {
    return isDarkMode ? (darkPrimary ?? primary) : primary;
  }

  Color resolveOnPrimary(bool isDarkMode) {
    return isDarkMode ? (darkOnPrimary ?? onPrimary) : onPrimary;
  }

  Color resolveSecondary(bool isDarkMode) {
    return isDarkMode ? (darkSecondary ?? secondary) : secondary;
  }

  Color resolveOnSecondary(bool isDarkMode) {
    return isDarkMode ? (darkOnSecondary ?? onSecondary) : onSecondary;
  }
}

const appThemePalettes = <AppThemePalette>[
  AppThemePalette(
    id: 'base',
    primary: kDarkBlack,
    onPrimary: kWhite,
    secondary: kWhite,
    onSecondary: kDarkBlack,
    darkPrimary: kWhite,
    darkOnPrimary: kDarkBlack,
    darkSecondary: kDarkBlack,
    darkOnSecondary: kWhite,
  ),
  AppThemePalette(
    id: 'classic',
    primary: kYellow,
    onPrimary: kDarkBlack,
    secondary: kDarkBlack,
    onSecondary: kWhite,
  ),
  AppThemePalette(
    id: 'ocean',
    primary: Color(0xFF1D4ED8),
    onPrimary: kWhite,
    secondary: Color(0xFF7DD3FC),
    onSecondary: kDarkBlack,
  ),
  AppThemePalette(
    id: 'sunset',
    primary: Color(0xFFEA580C),
    onPrimary: kWhite,
    secondary: Color(0xFFFBBF24),
    onSecondary: kDarkBlack,
  ),
  AppThemePalette(
    id: 'berry',
    primary: Color(0xFFBE185D),
    onPrimary: kWhite,
    secondary: Color(0xFFF9A8D4),
    onSecondary: kDarkBlack,
  ),
  AppThemePalette(
    id: 'forest',
    primary: Color(0xFF15803D),
    onPrimary: kWhite,
    secondary: Color(0xFFA3E635),
    onSecondary: kDarkBlack,
  ),
  AppThemePalette(
    id: 'lagoon',
    primary: Color(0xFF0F766E),
    onPrimary: kWhite,
    secondary: Color(0xFF67E8F9),
    onSecondary: kDarkBlack,
  ),
];

final defaultThemePalette = appThemePalettes.first;

ThemeData getThemeData({bool isDarkMode = false, AppThemePalette? palette}) {
  final effectivePalette = palette ?? defaultThemePalette;
  final brightness = isDarkMode ? Brightness.dark : Brightness.light;
  final bg = isDarkMode ? const Color(0xFF121212) : kBackgroundColorLight;
  final surface = isDarkMode ? const Color(0xFF1A1A1A) : kBackgroundColorLight;
  final textColor = isDarkMode ? kWhite : kDarkBlack;
  final weakTextColor = isDarkMode ? kGrey4 : kGrey2;
  final borderColor = isDarkMode ? const Color(0xFF5A5A5A) : kGrey3;
  final mutedBorderColor = isDarkMode ? const Color(0xFF363636) : kGrey4;
  final surfaceDim = isDarkMode ? const Color(0xFF111111) : kGrey55;
  final surfaceBright = isDarkMode ? const Color(0xFF303030) : kWhite;
  final surfaceContainerLowest = isDarkMode ? const Color(0xFF0D0D0D) : kWhite;
  final surfaceContainerLow = isDarkMode ? const Color(0xFF171717) : kGrey6;
  final surfaceContainer = isDarkMode ? const Color(0xFF1F1F1F) : kGrey55;
  final surfaceContainerHigh = isDarkMode ? const Color(0xFF272727) : kGrey5;
  final surfaceContainerHighest = isDarkMode ? const Color(0xFF303030) : kGrey4;
  final primary = effectivePalette.resolvePrimary(isDarkMode);
  final onPrimary = effectivePalette.resolveOnPrimary(isDarkMode);
  final secondary = effectivePalette.resolveSecondary(isDarkMode);
  final onSecondary = effectivePalette.resolveOnSecondary(isDarkMode);
  const buttonPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  Color tone(Color color, double amount) {
    return Color.alphaBlend(color.withValues(alpha: amount), surface);
  }

  final scheme =
      ColorScheme.fromSeed(seedColor: primary, brightness: brightness).copyWith(
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: tone(primary, isDarkMode ? 0.26 : 0.14),
        onPrimaryContainer: textColor,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: tone(secondary, isDarkMode ? 0.22 : 0.12),
        onSecondaryContainer: textColor,
        tertiary: secondary,
        onTertiary: onSecondary,
        tertiaryContainer: tone(secondary, isDarkMode ? 0.18 : 0.1),
        onTertiaryContainer: textColor,
        surface: surface,
        onSurface: textColor,
        surfaceDim: surfaceDim,
        surfaceBright: surfaceBright,
        surfaceContainerLowest: surfaceContainerLowest,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainer: surfaceContainer,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainerHighest: surfaceContainerHighest,
        onSurfaceVariant: weakTextColor,
        outline: borderColor,
        outlineVariant: mutedBorderColor,
        shadow: kDarkBlack,
        scrim: kDarkBlack,
        inverseSurface: isDarkMode ? kWhite : kGrey1,
        onInverseSurface: isDarkMode ? kGrey1 : kWhite,
        inversePrimary: secondary,
        surfaceTint: Colors.transparent,
        error: kRed,
        onError: kWhite,
        errorContainer: tone(kRed, isDarkMode ? 0.28 : 0.14),
        onErrorContainer: textColor,
      );

  const baseTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  final textTheme = GoogleFonts.outfitTextTheme(baseTextTheme).apply(
    bodyColor: textColor,
    displayColor: textColor,
    decorationColor: textColor,
  );

  final buttonTextStyle = textTheme.titleSmall!.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  return ThemeData(
    brightness: brightness,
    splashColor: scheme.primary.withValues(alpha: 0.18),
    scaffoldBackgroundColor: bg,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDarkMode
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: textColor),
    ),
    colorScheme: scheme,
    cardTheme: CardThemeData(
      color: surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: kBorderRadius,
        side: BorderSide(
          color: borderColor,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: scheme.primary.withValues(
        alpha: isDarkMode ? 0.28 : 0.14,
      ),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: scheme.primary);
        }
        return IconThemeData(color: isDarkMode ? kGrey4 : kGrey3);
      }),
    ),
    buttonTheme: const ButtonThemeData(shape: kCardShape),
    iconTheme: IconThemeData(color: textColor),
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: scheme.primary.withValues(
        alpha: isDarkMode ? 0.28 : 0.14,
      ),
      selectedIconTheme: IconThemeData(color: scheme.primary),
      elevation: 0,
      groupAlignment: 0,
      labelType: NavigationRailLabelType.all,
      useIndicator: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          textTheme.titleSmall!.copyWith(fontSize: 18),
        ),
        padding: const WidgetStatePropertyAll(buttonPadding),
        shape: WidgetStateProperty.all<OutlinedBorder>(kCardShape),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDarkMode ? kGrey1 : kWhite;
          }
          return scheme.onPrimary;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return kGrey3;
          }
          return scheme.primary;
        }),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          textTheme.titleSmall!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(kCardShape),
        // backgroundBuilder: (context, states, child) {
        //   return MeshFilledButtonBackground(states: states, child: child);
        // },
        foregroundBuilder: (context, states, child) {
          final color = states.contains(WidgetState.disabled)
              ? (isDarkMode ? kGrey1 : kWhite)
              : scheme.onPrimary;
          return DefaultTextStyle(
            style: buttonTextStyle.copyWith(color: color),
            child: child ?? const SizedBox.shrink(),
          );
        },
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return isDarkMode ? kGrey1 : kWhite;
          }
          return scheme.onPrimary;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return kGrey3;
          }
          return scheme.primary;
        }),
      ),
    ),
    dialogTheme: DialogThemeData(shape: kCardShape, backgroundColor: surface),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          textTheme.titleSmall!.copyWith(fontSize: 18),
        ),
        padding: const WidgetStatePropertyAll(buttonPadding),
        foregroundColor: WidgetStateProperty.all<Color>(textColor),
        shape: WidgetStateProperty.all<OutlinedBorder>(kCardShape),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(width: 2, color: mutedBorderColor);
          }
          return BorderSide(width: 2, color: scheme.primary);
        }),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: surface),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          textTheme.titleSmall!.copyWith(fontSize: 18),
        ),
        padding: const WidgetStatePropertyAll(buttonPadding),
        foregroundColor: WidgetStatePropertyAll(textColor),
        shape: WidgetStateProperty.all<OutlinedBorder>(kCardShape),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: scheme.primary,
      selectionColor: scheme.primary.withValues(alpha: isDarkMode ? 0.35 : 0.2),
      selectionHandleColor: scheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: weakTextColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: kBorderradiusSmall,
        borderSide: BorderSide(color: mutedBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: kBorderradiusSmall,
        borderSide: BorderSide(width: 2, color: scheme.primary),
      ),
    ),
    switchTheme: SwitchThemeData(
      mouseCursor: WidgetStateMouseCursor.clickable,
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return kGrey4;
        }
        return scheme.primary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return scheme.primary.withValues(alpha: isDarkMode ? 0.35 : 0.25);
        }
        return surface;
      }),
      trackOutlineWidth: WidgetStateProperty.all(2),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return scheme.primary;
        }
        return mutedBorderColor;
      }),
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      space: 1,
      endIndent: 0,
      indent: 0,
      color: mutedBorderColor,
    ),
    dataTableTheme: DataTableThemeData(
      dataTextStyle: const TextStyle(),
      headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      decoration: BoxDecoration(border: Border.all(color: mutedBorderColor)),
    ),
    textTheme: textTheme,
    primaryTextTheme: GoogleFonts.bricolageGrotesqueTextTheme().apply(
      bodyColor: textColor,
      displayColor: textColor,
    ),
  );
}

BoxShadow brutShadow(double size, [Color color = kDarkBlack]) {
  return BoxShadow(color: color, offset: Offset(size, size));
}

const kCardBorder = Border.fromBorderSide(BorderSide());

// const kBaseSpacing = 8.0;
// const spaceV1 = SizedBox(height: kBaseSpacing);
// const spaceV2 = SizedBox(height: 2 * kBaseSpacing);
// const spaceV4 = SizedBox(height: 4 * kBaseSpacing);
// const spaceV8 = SizedBox(height: 8 * kBaseSpacing);
// const black with 0.2 opacity

const kShadowColor = Color(0x27000000);
const kBaseShadow = BoxShadow(
  offset: Offset(4, 4),
  blurRadius: 4,
  color: kShadowColor,
);

const kSmallBrutShadow = BoxShadow(offset: Offset(2, 2));

const kDurationQuick = Duration(milliseconds: 240);
const kDurationVeryQuick = Duration(milliseconds: 160);
const kDurationBase = Duration(milliseconds: 350);
const kDurationDebugSloooow = Duration(seconds: 3);

const kSmallSpace = SizedBox(height: 8, width: 8);
const kMediumSpace = SizedBox(height: 16, width: 16);
const kLargeSpace = SizedBox(height: 32, width: 32);

extension ThemeExtension on BuildContext {
  // used for site wide headlines
  TextStyle get h1 =>
      textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold);

  TextStyle get h2 => textTheme.headlineMedium!;

  TextStyle get h3 => textTheme.headlineSmall!;

  // used for specifice block titles
  TextStyle get h4 => textTheme.titleLarge!;

  TextStyle get h5 => textTheme.titleMedium!;

  TextStyle get h6 => textTheme.titleSmall!;

  TextStyle get canvas =>
      h5.copyWith(fontSize: 16, fontWeight: FontWeight.bold);

  // paragraph
  TextStyle get p1 => textTheme.bodyLarge!;
  TextStyle get p2 => textTheme.bodyMedium!;

  //  paragraph small
  TextStyle get p3 => textTheme.bodySmall!;

  TextStyle get caption => textTheme.labelMedium!;

  TextStyle get captionWeak => textTheme.labelSmall!;

  bool isDarkMode() {
    return Theme.of(this).brightness == Brightness.dark;
  }

  // helper method for weaker text
  Color get weakTextColor {
    return colorScheme.onSurfaceVariant;
  }

  Color get disabledColor {
    return colorScheme.outline;
  }

  Color get bg => Theme.of(this).scaffoldBackgroundColor;
  Color get background => bg;

  Color get weakestTextColor {
    return colorScheme.outlineVariant;
  }

  Color get baseTileColor {
    return colorScheme.surfaceContainerLow;
  }

  Color get hoveredColor {
    return colorScheme.surfaceContainerHigh;
  }

  Color get strongTextColor {
    return colorScheme.onSurface;
  }

  Color get primary {
    return Theme.of(this).colorScheme.primary;
  }

  Color get transparent {
    return Theme.of(this).colorScheme.primary.withValues(alpha: 0);
  }

  ThemeData get theme {
    return Theme.of(this);
  }

  Color get secondary {
    return Theme.of(this).colorScheme.secondary;
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }

  Color get onPrimary {
    return colorScheme.onPrimary;
  }

  Color get onSecondary {
    return colorScheme.onSecondary;
  }

  Color get textColor {
    return colorScheme.onSurface;
  }

  Color get onBackground {
    return colorScheme.onSurface;
  }

  Color get notificationCardBackground {
    return colorScheme.surfaceContainerHigh;
  }

  Color get surface {
    return colorScheme.surface;
  }

  Color get cardColor => theme.cardTheme.color!;

  Color get outlineColor {
    return colorScheme.outlineVariant;
  }

  Color get shadowColor {
    return colorScheme.shadow;
  }

  Color get surfaceContainer {
    return colorScheme.surfaceContainer;
  }

  Color get surfaceContainerLow {
    return colorScheme.surfaceContainerLow;
  }

  Color get surfaceContainerLowest {
    return colorScheme.surfaceContainerLowest;
  }

  Color get surfaceContainerHigh {
    return colorScheme.surfaceContainerHigh;
  }

  double get screenHeight =>
      MediaQuery.sizeOf(this).height + MediaQuery.viewInsetsOf(this).vertical;

  Duration get shortDuration => const Duration(milliseconds: 240);

  Duration get baseDuration => const Duration(milliseconds: 350);

  Duration get longDuration => const Duration(milliseconds: 600);

  Curve get baseCurve => Curves.easeIn;

  double get baseSpacing => kBaseSpacing;

  Color get success => kGreen;

  Color get error => colorScheme.error;
}

const kBaseSpacing = 16.0;

const kSideSpacing = 16.0;
const paddingSides = EdgeInsets.symmetric(horizontal: 24);
const bottomButtonSpace = 42.0;

const kRadiusRaw = 12.0;
const kRadiusCircular = Radius.circular(kRadiusRaw);
const kSmallRadiusCircular = Radius.circular(8);
const kBorderradiusSmall = BorderRadius.all(kSmallRadiusCircular);
const kBorderradiusScreenRaw = 32.0;
const kBorderradiusScreen = BorderRadius.all(
  Radius.circular(kBorderradiusScreenRaw),
);
const kBorderRadius = BorderRadius.all(kRadiusCircular);
const kBorderRadiusTop = BorderRadius.only(
  topLeft: kRadiusCircular,
  topRight: kRadiusCircular,
);
const kCardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(kRadiusCircular),
);

const kBorderSide = BorderSide();
const kBorder = Border.fromBorderSide(kBorderSide);

const invisibileBorder = OutlineInputBorder(
  gapPadding: 0,
  borderSide: BorderSide(color: Colors.transparent, width: 0),
);

class HexColor extends Color {
  HexColor(String? hexColor) : super(_getColorFromHex(hexColor ?? '#000000'));

  static int _getColorFromHex(String input) {
    var hexColor = input.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
