import 'dart:async';

import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/premium_service.dart';
import 'package:custom_bingo/common/services/revenue_cat_service.dart';
import 'package:custom_bingo/common/services/user_id.dart';
import 'package:custom_bingo/common/services/userorient_service.dart';
import 'package:custom_bingo/common/widgets/premium_gate.dart';
import 'package:custom_bingo/features/settings/app_locale_settings.dart';
import 'package:custom_bingo/features/settings/settings_preferences.dart';
import 'package:custom_bingo/features/settings/theme_settings.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:userorient_flutter/userorient_flutter.dart';

Future<void> openUserOrient(BuildContext context) async {
  final userId = userIdBeacon.value;
  final isPremiumUser = isPremiumUserBeacon.value;
  UserOrient.setUser(
    uniqueIdentifier: userId,
    extra: userOrientUserExtra(isPremiumUser: isPremiumUser),
  );

  await UserOrient.openBoard(context);
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeMode = appThemeModeBeacon.watch(context);
    final themePalette = appThemePaletteBeacon.watch(context);
    final isPremiumUser = isPremiumUserBeacon.watch(context);
    final enableConfetti = enableConfettiBeacon.watch(context);
    final selectedLocale = appLocaleOverrideBeacon.watch(context);
    final phoneLocale = phoneLocaleBeacon.watch(context);
    final effectiveThemePalette = availableAppThemePalette(
      themePalette,
      isPremiumUser: isPremiumUser,
    );
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsHeader, style: context.h2)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _SettingsSection(
            title: l10n.settingsSupportSection,
            children: [
              _SettingsTile(
                title: l10n.supportMeDirectly,
                subtitle: l10n.supportMeDirectlySettingsDescription,
                icon: PhosphorIcons.heart(),
                onTap: () => context.push(AppRoutePaths.paywall),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: l10n.settingsAppearanceSection,
            children: [
              _SettingsTile(
                title: l10n.darkModeLabel,
                subtitle: l10n.darkModeSettingsDescription,
                icon: PhosphorIcons.moon(),
                onTap: () {
                  setAppThemeMode(
                    isDarkMode ? ThemeMode.light : ThemeMode.dark,
                  );
                },
                trailing: Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (value) {
                    setAppThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ),
              _ThemePaletteSettingsTile(
                selectedPalette: effectiveThemePalette,
                onPaletteSelected: setAppThemePalette,
              ),
              _LanguageSettingsTile(
                selectedLocale: selectedLocale,
                phoneLocale: phoneLocale,
                onLocaleSelected: setAppLocaleOverride,
              ),
              _SettingsTile(
                title: l10n.enableConfettiLabel,
                subtitle: l10n.enableConfettiSettingsDescription,
                icon: PhosphorIcons.sparkle(),
                onTap: () => setEnableConfetti(!enableConfetti),
                trailing: Switch.adaptive(
                  value: enableConfetti,
                  onChanged: setEnableConfetti,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SettingsSection(
            title: l10n.settingsHelpSection,
            children: [
              _SettingsTile(
                title: l10n.proposeFeatures,
                subtitle: l10n.proposeFeaturesSettingsDescription,
                icon: PhosphorIcons.chats(),
                onTap: () => unawaited(openUserOrient(context)),
              ),
              _SettingsTile(
                title: l10n.rateTheApp,
                subtitle: l10n.rateTheAppSettingsDescription,
                icon: PhosphorIcons.star(),
                onTap: () => unawaited(_rateTheApp()),
              ),
              _SettingsTile(
                title: l10n.contactMe,
                subtitle: l10n.contactMeSettingsDescription,
                icon: PhosphorIcons.envelopeSimple(),
                onTap: () => unawaited(_contactMe()),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _RevenueCatUserIdFooter(),
        ],
      ),
    );
  }
}

Future<void> _rateTheApp() async {
  final inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()) {
    await inAppReview.requestReview();
  }
}

Future<void> _contactMe() async {
  await launchUrl(
    Uri(scheme: 'mailto', path: 'custombingo@christopher-marx.de'),
  );
}

class _RevenueCatUserIdFooter extends StatelessWidget {
  const _RevenueCatUserIdFooter();

  @override
  Widget build(BuildContext context) {
    final revenueCatState = revenueCatStateBeacon.watch(context);
    final userId =
        revenueCatState.customerInfo?.originalAppUserId ?? userIdBeacon.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SelectableText(
              'RevenueCat user id: $userId',
              style: context.caption.copyWith(color: context.weakTextColor),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            tooltip: 'Copy RevenueCat user id',
            iconSize: 16,
            color: context.weakTextColor,
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: userId));
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('RevenueCat user id copied.')),
              );
            },
            icon: Icon(PhosphorIcons.copy()),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title.toUpperCase(),
            style: context.caption.copyWith(
              color: context.weakTextColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              for (var index = 0; index < children.length; index++) ...[
                children[index],
                if (index < children.length - 1)
                  Divider(height: 1, indent: 66, color: context.outlineColor),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.icon,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.child,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final tile = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              _SettingsIcon(icon: icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.p1.copyWith(fontWeight: FontWeight.w800),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: context.p2.copyWith(
                          color: context.weakTextColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
              if (onTap != null && trailing == null)
                Icon(PhosphorIcons.caretRight(), color: context.weakTextColor),
            ],
          ),
          if (child != null) ...[
            const SizedBox(height: 12),
            Align(alignment: Alignment.centerLeft, child: child),
          ],
        ],
      ),
    );

    if (onTap == null) return tile;

    return InkWell(onTap: onTap, borderRadius: kBorderRadius, child: tile);
  }
}

