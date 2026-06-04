import 'dart:async';

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/app_database.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tile_controller.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';

class PreMadeTilesScreen extends StatefulWidget {
  const PreMadeTilesScreen({
    this.initialMode = PreMadeTileMode.editing,
    this.returnSelectedTextsOnApply = false,
    this.showBoardActionButtons = false,
    super.key,
  });

  final PreMadeTileMode initialMode;
  final bool returnSelectedTextsOnApply;
  final bool showBoardActionButtons;

  @override
  State<PreMadeTilesScreen> createState() => _PreMadeTilesScreenState();
}

class _PreMadeTilesScreenState extends State<PreMadeTilesScreen> {
  bool _appliedInitialMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_appliedInitialMode) return;

    preMadeTileControllerRef.of(context).setMode(widget.initialMode);
    _appliedInitialMode = true;
  }

  @override
  Widget build(BuildContext context) {
    final controller = preMadeTileControllerRef.of(context);
    final tiles = controller.tiles.watch(context);
    final drafts = controller.drafts.watch(context);
    final mode = controller.mode.watch(context);
    final isLoading = controller.isLoading.watch(context);
    final isSelecting = mode == PreMadeTileMode.selecting;
    _ensureEmptyDraft(controller, drafts, isLoading);
    final filledDrafts = drafts
        .where((draft) => draft.text.trim().isNotEmpty)
        .toList();
    final selectedCount =
        tiles.where((tile) => tile.isSelected).length +
        filledDrafts.where((draft) => draft.isSelected).length;
    final totalCount = tiles.length + filledDrafts.length;
    final allSelected = totalCount > 0 && selectedCount == totalCount;
    final l10n = context.l10n;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final showApplyButton =
        isSelecting && !widget.showBoardActionButtons && !isKeyboardVisible;
    final contentBottomPadding = isSelecting
        ? (widget.showBoardActionButtons
              ? 168.0
              : showApplyButton
              ? 112.0
              : 32.0)
        : 86.0;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.preMadeTilesTitle, style: context.h2)),
      floatingActionButton: showApplyButton
          ? _PreMadePrimaryButton(
              onPressed: () async {
                if (widget.returnSelectedTextsOnApply) {
                  final selectedTexts = await controller
                      .selectedTextsSnapshot();
                  if (!context.mounted) return;
                  Navigator.of(context).pop(selectedTexts);
                  return;
                }

                if (context.canPop()) {
                  context.pop();
                }
              },
              icon: Icon(PhosphorIcons.check()),
              label: Text(l10n.preMadeTilesApply),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: isSelecting && widget.showBoardActionButtons
          ? _BoardSelectionActions(
              hasSelection: selectedCount > 0,
              onReplace: () {
                unawaited(
                  _finishBoardAction(
                    controller,
                    PreMadeTileBoardAction.replaceItems,
                  ),
                );
              },
              onFill: () {
                unawaited(
                  _finishBoardAction(
                    controller,
                    PreMadeTileBoardAction.fillItems,
                  ),
                );
              },
            )
          : null,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.preMadeTilesTitle,
                    style: context.h2.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.preMadeTilesDescription,
                    style: context.p1.copyWith(color: context.weakTextColor),
                  ),
                  if (isSelecting) ...[
                    const SizedBox(height: 16),
                    _SelectAllRow(
                      selectedCount: selectedCount,
                      totalCount: totalCount,
                      allSelected: allSelected,
                      onToggle: () {
                        unawaited(controller.setAllSelected(!allSelected));
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isLoading)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: CircularProgressIndicator()),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.separated(
                itemCount: tiles.length + drafts.length,
                findItemIndexCallback: (key) =>
                    _findTileRowIndex(key, tiles, drafts),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  if (index < tiles.length) {
                    final tile = tiles[index];
                    return _SavedTileRow(
                      key: ValueKey('saved-tile-${tile.id}'),
                      tile: tile,
                      controller: controller,
                      isSelecting: isSelecting,
                    );
                  }

                  final draft = drafts[index - tiles.length];
                  return _DraftTileRow(
                    key: ValueKey('draft-tile-${draft.id}'),
                    draft: draft,
                    controller: controller,
                    isSelecting: isSelecting,
                    bottomPadding: draft.text.trim().isEmpty ? 32 : 0,
                  );
                },
              ),
            ),
          SliverToBoxAdapter(child: SizedBox(height: contentBottomPadding)),
        ],
      ),
    );
  }

  Future<void> _finishBoardAction(
    PreMadeTileController controller,
    PreMadeTileBoardAction action,
  ) async {
    final navigator = Navigator.of(context);
    final selectedTexts = await controller.selectedTextsSnapshot();
    navigator.pop(
      PreMadeTileBoardActionResult(
        action: action,
        selectedTexts: selectedTexts,
      ),
    );
  }

  void _ensureEmptyDraft(
    PreMadeTileController controller,
    List<PreMadeTileDraft> drafts,
    bool isLoading,
  ) {
    if (isLoading || drafts.any((draft) => draft.text.trim().isEmpty)) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final latestDrafts = controller.drafts.value;
      if (latestDrafts.any((draft) => draft.text.trim().isEmpty)) return;

      controller.addDraft();
    });
  }

  int? _findTileRowIndex(
    Key key,
    List<PreMadeTile> tiles,
    List<PreMadeTileDraft> drafts,
  ) {
    if (key is! ValueKey<String>) return null;

    final value = key.value;
    const savedPrefix = 'saved-tile-';
    if (value.startsWith(savedPrefix)) {
      final id = int.tryParse(value.substring(savedPrefix.length));
      if (id == null) return null;
      final tileIndex = tiles.indexWhere((tile) => tile.id == id);
      return tileIndex == -1 ? null : tileIndex;
    }

    const draftPrefix = 'draft-tile-';
    if (value.startsWith(draftPrefix)) {
      final id = int.tryParse(value.substring(draftPrefix.length));
      if (id == null) return null;
      final draftIndex = drafts.indexWhere((draft) => draft.id == id);
      return draftIndex == -1 ? null : tiles.length + draftIndex;
    }

    return null;
  }
}

