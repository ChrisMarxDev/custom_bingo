import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:drops/drops.dart';
import 'package:flutter/material.dart';

Future<void> showNeutralToast(BuildContext context, String message) async {
  Drops.show(
    context,
    title: 'Info',
    subtitle: message,
    subtitleMaxLines: 3,
    icon: Icons.info,
    iconColor: context.primary,
    subtitleTextStyle: context.p2,
  );
}

Future<void> showSuccessToast(BuildContext context, String message) async {
  Drops.show(
    context,
    title: 'Success',
    subtitle: message,
    icon: Icons.check_circle,
    iconColor: context.primary,
    subtitleMaxLines: 3,
    subtitleTextStyle: context.p2,
  );
}

Future<void> showErrorToast(BuildContext context, String message) async {
  Drops.show(
    context,
    title: 'Error',
    subtitle: message,
    icon: Icons.error,
    isDestructive: true,
    subtitleMaxLines: 3,
    subtitleTextStyle: context.p2,
    iconColor: context.error,
  );
}
