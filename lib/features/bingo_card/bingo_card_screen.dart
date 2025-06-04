import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';
import 'dart:math' as math;

import 'bingo_card_logic.dart';
import 'widgets/bingo_cell.dart';

const double _cellSize = 128.0;

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
    final gridSize = controller.gridSize;
    final screenSize = MediaQuery.sizeOf(context);

    final viewWidth = screenSize.width;
    final viewHeight = screenSize.height;

    // Dimensions of the actual bingo grid content (excluding padding)
    final contentWidth = gridSize * _cellSize;
    final contentHeight = gridSize * _cellSize;

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
    final gridSize = controller.gridSize;

    final size = MediaQuery.sizeOf(context);
    const cellWidth = _cellSize;
    const cellHeight = _cellSize; // Square cells

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
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            child: Text(
                              'Press long to mark a field as checked',
                              style: context.p1.copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 16),
                          EditingHint(),
                          SizedBox(height: 16),
                          ...List.generate(gridSize, (rowIndex) {
                            return Row(
                              children: List.generate(gridSize, (colIndex) {
                                if (rowIndex >= gridItems.length ||
                                    colIndex >= gridItems[rowIndex].length) {
                                  // Should not happen if grid is initialized correctly
                                  return SizedBox(
                                      width: cellWidth, height: cellHeight);
                                }
                                final item = gridItems[rowIndex][colIndex];
                                final isMiddleItem =
                                    gridSize ~/ 2 == rowIndex &&
                                        gridSize ~/ 2 == colIndex;
                                return BingoCell(
                                  item: item,
                                  isMiddleItem: isMiddleItem,
                                  cellWidth: cellWidth,
                                  cellHeight: cellHeight,
                                );
                              }),
                            );
                          }),
                          SizedBox(height: 16),

                          LastChange(lastChangeDateTime: lastChangeDateTime),
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

class LastChange extends StatelessWidget {
  const LastChange({
    required this.lastChangeDateTime,
    super.key,
  });

  final DateTime? lastChangeDateTime;

  @override
  Widget build(BuildContext context) {
    final date =
        '${lastChangeDateTime?.toLocal().day}.${lastChangeDateTime?.toLocal().month}.${lastChangeDateTime?.toLocal().year}';
    final time =
        '${lastChangeDateTime?.toLocal().hour}:${lastChangeDateTime?.toLocal().minute}';
    final text = lastChangeDateTime == null
        ? 'Last change: Never'
        : 'Last change: $date $time';
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: context.h5,
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

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  transformationController.value = Matrix4.identity();
                },
                icon: Icon(PhosphorIcons.magnifyingGlassMinus(),
                    color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  transformationController.value = Matrix4.identity();
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
                  final controller = bingoCardControllerRef.of(context);
                  controller.isEditing.value = !controller.isEditing.value;
                },
                icon: Icon(
                    isEditing
                        ? PhosphorIcons.lockOpen()
                        : PhosphorIcons.lock(PhosphorIconsStyle.fill),
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
                onPressed: () {},
                icon: Icon(PhosphorIcons.share(), color: Colors.white),
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
    return AnimatedOpacity(
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
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
                    // IconButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       // hide = !hide;
                    //     });
                    //   },
                    //   icon: Icon(PhosphorIcons.x(), color: Colors.white),
                    // ),
                  ],
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
