import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/share_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/new_card_screen.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_popup_menu.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_card_content.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';
import 'dart:math' as math;


// const double _cellSize = 128.0; // Removed as it's in BingoCardContent or should be passed

class BingoCardScreen extends StatefulWidget {
  const BingoCardScreen({super.key});

  @override
  State<BingoCardScreen> createState() => _BingoCardScreenState();
}

class _BingoCardScreenState extends State<BingoCardScreen> {
  late final TransformationController _transformationController;

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
    final gridItems = controller.gridItems
        .watch(context); // This should work with flutter_state_beacon
    final gridSize = controller.gridSize.watch(context);
    final currentBingoName = currentSelectedBingoCardName.watch(context);

    final size = MediaQuery.sizeOf(context);
    // const cellWidth = _cellSize; // Will be handled by BingoCardContent
    // const cellHeight = _cellSize; // Square cells

    final lastChangeDateTime = controller.lastChangeDateTime.watch(context);

    // InteractiveViewer creates its own controller if not provided.

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          BingoPopupMenu(),
          // Button to reset the view of the InteractiveViewer
          // IconButton(
          //   icon: const Icon(Icons.center_focus_strong),
          //   tooltip: 'Reset View',
          //   onPressed: () {
          //     // _transformationController.value = Matrix4.identity();
          //     _centerView();
          //   },
          // ),
          SizedBox(width: 16),
        ],
      ),
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
                          SizedBox(
                            width: gridSize *
                                128.0, // Assuming _cellSize was 128.0 for EditingHint width
                            child: EditingHint(),
                          ),
                          SizedBox(height: 16),
                          ToggleHint(),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          Positioned(
            bottom: 42 + MediaQuery.of(context).padding.bottom,
            left: 16,
            right: 16,
            child: Actions(transformationController: _transformationController),
          ),
        ],
      ),
    );
  }
}

class ToggleHint extends StatelessWidget {
  const ToggleHint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = bingoCardControllerRef.of(context);
    final hasToggledOnce = controller.hasToggledOnce.watch(context);

    return AnimatedOpacity(
      opacity: hasToggledOnce ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: hasToggledOnce
            ? SizedBox()
            : Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Text(
                  'Press long to mark a field as checked',
                  style: context.p1.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({
    required this.transformationController,
    super.key,
  });

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
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: Colors.white),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () async {
                  final confirmed = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Delete Card'),
                            content: Text(
                                'Are you sure you want to delete this card?'),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text('Delete')),
                            ],
                          ));
                  if (confirmed) {
                    final name = currentSelectedBingoCardName.value;
                    if (name != null) {
                      await deleteBingoCard(name);
                      await deleteBingoCardName(name);
                      await setCurrentSelectedBingoCard(null);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => NewCardScreen()),
                          (route) => false);
                    }
                  }
                },
                icon: Icon(PhosphorIcons.trash(), color: Colors.red),
              ),
              VerticalDivider(
                color: Colors.white,
                thickness: 1,
                indent: 8,
                endIndent: 8,
                width: 8,
              ),
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
                icon: Icon(PhosphorIcons.magnifyingGlassMinus(),
                    color: Colors.white),
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
                icon: Icon(PhosphorIcons.magnifyingGlassPlus(),
                    color: Colors.white),
              ),
              VerticalDivider(
                color: Colors.white,
                thickness: 1,
                indent: 8,
                endIndent: 8,
                width: 8,
              ),
              IconButton(
                onPressed: () {
                  shareCardPopup(context);
                },
                icon: Icon(PhosphorIcons.share(), color: Colors.white),
              ),
              VerticalDivider(
                color: Colors.white,
                thickness: 1,
                indent: 8,
                endIndent: 8,
                width: 8,
              ),
              IconButton(
                onPressed: () {
                  final controller = bingoCardControllerRef.of(context);
                  controller.isEditing.value = !controller.isEditing.value;
                },
                icon: Icon(
                    isEditing
                        ? PhosphorIcons.lockOpen()
                        : PhosphorIcons.lock(PhosphorIconsStyle.fill),
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
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
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: show ? 1.0 : 0.0,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: show
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: context.p1.copyWith(color: Colors.white),
                      children: [
                        TextSpan(text: 'Press the lock icon '),
                        WidgetSpan(
                          child: Icon(
                            PhosphorIcons.lockKeyOpen(),
                            color: Colors.white,
                            size: context.p1.fontSize,
                          ),
                        ),
                        TextSpan(
                            text:
                                ' to make make the fields not editable anymore.'),
                      ],
                    ),
                    maxLines: 4,
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
