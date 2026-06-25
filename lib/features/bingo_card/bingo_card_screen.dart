// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math' as math;

import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/rating_prompt_service.dart';
import 'package:custom_bingo/common/services/share_card_logic.dart';
import 'package:custom_bingo/common/widgets/popup_menu.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_content.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_popup_menu.dart';
import 'package:custom_bingo/features/bingo_card/widgets/edit_hint.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tile_controller.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tiles_screen.dart';
import 'package:custom_bingo/features/settings/settings_preferences.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';

// const double _cellSize = 128.0; // Removed as it's in BingoCardContent or should be passed

class BingoCardScreen extends StatefulWidget {
  const BingoCardScreen({super.key});

  @override
  State<BingoCardScreen> createState() => _BingoCardScreenState();
}

class _BingoCardScreenState extends State<BingoCardScreen> {
  late final TransformationController _transformationController;
  final _animationKeysByItemId = <String, Object>{};
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
    _retainAnimationKeysFor(gridItems);
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
        if (enableConfettiBeacon.value) {
          Confetti.launch(
            context,
            options: const ConfettiOptions(
              particleCount: 100,
              spread: 70,
              y: 0.6,
            ),
          );
        }
        unawaited(
          ratingPromptServiceBeacon.value.maybeRequestAfterBingo(context),
        );
      }
    });
    final size = MediaQuery.sizeOf(context);
    // const cellWidth = _cellSize; // Will be handled by BingoCardContent
    // const cellHeight = _cellSize; // Square cells

    final lastChangeDateTime = controller.lastChangeDateTime.watch(context);

    // InteractiveViewer creates its own controller if not provided.

    return Scaffold(
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
                          animationKeyFor: _animationKeyFor,
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
    );
  }

  Object _animationKeyFor(String itemId) {
    return _animationKeysByItemId.putIfAbsent(itemId, () => Object());
  }

  void _retainAnimationKeysFor(List<List<BingoItem>> gridItems) {
    final itemIds = gridItems
        .expand((row) => row)
        .map((item) => item.id)
        .toSet();
    _animationKeysByItemId.removeWhere(
      (itemId, _) => !itemIds.contains(itemId),
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

    return BoardActionBarVisual(
      isEditing: isEditing,
      menu: BoardActionsPopupMenu(onShuffle: () => shuffleCard(context)),
      onZoomOut: () {
        const double scaleFactor = 1 / 1.2;
        final Matrix4 newMatrix = Matrix4.identity()
          ..translate(viewCenter.dx, viewCenter.dy)
          ..scale(scaleFactor, scaleFactor)
          ..translate(-viewCenter.dx, -viewCenter.dy);
        transformationController.value =
            newMatrix * transformationController.value;
      },
      onZoomIn: () {
        const double scaleFactor = 1.2;
        final Matrix4 newMatrix = Matrix4.identity()
          ..translate(viewCenter.dx, viewCenter.dy)
          ..scale(scaleFactor, scaleFactor)
          ..translate(-viewCenter.dx, -viewCenter.dy);
        transformationController.value =
            newMatrix * transformationController.value;
      },
      onToggleEditing: () {
        final controller = bingoCardControllerRef.of(context);
        controller.isEditing.value = !controller.isEditing.value;
      },
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

class BoardActionBarVisual extends StatelessWidget {
  const BoardActionBarVisual({
    required this.isEditing,
    required this.menu,
    required this.onZoomOut,
    required this.onZoomIn,
    required this.onToggleEditing,
    super.key,
  });

  final bool isEditing;
  final Widget menu;
  final VoidCallback onZoomOut;
  final VoidCallback onZoomIn;
  final VoidCallback onToggleEditing;

  @override
  Widget build(BuildContext context) {
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
              menu,
              const ButtonDivider(),
              IconButton(
                onPressed: onZoomOut,
                icon: Icon(
                  PhosphorIcons.magnifyingGlassMinus(),
                  color: context.onPrimary,
                ),
              ),
              IconButton(
                onPressed: onZoomIn,
                icon: Icon(
                  PhosphorIcons.magnifyingGlassPlus(),
                  color: context.onPrimary,
                ),
              ),
              const ButtonDivider(),
              IconButton(
                onPressed: onToggleEditing,
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
}

class BoardActionsPopupMenu extends StatelessWidget {
  const BoardActionsPopupMenu({required this.onShuffle, super.key});

  final VoidCallback onShuffle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PopupMenu(
      padding: const EdgeInsets.symmetric(vertical: 8),
      followerAnchor: Alignment.bottomLeft,
      targetAnchor: Alignment.topLeft,
      child: SizedBox(
        width: 48,
        height: 48,
        child: Icon(Icons.more_vert, color: context.onPrimary),
      ),
      popupMenuBuilder: (menuContext, hideOverlay) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _BoardActionMenuItem(
                icon: PhosphorIcons.trash(),
                label: l10n.delete,
                foregroundColor: context.theme.colorScheme.error,
                onPressed: () {
                  hideOverlay();
                  _deleteCard(context);
                },
              ),
              _BoardActionMenuItem(
                icon: PhosphorIcons.pencilSimple(),
                label: l10n.boardActionEditBoard,
                onPressed: () {
                  hideOverlay();
                  _editBoard(context);
                },
              ),
              _BoardActionMenuItem(
                icon: PhosphorIcons.shuffle(),
                label: l10n.shuffle,
                onPressed: () {
                  hideOverlay();
                  onShuffle();
                },
              ),
              _BoardActionMenuItem(
                icon: PhosphorIcons.share(),
                label: l10n.boardActionShare,
                onPressed: () {
                  hideOverlay();
                  shareCardPopup(context);
                },
              ),
              _BoardActionMenuItem(
                icon: PhosphorIcons.squaresFour(),
                label: l10n.boardActionAddPreMadeItems,
                onPressed: () {
                  hideOverlay();
                  _openPreMadeItemsSheet(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _editBoard(BuildContext context) {
    final name = currentSelectedBingoCardName.value;
    if (name == null) return;

    final controller = bingoCardControllerRef.of(context);
    context.go(
      AppRoutePaths.root,
      extra: BingoCardState(
        name: name,
        gridItems: controller.gridItems.value,
        lastChangeDateTime: controller.lastChangeDateTime.value,
        isEditing: controller.isEditing.value,
      ),
    );
  }

  Future<void> _openPreMadeItemsSheet(BuildContext context) async {
    final controller = bingoCardControllerRef.of(context);
    final result = await showModalBottomSheet<PreMadeTileBoardActionResult>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.9,
          child: const PreMadeTilesScreen(
            initialMode: PreMadeTileMode.selecting,
            showBoardActionButtons: true,
          ),
        );
      },
    );
    if (result == null) return;

    switch (result.action) {
      case PreMadeTileBoardAction.replaceItems:
        controller.replaceItemsWithPreMade(result.selectedTexts);
      case PreMadeTileBoardAction.fillItems:
        controller.fillEmptyItemsWithPreMade(result.selectedTexts);
    }
  }

  Future<void> _deleteCard(BuildContext context) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
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
    if (confirmed != true) return;

    final name = currentSelectedBingoCardName.value;
    if (name == null) return;

    await deleteBingoCard(name);
    await deleteBingoCardName(name);
    await setCurrentSelectedBingoCard(null);
    if (!context.mounted) return;

    context.go(
      getBingoCardNames().isEmpty ? AppRoutePaths.root : AppRoutePaths.home,
    );
  }
}

class _BoardActionMenuItem extends StatelessWidget {
  const _BoardActionMenuItem({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.foregroundColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final color = foregroundColor ?? context.textColor;
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Flexible(
            child: Text(label, style: context.p1.copyWith(color: color)),
          ),
        ],
      ),
    );
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
