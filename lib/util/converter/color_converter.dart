import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';

Color colorFromHex(String hex) {
  var hexResult = hex.toUpperCase().replaceAll('#', '');
  if (hexResult.length == 6) {
    hexResult = 'FF$hexResult';
  }
  return Color(int.parse(hexResult, radix: 16));
}

String colorToHex(Color color) {
  // ignore: deprecated_member_use
  return color.value.toRadixString(16).substring(2).toUpperCase();
}

class UriMapper extends SimpleMapper<Uri> {
  const UriMapper();

  @override
  Uri decode(dynamic value) {
    return Uri.parse(value as String);
  }

  @override
  dynamic encode(Uri self) {
    return self.toString();
  }
}

class ColorMapper extends SimpleMapper<Color> {
  const ColorMapper();

  @override
  Color decode(dynamic value) {
    return colorFromHex(value as String);
  }

  @override
  dynamic encode(Color self) {
    return colorToHex(self);
  }
}
