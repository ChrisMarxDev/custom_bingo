import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/user_id.dart';
import 'package:custom_bingo/features/settings/theme_settings.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userorient_flutter/userorient_flutter.dart';

void openUserOrient(BuildContext context) {
  UserOrient.setUser(uniqueIdentifier: userIdBeacon.value);

  UserOrient.openBoard(context);
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeMode = appThemeModeBeacon.watch(context);
    final themePalette = appThemePaletteBeacon.watch(context);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsHeader, style: context.h2)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SettingsSection(
            title: l10n.appearanceMenuItem,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.themeColorLabel,
                  style: context.h5.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (final palette in appThemePalettes)
                      _ThemePaletteOption(
                        palette: palette,
                        isSelected: palette.id == themePalette.id,
                        onTap: () => setAppThemePalette(palette),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  value: isDarkMode,
                  onChanged: (value) {
                    setAppThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  },
                  title: Text(
                    l10n.darkModeLabel,
                    style: context.p1.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: kBorderRadius,
        border: Border.all(color: context.weakestTextColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.h4.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _ThemePaletteOption extends StatelessWidget {
  const _ThemePaletteOption({
    required this.palette,
    required this.isSelected,
    required this.onTap,
  });

  final AppThemePalette palette;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: kBorderRadius,
      child: AnimatedContainer(
        duration: kDurationQuick,
        curve: Curves.easeInOut,
        width: 92,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: kBorderRadius,
          border: Border.all(
            color: isSelected ? palette.primary : context.outlineColor,
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: palette.primary.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _PaletteDot(
              color: palette.primary,
              foregroundColor: palette.onPrimary,
              label: 'Aa',
              isSelected: isSelected,
            ),
            const SizedBox(width: 8),
            _PaletteDot(
              color: palette.secondary,
              foregroundColor: palette.onSecondary,
              label: 'Aa',
            ),
          ],
        ),
      ),
    );
  }
}

class _PaletteDot extends StatelessWidget {
  const _PaletteDot({
    required this.color,
    required this.foregroundColor,
    required this.label,
    this.isSelected = false,
  });

  final Color color;
  final Color foregroundColor;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(999)),
      ),
      child: Text(
        label,
        style: context.caption.copyWith(
          color: foregroundColor,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }
}

class KoFiButton extends StatelessWidget {
  const KoFiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        launchUrl(Uri.parse('https://ko-fi.com/chrismarx'));
      },
      style: FilledButton.styleFrom(),
      child: Row(
        children: [
          SvgPicture.asset('assets/images/ko-fi.svg', height: 24),
          const SizedBox(width: 8),
          Text(context.l10n.supportKoFi),
        ],
      ),
    );
  }
}
