import 'package:custom_bingo/app/view/app_route_paths.dart';
import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/shared_prefs.dart';
import 'package:custom_bingo/common/widgets/animated_number.dart';
import 'package:custom_bingo/common/widgets/async_elevated_button.dart';
import 'package:custom_bingo/features/bingo_card/bingo_card_logic.dart';
import 'package:custom_bingo/features/bingo_card/bingo_item.dart';
import 'package:custom_bingo/features/bingo_card/widgets/bingo_popup_menu.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tile_controller.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tiles_screen.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({this.initialBoardState, super.key});

  final BingoCardState? initialBoardState;

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen> {
  static const int _maxGridSize = 24;
  final _nameController = TextEditingController();
  var _appliedPreMadeTexts = <String>[];
  int _gridSize = 5;
  BingoCardState? get _initialBoardState => widget.initialBoardState;
  bool get _isEditingExistingBoard => _initialBoardState != null;

  @override
  void initState() {
    super.initState();
    final initialBoardState = _initialBoardState;
    if (initialBoardState == null) return;

    _nameController.text = initialBoardState.name;
    if (initialBoardState.gridItems.isNotEmpty) {
      _gridSize = initialBoardState.gridItems.length
          .clamp(2, _maxGridSize)
          .toInt();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasName = _nameController.text.trim().isNotEmpty;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditingExistingBoard ? l10n.editCardTitle : l10n.newCardTitle,
          style: context.h2,
        ),
        actions: [
          const BingoPopupMenu(host: BingoPopupMenuHost.newCard),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: NewCardForm(
          nameController: _nameController,
          gridSize: _gridSize,
          isEditingExistingBoard: _isEditingExistingBoard,
          appliedPreMadeTexts: _appliedPreMadeTexts,
          onNameChanged: (_) => setState(() {}),
          onGridSizeChanged: (newValue) {
            setState(() {
              _gridSize = newValue;
            });
          },
          onSubmit: hasName
              ? () async {
                  final name = _nameController.text.trim();
                  final gridSize = _gridSize;
                  final sharedPrefs = sharedPrefsBeacon.value;
                  final initialBoardState = _initialBoardState;
                  final gridItems = initialBoardState == null
                      ? _createGridItems(gridSize)
                      : _createEditedGridItems(
                          initialBoardState.gridItems,
                          gridSize,
                        );
                  await saveBingoCard(
                    sharedPrefs,
                    BingoCardState(
                      name: name,
                      gridItems: gridItems,
                      lastChangeDateTime: DateTime.now(),
                      isEditing: initialBoardState?.isEditing,
                    ),
                  );

                  if (initialBoardState != null &&
                      initialBoardState.name != name) {
                    await deleteBingoCard(initialBoardState.name);
                    await deleteBingoCardName(initialBoardState.name);
                  }
                  await setCurrentSelectedBingoCard(name);
                  await addBingoCardName(name);

                  await bingoCardControllerRef.of(context).loadBoard();
                  if (!context.mounted) return;

                  context.go(AppRoutePaths.bingoCard);
                }
              : null,
          onOpenPreMadeItems: _openPreMadeItemsSheet,
          onRemovePreMadeItem: (index) {
            setState(() {
              _appliedPreMadeTexts = [..._appliedPreMadeTexts]..removeAt(index);
            });
          },
        ),
      ),
    );
  }

  Future<void> _openPreMadeItemsSheet() async {
    final selectedTexts = await showModalBottomSheet<List<String>>(
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
            returnSelectedTextsOnApply: true,
          ),
        );
      },
    );
    if (selectedTexts == null || !mounted) return;

    setState(() {
      _appliedPreMadeTexts = selectedTexts;
    });
  }

  List<List<BingoItem>> _createGridItems(int gridSize) {
    final cellCount = gridSize * gridSize;
    final texts =
        _appliedPreMadeTexts
            .map((text) => text.trim())
            .where((text) => text.isNotEmpty)
            .toList()
          ..shuffle();
    final selectedTexts = texts.take(cellCount).toList();
    final cellTexts = List.filled(cellCount, '');
    final positions = List.generate(cellCount, (index) => index)..shuffle();

    for (var index = 0; index < selectedTexts.length; index += 1) {
      cellTexts[positions[index]] = selectedTexts[index];
    }

    return List.generate(
      gridSize,
      (row) => List.generate(
        gridSize,
        (column) => BingoItem(
          id: Uuid().v4(),
          text: cellTexts[row * gridSize + column],
        ),
      ),
    );
  }

  List<List<BingoItem>> _createEditedGridItems(
    List<List<BingoItem>> initialGridItems,
    int gridSize,
  ) {
    final existingItems = initialGridItems.expand((row) => row).toList();
    var nextExistingItemIndex = 0;

    return List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) {
        if (nextExistingItemIndex < existingItems.length) {
          return existingItems[nextExistingItemIndex++];
        }

        return BingoItem(id: Uuid().v4());
      }),
    );
  }
}

class NewCardForm extends StatelessWidget {
  const NewCardForm({
    required this.nameController,
    required this.gridSize,
    required this.isEditingExistingBoard,
    required this.appliedPreMadeTexts,
    required this.onNameChanged,
    required this.onGridSizeChanged,
    required this.onSubmit,
    this.onOpenPreMadeItems,
    this.onRemovePreMadeItem,
    this.maxGridSize = 24,
    this.padding = const EdgeInsets.all(16),
    this.showPreMadeSection = true,
    super.key,
  });

