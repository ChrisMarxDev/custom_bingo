// ignore_for_file: deprecated_member_use

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/share_card_logic.dart';
import 'package:custom_bingo/common/widgets/inherited_provider.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_popup_menu.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_content.dart';
import 'package:custom_bingo/features/bingo_card/widgets/edit_hint.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';
import 'dart:math' as math;

// const double _cellSize = 128.0; // Removed as it's in BingoCardContent or should be passed

class ShouldAnimate {
  final bool shouldAnimate;

  ShouldAnimate({this.shouldAnimate = true});
}

class BingoCardScreen extends StatefulWidget {
  const BingoCardScreen({super.key});

  @override
  State<BingoCardScreen> createState() => _BingoCardScreenState();
}

class _BingoCardScreenState extends State<BingoCardScreen> {
  late final TransformationController _transformationController;
  String? _lastCenteredBoardName;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _centerView();
      }
    });
  }

  void _centerView() {
    if (!mounted) return;

    final controller = bingoCardControllerRef.of(context);
    final gridSize = controller.gridSize.value;
    final screenSize = MediaQuery.sizeOf(context);

    final viewWidth = screenSize.width;
    final viewHeight = screenSize.height;

    // Dimensions of the actual bingo grid content (excluding padding)
    final contentWidth =
        gridSize * 128.0; // Assuming _cellSize was 128.0 for EditingHint width
    final contentHeight =
        gridSize * 128.0; // Assuming _cellSize was 128.0 for EditingHint width

    const paddingValue = 24.0; // From Container's EdgeInsets.all(24)
    final totalContentWidthWithPadding = contentWidth + 2 * paddingValue;
    final totalContentHeightWithPadding = contentHeight + 2 * paddingValue;

    if (totalContentWidthWithPadding <= 0 ||
        totalContentHeightWithPadding <= 0) {
      _transformationController.value = Matrix4.identity();
      return;
    }

    // Use minScale and maxScale from the InteractiveViewer widget itself
    const minScaleFromViewer = 0.7;
    const maxScaleFromViewer = 2.0;

    double scaleX = viewWidth / totalContentWidthWithPadding;
    double scaleY = viewHeight / totalContentHeightWithPadding;
    double newScale = math.min(scaleX, scaleY);

    // Clamp scale by InteractiveViewer's properties
    final clampedScale = newScale.clamp(minScaleFromViewer, maxScaleFromViewer);

    final scaledChildWidth = totalContentWidthWithPadding * clampedScale;
    final scaledChildHeight = totalContentHeightWithPadding * clampedScale;

    final translateX = (viewWidth - scaledChildWidth) / 2;
    final translateY = (viewHeight - scaledChildHeight) / 2;

    _transformationController.value = Matrix4.identity()
      ..translate(translateX, translateY)
      ..scale(clampedScale);
  }

  @override
  Widget build(BuildContext context) {
    final controller = bingoCardControllerRef.of(context);
    final gridItems = controller.gridItems.watch(
      context,
    ); // This should work with flutter_state_beacon
    final currentBingoName = currentSelectedBingoCardName.watch(context);
    if (_lastCenteredBoardName != currentBingoName) {
      _lastCenteredBoardName = currentBingoName;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _centerView();
        }
      });
    }

    controller.hasBingoTime.observe(context, (prev, next) {
      if (next != null) {
        Confetti.launch(
          context,
          options: const ConfettiOptions(
            particleCount: 100,
            spread: 70,
            y: 0.6,
          ),
        );
      }
    });
    final size = MediaQuery.sizeOf(context);
    // const cellWidth = _cellSize; // Will be handled by BingoCardContent
    // const cellHeight = _cellSize; // Square cells

    final lastChangeDateTime = controller.lastChangeDateTime.watch(context);

    // InteractiveViewer creates its own controller if not provided.

    return InheritedProvider<ShouldAnimate>(
      value: ShouldAnimate(shouldAnimate: true),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            InteractiveViewer.builder(
              transformationController: _transformationController,
              boundaryMargin: EdgeInsets.only(
                bottom: size.height * 0.7,
                top: size.height * 0.5,
                left: size.width * 0.6,
                right: size.width * 0.6,
              ),
              // alignment: Alignment.topCenter,
              minScale: 0.2,
              maxScale: 2.0,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.only(
                    top: 24,
                    left: 24,
                    right: 24,
                    bottom: 48,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width,
                          //   child: EditingHint(),
                          // ),
                          // SizedBox(height: 16),
                          BingoCardContent(
                            gridItems: gridItems,
                            lastChangeDateTime: lastChangeDateTime,
                            currentSelectedBingoCardName: currentBingoName,
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: kToolbarHeight + 8,
              right: 8,
              child: const BingoPopupMenu(host: BingoPopupMenuHost.board),
            ),
            Positioned(
              bottom: 42 + MediaQuery.of(context).padding.bottom,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  EditingHint(),
                  SizedBox(height: 8),
                  ToggleHint(),
                  SizedBox(height: 8),
                  Actions(transformationController: _transformationController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleHint extends StatelessWidget {
  const ToggleHint({super.key});

  @override
  Widget build(BuildContext context) {
    return HintWidget(
      hintId: toggleHintId,
      child: Text(
        context.l10n.toggleHint,
        style: context.p1.copyWith(color: context.textColor),
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({required this.transformationController, super.key});

  final TransformationController transformationController;

  @override
  Widget build(BuildContext context) {
    final controller = bingoCardControllerRef.of(context);
    final isEditing = controller.isEditing.watch(context);
    final screenSize = MediaQuery.sizeOf(context);
    final viewCenter = Offset(screenSize.width / 2, screenSize.height / 2);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: context.primary,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: context.outlineColor),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  final l10n = context.l10n;
                  final confirmed = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.deleteCardTitle),
                      content: Text(l10n.deleteCardConfirm),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(l10n.cancel),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(l10n.delete),
                        ),
                      ],
                    ),
                  );
                  if (confirmed) {
                    final name = currentSelectedBingoCardName.value;
                    if (name != null) {
                      await deleteBingoCard(name);
                      await deleteBingoCardName(name);
                      await setCurrentSelectedBingoCard(null);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => NewCardScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  }
                },
                icon: Icon(PhosphorIcons.trash(), color: context.error),
              ),
              ButtonDivider(),
              IconButton(
                onPressed: () {
                  // Zoom out
                  const double scaleFactor = 1 / 1.2;
                  final Matrix4 newMatrix = Matrix4.identity()
                    ..translate(viewCenter.dx, viewCenter.dy)
                    ..scale(scaleFactor, scaleFactor)
                    ..translate(-viewCenter.dx, -viewCenter.dy);
                  transformationController.value =
                      newMatrix * transformationController.value;
                },
                icon: Icon(
                  PhosphorIcons.magnifyingGlassMinus(),
                  color: context.onPrimary,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Zoom in
                  const double scaleFactor = 1.2;
                  final Matrix4 newMatrix = Matrix4.identity()
                    ..translate(viewCenter.dx, viewCenter.dy)
                    ..scale(scaleFactor, scaleFactor)
                    ..translate(-viewCenter.dx, -viewCenter.dy);
                  transformationController.value =
                      newMatrix * transformationController.value;
                },
                icon: Icon(
                  PhosphorIcons.magnifyingGlassPlus(),
                  color: context.onPrimary,
                ),
              ),
              ButtonDivider(),
              IconButton(
                onPressed: () {
                  shareCardPopup(context);
                },
                icon: Icon(PhosphorIcons.share(), color: context.onPrimary),
              ),
              ButtonDivider(),
              IconButton(
                onPressed: () {
                  shuffleCard(context);
                },
                icon: Icon(PhosphorIcons.shuffle(), color: context.onPrimary),
              ),
              ButtonDivider(),
              IconButton(
                onPressed: () {
                  final controller = bingoCardControllerRef.of(context);
                  controller.isEditing.value = !controller.isEditing.value;
                },
                icon: Icon(
                  isEditing
                      ? PhosphorIcons.lockOpen()
                      : PhosphorIcons.lock(PhosphorIconsStyle.fill),
                  color: context.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> shuffleCard(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.shuffleCardTitle),
        content: Text(l10n.shuffleCardConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.shuffle),
          ),
        ],
      ),
    );
    if (!confirmed) return;
    final controller = bingoCardControllerRef.of(context);
    controller.shuffleCard();
  }
}

class ButtonDivider extends StatelessWidget {
  const ButtonDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: context.onPrimary.withValues(alpha: 0.45),
      thickness: 1,
      indent: 8,
      endIndent: 8,
      width: 2,
    );
  }
}

class EditingHint extends StatefulWidget {
  const EditingHint({super.key});

  @override
  State<EditingHint> createState() => _EditingHintState();
}

class _EditingHintState extends State<EditingHint> {
  @override
  Widget build(BuildContext context) {
    final controller = bingoCardControllerRef.of(context);
    final isEditing = controller.isEditing.watch(context);

    final show = isEditing;
    return HintWidget(
      hintId: editingHintId,
      show: show,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: context.p1.copyWith(color: context.textColor),
          children: [
            TextSpan(text: context.l10n.editingHintBefore),
            WidgetSpan(
              child: Icon(
                PhosphorIcons.lockKeyOpen(),
                color: context.textColor,
                size: context.p1.fontSize,
              ),
            ),
            TextSpan(text: context.l10n.editingHintAfter),
          ],
        ),
        maxLines: 4,
      ),
    );
  }
}