class _SettingsIcon extends StatelessWidget {
  const _SettingsIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: context.primary.withValues(alpha: 0.14),
        borderRadius: kBorderradiusSmall,
      ),
      child: Icon(icon, color: context.primary, size: 22),
    );
  }
}

class _LanguageSettingsTile extends StatelessWidget {
  const _LanguageSettingsTile({
    required this.selectedLocale,
    required this.phoneLocale,
    required this.onLocaleSelected,
  });

  final Locale? selectedLocale;
  final Locale phoneLocale;
  final ValueChanged<Locale?> onLocaleSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final phoneLanguage =
        appLanguageFor(phoneLocale)?.nativeName ??
        phoneLocale.languageCode.toUpperCase();
    final dropdownValue = selectedLocale?.languageCode;

    return _SettingsTile(
      title: l10n.languageSettingsTitle,
      subtitle: selectedLocale == null
          ? l10n.languageSettingsSystemDescription(phoneLanguage)
          : l10n.languageSettingsOverrideDescription,
      icon: PhosphorIcons.translate(),
      child: DropdownButtonFormField<String?>(
        initialValue: dropdownValue,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: l10n.languageSettingsSelectorLabel,
        ),
        items: [
          DropdownMenuItem<String?>(
            child: Text(l10n.languageSettingsSystemOption(phoneLanguage)),
          ),
          for (final language in supportedAppLanguages)
            DropdownMenuItem<String?>(
              value: language.locale.languageCode,
              child: Text(language.nativeName),
            ),
        ],
        onChanged: (languageCode) {
          onLocaleSelected(
            supportedAppLanguageByCode(languageCode ?? '')?.locale,
          );
        },
      ),
    );
  }
}

class _ThemePaletteSettingsTile extends StatelessWidget {
  const _ThemePaletteSettingsTile({
    required this.selectedPalette,
    required this.onPaletteSelected,
  });

  final AppThemePalette selectedPalette;
  final ValueChanged<AppThemePalette> onPaletteSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _SettingsTile(
      title: l10n.themeColorLabel,
      subtitle: l10n.themeColorSettingsDescription,
      icon: PhosphorIcons.paintBrush(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = 12.0;
          final columnCount = constraints.maxWidth >= 320 ? 3 : 2;
          final tileWidth =
              (constraints.maxWidth - spacing * (columnCount - 1)) /
              columnCount;

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (final palette in appThemePalettes)
                SizedBox(
                  width: tileWidth,
                  child: _ThemePaletteOption(
                    palette: palette,
                    isSelected: palette.id == selectedPalette.id,
                    onTap: () => onPaletteSelected(palette),
                  ),
                ),
            ],
          );
        },
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
    final swatch = AnimatedContainer(
      duration: kDurationQuick,
      curve: Curves.easeInOut,
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
    );

    if (palette.isPremium) {
      return PremiumGate(onUnlockedTap: onTap, child: swatch);
    }

    return InkWell(onTap: onTap, borderRadius: kBorderRadius, child: swatch);
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
