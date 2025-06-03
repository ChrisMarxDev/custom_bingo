extension IntExtension on int {
  String toThousandsString({String separator = '.'}) {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}$separator',
    );
  }
}

extension DoubleExtension on double {
  String toThousandsString({String separator = '.'}) {
    return toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}$separator',
    );
  }

  String toPercentageString() {
    return '${(this * 100).toStringAsFixed(0)}%';
  }

  String toStringFixedWithoutTrailingZero(int precision) {
    var string = toStringAsFixed(precision);
    while (string.endsWith('0')) {
      string = string.substring(0, string.length - 1);
    }
    if (string.endsWith('.')) {
      string = string.substring(0, string.length - 1);
    }
    return string;
  }
}

extension NullSafeNumberExtension on num? {
  num? add(num? other) {
    if (this == null) return null;
    if (other == null) return this;
    return this! + other;
  }

  num? subtract(num? other) {
    if (this == null) return null;
    if (other == null) return this;
    return this! - other;
  }

  String toStringFixedWithoutTrailingZero(int precision) {
    if (this == null) return '';
    if (precision <= 0) {
      return this!.toStringAsFixed(0);
    }
    var string = this!.toStringAsFixed(precision);
    while (string.endsWith('0')) {
      string = string.substring(0, string.length - 1);
    }
    if (string.endsWith('.')) {
      string = string.substring(0, string.length - 1);
    }
    return string;
  }
}
