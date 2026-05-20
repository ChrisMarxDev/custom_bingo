import 'dart:io';

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/share_link.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_content.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareCardPopup(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) => const ShareCardDialog(),
  );
}

class ShareCardDialog extends StatefulWidget {
  const ShareCardDialog({super.key});

  @override
  State<ShareCardDialog> createState() => _ShareCardDialogState();
}

class _ShareCardDialogState extends State<ShareCardDialog> {
  late final ScreenshotController _screenshotController;
  bool _includeMarks = false;

  @override
  void initState() {
    super.initState();
    _screenshotController = ScreenshotController();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const SizedBox(width: 40),
                  Expanded(
                    child: Text(
                      l10n.shareTitle,
                      textAlign: TextAlign.center,
                      style: context.h3,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    tooltip: l10n.close,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    _CardPreview(controller: _screenshotController),
                    const SizedBox(height: 16),
                    Text(
                      l10n.shareDialogPrompt,
                      textAlign: TextAlign.center,
                      style: context.p2.copyWith(color: context.weakTextColor),
                    ),
                    const SizedBox(height: 12),
                    _ShareImageOption(controller: _screenshotController),
                    const SizedBox(height: 12),
                    _ShareInviteOption(
                      includeMarks: _includeMarks,
                      onIncludeMarksChanged: (v) =>
                          setState(() => _includeMarks = v),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l10n.close),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardPreview extends StatelessWidget {
  const _CardPreview({required this.controller});
  final ScreenshotController controller;

  static const double _previewMaxHeight = 220;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.background,
        border: Border.all(color: context.primary, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: _previewMaxHeight,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topCenter,
                child: Screenshot(
                  controller: controller,
                  child: IgnorePointer(
                    child: ColoredBox(
                      color: context.background,
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: BingoCardContentWrapper(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShareImageOption extends StatelessWidget {
  const _ShareImageOption({required this.controller});
  final ScreenshotController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _ShareOptionCard(
      icon: PhosphorIcons.image(),
      title: l10n.shareImageOptionTitle,
      helper: l10n.shareImageOptionHelper,
      buttonLabel: l10n.shareImageOptionButton,
      onPressed: (buttonContext) => _shareImage(buttonContext, controller),
    );
  }
}

Future<void> _shareImage(
  BuildContext buttonContext,
  ScreenshotController controller,
) async {
  final l10n = buttonContext.l10n;
  final imageData = await controller.capture();
  if (imageData == null) return;

  final tempDir = await getTemporaryDirectory();
  final tempPath =
      '${tempDir.path}/bingo_share_${DateTime.now().millisecondsSinceEpoch}.png';
  await File(tempPath).writeAsBytes(imageData);

  await Share.shareXFiles(
    [XFile(tempPath)],
    subject: l10n.shareSubject,
    text: l10n.shareSubject,
    sharePositionOrigin: _sharePositionOrigin(buttonContext),
  );
}

class _ShareInviteOption extends StatelessWidget {
  const _ShareInviteOption({
    required this.includeMarks,
    required this.onIncludeMarksChanged,
  });

  final bool includeMarks;
  final ValueChanged<bool> onIncludeMarksChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _ShareOptionCard(
      icon: PhosphorIcons.gameController(),
      title: l10n.shareInviteOptionTitle,
      helper: l10n.shareInviteOptionHelper,
      buttonLabel: l10n.shareInviteOptionButton,
      onPressed: (buttonContext) => _shareInvite(buttonContext, includeMarks),
      extra: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Switch.adaptive(
                  value: includeMarks,
                  onChanged: onIncludeMarksChanged,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(l10n.shareInviteIncludeMarks, style: context.p2),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                l10n.shareInviteIncludeMarksHelper,
                style: context.p2.copyWith(
                  color: context.weakTextColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _shareInvite(BuildContext buttonContext, bool includeMarks) async {
  final l10n = buttonContext.l10n;

  final controller = bingoCardControllerRef.of(buttonContext);
  final name = currentSelectedBingoCardName.value ?? l10n.defaultCardName;
  final state = BingoCardState(
    name: name,
    gridItems: controller.gridItems.value,
    lastChangeDateTime: controller.lastChangeDateTime.value,
  );

  final link = encodeShareLink(state, includeMarks: includeMarks).toString();
  final body = l10n.shareInviteText(name, link);

  await Share.share(
    body,
    subject: l10n.shareSubject,
    sharePositionOrigin: _sharePositionOrigin(buttonContext),
  );
}

class _ShareOptionCard extends StatelessWidget {
  const _ShareOptionCard({
    required this.icon,
    required this.title,
    required this.helper,
    required this.buttonLabel,
    required this.onPressed,
    this.extra,
  });

  final IconData icon;
  final String title;
  final String helper;
  final String buttonLabel;
  final Future<void> Function(BuildContext buttonContext) onPressed;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.outlineColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: context.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: context.h5.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            helper,
            style: context.p2.copyWith(color: context.weakTextColor),
          ),
          if (extra != null) extra!,
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Builder(
              builder: (buttonContext) => FilledButton(
                onPressed: () => onPressed(buttonContext),
                child: Text(buttonLabel),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Rect? _sharePositionOrigin(BuildContext context) {
  final renderBox = context.findRenderObject() as RenderBox?;
  if (renderBox == null || !renderBox.hasSize) return null;
  return renderBox.localToGlobal(Offset.zero) & renderBox.size;
}
