import 'dart:async';

import 'package:custom_bingo/app/view/custom_theme.dart';
import 'package:custom_bingo/common/services/app_database.dart';
import 'package:custom_bingo/features/settings/pre_made_tiles/pre_made_tile_controller.dart';
import 'package:custom_bingo/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:state_beacon/state_beacon.dart';

class PreMadeTilesScreen extends StatefulWidget {
  const PreMadeTilesScreen({
    this.initialMode = PreMadeTileMode.editing,
    this.showModeSwitch = kDebugMode,
    super.key,
  });

  final PreMadeTileMode initialMode;
  final bool showModeSwitch;

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
    final selectedCount =
        tiles.where((tile) => tile.isSelected).length +
        drafts.where((draft) => draft.isSelected).length;
    final totalCount = tiles.length + drafts.length;
    final allSelected = totalCount > 0 && selectedCount == totalCount;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.preMadeTilesTitle, style: context.h2)),
      floatingActionButton: isSelecting
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              backgroundColor: context.primary,
              foregroundColor: context.onPrimary,
              icon: Icon(PhosphorIcons.check()),
              label: Text(l10n.preMadeTilesApply),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                  if (widget.showModeSwitch) ...[
                    const SizedBox(height: 20),
                    SegmentedButton<PreMadeTileMode>(
                      selected: {mode},
                      onSelectionChanged: (selection) {
                        controller.setMode(selection.single);
                      },
                      segments: [
                        ButtonSegment(
                          value: PreMadeTileMode.selecting,
                          icon: Icon(PhosphorIcons.checkSquare()),
                          label: Text(l10n.preMadeTilesSelectMode),
                        ),
                        ButtonSegment(
                          value: PreMadeTileMode.editing,
                          icon: Icon(PhosphorIcons.pencilSimple()),
                          label: Text(l10n.preMadeTilesEditMode),
                        ),
                      ],
                    ),
                  ],
                  if (isSelecting) ...[
                    SizedBox(height: widget.showModeSwitch ? 12 : 16),
                    Text(
                      l10n.preMadeTilesSelectedCount(selectedCount, totalCount),
                      style: context.caption.copyWith(
                        color: context.weakTextColor,
                      ),
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
          else if (tiles.isEmpty && drafts.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _EmptyState(onAdd: controller.addDraft),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList.separated(
                itemCount: tiles.length + drafts.length,
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
                  );
                },
              ),
            ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, isSelecting ? 112 : 32),
            sliver: SliverToBoxAdapter(
              child: _BottomActions(
                isSelecting: isSelecting,
                allSelected: allSelected,
                hasItems: totalCount > 0,
                onAdd: controller.addDraft,
                onToggleAll: () {
                  unawaited(controller.setAllSelected(!allSelected));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
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
    super.key,
  });

  final PreMadeTileDraft draft;
  final PreMadeTileController controller;
  final bool isSelecting;

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
    return _TileRowShell(
      isSelecting: widget.isSelecting,
      isSelected: widget.draft.isSelected,
      onSelectionChanged: (value) {
        widget.controller.updateDraftSelection(widget.draft.id, value);
      },
      trailing: IconButton(
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
        autofocus: true,
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
    );
  }
}

class _TileRowShell extends StatelessWidget {
  const _TileRowShell({
    required this.isSelecting,
    required this.isSelected,
    required this.onSelectionChanged,
    required this.trailing,
    required this.child,
  });

  final bool isSelecting;
  final bool isSelected;
  final void Function(bool value) onSelectionChanged;
  final Widget trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isSelecting) ...[
          SizedBox(
            width: 44,
            child: Checkbox.adaptive(
              value: isSelected,
              onChanged: (value) => onSelectionChanged(value ?? false),
            ),
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

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.isSelecting,
    required this.allSelected,
    required this.hasItems,
    required this.onAdd,
    required this.onToggleAll,
  });

  final bool isSelecting;
  final bool allSelected;
  final bool hasItems;
  final VoidCallback onAdd;
  final VoidCallback onToggleAll;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isSelecting && hasItems) ...[
          FilledButton.tonal(
            onPressed: onToggleAll,
            child: Text(
              allSelected
                  ? l10n.preMadeTilesSelectNone
                  : l10n.preMadeTilesSelectAll,
            ),
          ),
          const SizedBox(width: 12),
        ],
        SizedBox(
          width: 48,
          height: 48,
          child: IconButton.filled(
            tooltip: l10n.preMadeTilesAdd,
            style: IconButton.styleFrom(
              backgroundColor: context.primary,
              foregroundColor: context.onPrimary,
            ),
            onPressed: onAdd,
            icon: Icon(PhosphorIcons.plus()),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.squaresFour(),
            size: 44,
            color: context.weakTextColor,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.preMadeTilesEmptyTitle,
            style: context.h4.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.preMadeTilesEmptyBody,
            textAlign: TextAlign.center,
            style: context.p1.copyWith(color: context.weakTextColor),
          ),
          const SizedBox(height: 20),
          IconButton.filled(
            tooltip: l10n.preMadeTilesAdd,
            style: IconButton.styleFrom(
              backgroundColor: context.primary,
              foregroundColor: context.onPrimary,
            ),
            onPressed: onAdd,
            icon: Icon(PhosphorIcons.plus()),
          ),
        ],
      ),
    );
  }
}
