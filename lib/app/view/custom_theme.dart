// ignore_for_file: avoid_redundant_argument_values

import 'package:custom_bingo/util/extensions/color_extension.dart';
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

const kBackgroundColorLight = Color(0xffF8FFF8);
const kDividerColor = Color(0xffE2F4E1);

ThemeData getThemeData({bool isDarkMode = false}) {
  // final offWhite = primary.blend(kWhite, 0.9);
  final bg = isDarkMode ? kGrey1 : kBackgroundColorLight;

  const kTextColor = kDarkBlack;
  const primary = kDarkBlack;
  const onPrimary = kWhite;
  const secondary = kYellow;
  const onSecondary = kTextColor;
  const buttonPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  const baseTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  // const fontFamily = 'Roboto';
  final textTheme = GoogleFonts.outfitTextTheme(baseTextTheme).apply(
    bodyColor: kTextColor,
    displayColor: kTextColor,
    decorationColor: kTextColor,
  );

  final buttonTextStyle = textTheme.titleSmall!.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  return ThemeData(
    splashColor: primary.withValues(alpha: 0.2),
    scaffoldBackgroundColor: bg,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Android
        statusBarBrightness: Brightness.light, // iOS: dark icons
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      iconTheme: IconThemeData(color: kDarkBlack),
    ),
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: bg,
      onSurface: isDarkMode ? kWhite : kGrey1,
      onPrimary: onPrimary,
      onSecondary: onSecondary,
      surfaceTint: Colors.transparent,

      // surface: offWhite,
    ),
    cardTheme: CardTheme(
      color: bg,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: kBorderRadius,
        side: BorderSide(
          color: Colors.black,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: primary.blend(kWhite, 0.6),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: primary);
        }
        return const IconThemeData(color: kGrey3);
      }),
    ),
    buttonTheme: const ButtonThemeData(shape: kCardShape),
    iconTheme: const IconThemeData(color: kDarkBlack),
    navigationRailTheme: NavigationRailThemeData(
      indicatorColor: primary.blend(kWhite, 0.6),
      selectedIconTheme: const IconThemeData(color: primary),
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
            return kWhite;
          }
          return onPrimary;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return kGrey3;
          }
          return primary;
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
          final color =
              states.contains(WidgetState.disabled) ? onPrimary : onPrimary;
          return DefaultTextStyle(
            style: buttonTextStyle.copyWith(color: color),
            child: child ?? const SizedBox.shrink(),
          );
        },
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return kWhite;
          }
          return onPrimary;
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return kGrey3;
          }
          return primary;
        }),
      ),
    ),
    dialogTheme: DialogTheme(shape: kCardShape, backgroundColor: bg),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          textTheme.titleSmall!.copyWith(fontSize: 18),
        ),
        padding: const WidgetStatePropertyAll(buttonPadding),
        foregroundColor: WidgetStateProperty.all<Color>(primary),
        shape: WidgetStateProperty.all<OutlinedBorder>(kCardShape),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return const BorderSide(width: 2, color: kGrey4);
          }
          return const BorderSide(width: 2, color: primary);
        }),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: bg),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          textTheme.titleSmall!.copyWith(fontSize: 18),
        ),
        padding: const WidgetStatePropertyAll(buttonPadding),
        shape: WidgetStateProperty.all<OutlinedBorder>(kCardShape),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primary,
      selectionColor: primary.blend(kWhite, 0.6),
      selectionHandleColor: primary,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: kGrey4),
      enabledBorder: OutlineInputBorder(
        borderRadius: kBorderradiusSmall,
        borderSide: BorderSide(color: kGrey4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: kBorderradiusSmall,
        borderSide: BorderSide(width: 2, color: primary),
      ),
    ),
    switchTheme: SwitchThemeData(
      mouseCursor: WidgetStateMouseCursor.clickable,
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return kGrey4;
        }
        return primary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primary.blend(kWhite, 0.8);
        }
        return kWhite;
      }),
      trackOutlineWidth: WidgetStateProperty.all(2),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        return primary;
      }),
    ),
    dividerTheme: const DividerThemeData(
      thickness: 1,
      space: 1,
      endIndent: 0,
      indent: 0,
      color: kDividerColor,
    ),
    dataTableTheme: DataTableThemeData(
      dataTextStyle: const TextStyle(),
      headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      decoration: BoxDecoration(border: Border.all(color: kGrey4)),
    ),
    textTheme: textTheme,
    primaryTextTheme: GoogleFonts.bricolageGrotesqueTextTheme(),
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
    return isDarkMode() ? kGrey2 : kGrey4;
  }

  Color get disabledColor {
    return isDarkMode() ? kGrey2 : kGrey3;
  }

  Color get bg => Theme.of(this).scaffoldBackgroundColor;
  Color get background => bg;

  Color get weakestTextColor {
    return isDarkMode() ? kGrey1_5 : kGrey5;
  }

  Color get baseTileColor {
    return isDarkMode() ? kGrey2 : const Color(0xffF7F9FF);
  }

  Color get hoveredColor {
    return isDarkMode() ? kGrey3 : const Color(0xffD3D6DF);
  }

  Color get strongTextColor {
    return isDarkMode() ? kWhite : kGrey2;
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
    // return textTheme.bodyLarge!.color!;
    return isDarkMode() ? kWhite : kDarkBlack;
  }

  Color get onBackground {
    return colorScheme.onSurface;
  }

  Color get notificationCardBackground {
    return isDarkMode() ? HexColor('#1F1F1F') : kGrey3;
  }

  Color get surface {
    return colorScheme.surface;
  }

  Color get cardColor => theme.cardTheme.color!;

  double get screenHeight =>
      MediaQuery.sizeOf(this).height + MediaQuery.viewInsetsOf(this).vertical;

  Duration get shortDuration => const Duration(milliseconds: 240);

  Duration get baseDuration => const Duration(milliseconds: 350);

  Duration get longDuration => const Duration(milliseconds: 600);

  Curve get baseCurve => Curves.easeIn;

  double get baseSpacing => kBaseSpacing;

  Color get success => kGreen;

  Color get error => kRed;
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