  final TextEditingController nameController;
  final int gridSize;
  final bool isEditingExistingBoard;
  final List<String> appliedPreMadeTexts;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<int> onGridSizeChanged;
  final Future<void> Function()? onSubmit;
  final VoidCallback? onOpenPreMadeItems;
  final void Function(int index)? onRemovePreMadeItem;
  final int maxGridSize;
  final EdgeInsetsGeometry padding;
  final bool showPreMadeSection;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: nameController,
            onChanged: onNameChanged,
            decoration: InputDecoration(
              labelText: l10n.cardNameLabel,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: l10n.cardNameHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          AnimatedNumberSelector(
            value: gridSize,
            minValue: 2,
            maxValue: maxGridSize,
            onChanged: onGridSizeChanged,
          ),
          const SizedBox(height: 24),
          Center(
            child: AsyncFilledButton(
              onPressed: onSubmit,
              child: Text(
                isEditingExistingBoard
                    ? l10n.updateCardButton
                    : l10n.createCardButton,
              ),
            ),
          ),
          const SizedBox(height: 24),
          AnimatedGridPreview(gridSize: gridSize),
          if (showPreMadeSection && !isEditingExistingBoard) ...[
            const SizedBox(height: 24),
            _PreMadeItemsPickerSection(
              appliedTexts: appliedPreMadeTexts,
              cellCount: gridSize * gridSize,
              onOpen: onOpenPreMadeItems ?? () {},
              onRemove: onRemovePreMadeItem ?? (_) {},
            ),
          ],
        ],
      ),
    );
  }
}

class _PreMadeItemsPickerSection extends StatelessWidget {
  const _PreMadeItemsPickerSection({
    required this.appliedTexts,
    required this.cellCount,
    required this.onOpen,
    required this.onRemove,
  });

  final List<String> appliedTexts;
  final int cellCount;
  final VoidCallback onOpen;
  final void Function(int index) onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final appliedCount = appliedTexts.length;
    final hasAppliedItems = appliedCount > 0;
    final usedCount = appliedCount < cellCount ? appliedCount : cellCount;
    final blankCount = cellCount - usedCount;

    return Theme(
      data: context.theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(top: 4, bottom: 64),
        initiallyExpanded: hasAppliedItems,
        iconColor: context.textColor,
        collapsedIconColor: context.textColor,
        title: Text(
          l10n.newBoardPreMadeSectionTitle,
          style: context.h4.copyWith(fontWeight: FontWeight.w800),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.tonalIcon(
              onPressed: onOpen,
              icon: const Icon(Icons.playlist_add),
              label: Text(
                hasAppliedItems
                    ? l10n.newBoardPreMadeChangeButton
                    : l10n.newBoardPreMadeButton,
              ),
            ),
          ),
          if (hasAppliedItems) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.newBoardPreMadeAppliedCount(appliedCount),
                style: context.p1.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                blankCount > 0
                    ? l10n.newBoardPreMadePartialSummary(usedCount, blankCount)
                    : l10n.newBoardPreMadeFullSummary(usedCount),
                style: context.p2.copyWith(color: context.weakTextColor),
              ),
            ),
            const SizedBox(height: 12),
            ...appliedTexts.indexed.map((entry) {
              final (index, text) = entry;
              return _AppliedPreMadeItemRow(
                text: text,
                onRemove: () => onRemove(index),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _AppliedPreMadeItemRow extends StatelessWidget {
  const _AppliedPreMadeItemRow({required this.text, required this.onRemove});

  final String text;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.p2,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              onPressed: onRemove,
              padding: EdgeInsets.zero,
              iconSize: 20,
              color: context.error,
              icon: const Icon(Icons.remove_circle_outline),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedGridPreview extends StatefulWidget {
  const AnimatedGridPreview({super.key, required this.gridSize});

  final int gridSize;

  @override
  State<AnimatedGridPreview> createState() => _AnimatedGridPreviewState();
}

class _AnimatedGridPreviewState extends State<AnimatedGridPreview> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.4;
    final hasCenter = widget.gridSize % 2 != 0;
    final totalItems = widget.gridSize * widget.gridSize;
    return Center(
      child: SizedBox(
        width: width,
        height: width,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: totalItems,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.gridSize,
          ),
          itemBuilder: (BuildContext context, int index) {
            final isMiddle = hasCenter && index == totalItems ~/ 2;
            final isTopRow = index < widget.gridSize;
            final isBottomRow = index >= totalItems - widget.gridSize;
            final isLeftColumn = index % widget.gridSize == 0;
            final isRightColumn = (index + 1) % widget.gridSize == 0;
            final borderRadius = BorderRadius.only(
              topLeft: isTopRow && isLeftColumn ? kRadiusCircular : Radius.zero,
              topRight: isTopRow && isRightColumn
                  ? kRadiusCircular
                  : Radius.zero,
              bottomLeft: isBottomRow && isLeftColumn
                  ? kRadiusCircular
                  : Radius.zero,
              bottomRight: isBottomRow && isRightColumn
                  ? kRadiusCircular
                  : Radius.zero,
            );

            return Container(
              margin: const EdgeInsets.all(0.5),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: isMiddle
                    ? context.primary.withValues(alpha: 0.12)
                    : context.surfaceContainerLowest,
                border: Border.all(
                  color: context.outlineColor,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                borderRadius: borderRadius,
              ),
            );
          },
        ),
      ),
    );
  }
}