enum PreMadeTileBoardAction { replaceItems, fillItems }

class PreMadeTileBoardActionResult {
  const PreMadeTileBoardActionResult({
    required this.action,
    required this.selectedTexts,
  });

  final PreMadeTileBoardAction action;
  final List<String> selectedTexts;
}

class _SavedTileRow extends StatefulWidget {
  const _SavedTileRow({
    required this.tile,
    required this.controller,
    required this.isSelecting,
    super.key,
  });

  final PreMadeTile tile;
  final PreMadeTileController controller;
  final bool isSelecting;

  @override
  State<_SavedTileRow> createState() => _SavedTileRowState();
}

class _SavedTileRowState extends State<_SavedTileRow> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.tile.tileText);
    _focusNode = FocusNode();
    _focusNode.addListener(_saveWhenUnfocused);
  }

  @override
  void didUpdateWidget(covariant _SavedTileRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tile.id != widget.tile.id) {
      _textController.text = widget.tile.tileText;
      return;
    }
    if (!_focusNode.hasFocus && _textController.text != widget.tile.tileText) {
      _textController.text = widget.tile.tileText;
    }
  }

  @override
  void dispose() {
    unawaited(
      widget.controller.updateTileText(widget.tile, _textController.text),
    );
    _focusNode.removeListener(_saveWhenUnfocused);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _saveWhenUnfocused() {
    if (_focusNode.hasFocus) return;
    unawaited(
      widget.controller.updateTileText(widget.tile, _textController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _TileRowShell(
      isSelecting: widget.isSelecting,
      showSelectionControl: true,
      isSelected: widget.tile.isSelected,
      onSelectionChanged: (value) {
        unawaited(widget.controller.updateTileSelection(widget.tile, value));
      },
      trailing: IconButton(
        tooltip: context.l10n.preMadeTilesDelete,
        onPressed: () {
          unawaited(widget.controller.deleteTile(widget.tile));
        },
        color: context.theme.colorScheme.error,
        icon: Icon(PhosphorIcons.trash()),
      ),
      child: TextField(
        controller: _textController,
        focusNode: _focusNode,
        minLines: 1,
        maxLines: 3,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) {
          unawaited(
            widget.controller.updateTileText(widget.tile, _textController.text),
          );
        },
        decoration: InputDecoration(
          hintText: context.l10n.preMadeTileHint,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _DraftTileRow extends StatefulWidget {
  const _DraftTileRow({
    required this.draft,
    required this.controller,
    required this.isSelecting,
    required this.bottomPadding,
    super.key,
  });

  final PreMadeTileDraft draft;
  final PreMadeTileController controller;
  final bool isSelecting;
  final double bottomPadding;

  @override
  State<_DraftTileRow> createState() => _DraftTileRowState();
}

class _DraftTileRowState extends State<_DraftTileRow> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.draft.text);
    _focusNode = FocusNode();
    _focusNode.addListener(_saveWhenUnfocused);
  }

  @override
  void didUpdateWidget(covariant _DraftTileRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.draft.id != widget.draft.id) {
      _textController.text = widget.draft.text;
      return;
    }
    if (!_focusNode.hasFocus && _textController.text != widget.draft.text) {
      _textController.text = widget.draft.text;
    }
  }

  @override
  void dispose() {
    unawaited(widget.controller.saveDraftIfReady(widget.draft.id));
    _focusNode.removeListener(_saveWhenUnfocused);
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _saveWhenUnfocused() {
    if (_focusNode.hasFocus) return;
    unawaited(widget.controller.saveDraftIfReady(widget.draft.id));
  }

  @override
  Widget build(BuildContext context) {
    final isEmptyDraft = widget.draft.text.trim().isEmpty;
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomPadding),
      child: _TileRowShell(
        isSelecting: widget.isSelecting,
        showSelectionControl: !isEmptyDraft,
        isSelected: widget.draft.isSelected,
        onSelectionChanged: (value) {
          widget.controller.updateDraftSelection(widget.draft.id, value);
        },
        trailing: isEmptyDraft
            ? null
            : IconButton(
                tooltip: context.l10n.preMadeTilesDelete,
                onPressed: () {
                  widget.controller.removeDraft(widget.draft.id);
                },
                color: context.theme.colorScheme.error,
                icon: Icon(PhosphorIcons.trash()),
              ),
        child: TextField(
          controller: _textController,
          focusNode: _focusNode,
          minLines: 1,
          maxLines: 3,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            widget.controller.updateDraftText(widget.draft.id, value);
          },
          onSubmitted: (_) {
            unawaited(widget.controller.saveDraftIfReady(widget.draft.id));
          },
          decoration: InputDecoration(
            hintText: context.l10n.preMadeTileHint,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

class _TileRowShell extends StatelessWidget {
  const _TileRowShell({
    required this.isSelecting,
    required this.showSelectionControl,
    required this.isSelected,
    required this.onSelectionChanged,
    required this.trailing,
    required this.child,
  });

  final bool isSelecting;
  final bool showSelectionControl;
  final bool isSelected;
  final void Function(bool value) onSelectionChanged;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isSelecting) ...[
          SizedBox(
            width: 44,
            child: showSelectionControl
                ? Checkbox.adaptive(
                    value: isSelected,
                    activeColor: context.primary,
                    checkColor: context.onPrimary,
                    onChanged: (value) => onSelectionChanged(value ?? false),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(width: 4),
        ],
        Expanded(child: child),
        const SizedBox(width: 8),
        SizedBox(width: 44, height: 44, child: trailing),
      ],
    );
  }
}

class _SelectAllRow extends StatelessWidget {
  const _SelectAllRow({
    required this.selectedCount,
    required this.totalCount,
    required this.allSelected,
    required this.onToggle,
  });

  final int selectedCount;
  final int totalCount;
  final bool allSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final checkboxValue = selectedCount == 0
        ? false
        : allSelected
        ? true
        : null;

    return InkWell(
      borderRadius: kBorderRadius,
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: 44,
              child: Checkbox.adaptive(
                tristate: true,
                value: checkboxValue,
                activeColor: context.primary,
                checkColor: context.onPrimary,
                onChanged: (_) => onToggle(),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                l10n.preMadeTilesSelectAll,
                style: context.p1.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              l10n.preMadeTilesSelectedCount(selectedCount, totalCount),
              style: context.caption.copyWith(color: context.weakTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _BoardSelectionActions extends StatelessWidget {
  const _BoardSelectionActions({
    required this.hasSelection,
    required this.onReplace,
    required this.onFill,
  });

  final bool hasSelection;
  final VoidCallback onReplace;
  final VoidCallback onFill;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Container(
        color: context.surface,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: hasSelection ? onReplace : null,
                    icon: Icon(PhosphorIcons.shuffle()),
                    label: Text(l10n.preMadeTilesReplaceItems),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: hasSelection ? onFill : null,
                    icon: Icon(PhosphorIcons.squaresFour()),
                    label: Text(l10n.preMadeTilesFillItems),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l10n.preMadeTilesBoardActionHelp,
              textAlign: TextAlign.center,
              style: context.caption.copyWith(color: context.weakTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreMadePrimaryButton extends StatelessWidget {
  const _PreMadePrimaryButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: label,
      style: FilledButton.styleFrom(
        backgroundColor: context.primary,
        foregroundColor: context.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: kCardShape,
      ),
    );
  }
}
