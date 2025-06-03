import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime clearTime() {
    return DateTime(year, month, day);
  }

  bool isToday() {
    return isSameDay(DateTime.now());
  }

  bool isYesterday() {
    return isSameDay(DateTime.now());
  }

  DateTime roundToSecond() {
    return DateTime(year, month, day, hour, minute, second);
  }

  String format(String format) {
    return DateFormat(format).format(this);
  }

  String formatHeaderDate() {
    return DateFormat.Md().format(this);
  }

  String formatWeekDay() {
    return DateFormat.E().format(this);
  }

  String formatTime(BuildContext context) {
    return DateFormat.Hm().format(this).toLowerCase();
  }

  bool isSameDay(DateTime? other) {
    if (other == null) return false;
    return year == other.year && month == other.month && day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  String yMd() {
    return DateFormat.yMd().format(this);
  }

  String yMMMEd() {
    return '${DateFormat('E').format(this)} ${yMd()}';
  }

  String hhmm() {
    return DateFormat.Hm().format(this).toLowerCase();
  }

  int weekNumber() {
    // int dayOfYear = int.parse(DateFormat("D").format(date));
    // return ((dayOfYear - date.weekday + 10) / 7).floor();
    final firstDayOfYear = DateTime(year);
    final days = difference(firstDayOfYear).inDays;
    return (days / 7).ceil();
  }

  List<DateTime> datesUntil(DateTime other, {bool inclusive = false}) {
    final result = <DateTime>[];

    for (
      var i = clearTime();
      !i.isSameDay(other);
      i = i.add(const Duration(days: 1))
    ) {
      result.add(i.copyWith());
    }
    if (inclusive) {
      result.add(other.copyWith());
    }
    return result;
  }

  bool isWeekend() {
    return [DateTime.sunday, DateTime.saturday].contains(weekday);
  }
}
