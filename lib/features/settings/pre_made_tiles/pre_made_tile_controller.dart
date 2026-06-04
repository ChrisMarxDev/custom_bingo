import 'dart:async';

import 'package:custom_bingo/common/services/app_database.dart';
import 'package:state_beacon/state_beacon.dart';

final preMadeTileControllerRef = Ref.scoped((ctx) => PreMadeTileController());

enum PreMadeTileMode { selecting, editing }

class PreMadeTileDraft {
  const PreMadeTileDraft({
    required this.id,
    this.text = '',
    this.isSelected = true,
  });

  final int id;
  final String text;
  final bool isSelected;

  PreMadeTileDraft copyWith({String? text, bool? isSelected}) {
    return PreMadeTileDraft(
      id: id,
      text: text ?? this.text,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class PreMadeTileController extends BeaconController {
  PreMadeTileController({AppDatabase? database})
    : _database = database ?? appDatabaseBeacon.value {
    _subscription = _database.watchPreMadeTiles().listen((nextTiles) {
      tiles.value = nextTiles;
      isLoading.value = false;
    });
  }

  final AppDatabase _database;
  StreamSubscription<List<PreMadeTile>>? _subscription;
  final _savingDraftIds = <int>{};
  var _nextDraftId = 0;

  late final tiles = Beacon.writable<List<PreMadeTile>>([]);
  late final drafts = Beacon.writable<List<PreMadeTileDraft>>([]);
  late final mode = Beacon.writable<PreMadeTileMode>(PreMadeTileMode.selecting);
  late final isLoading = Beacon.writable<bool>(true);

  void setMode(PreMadeTileMode nextMode) {
    mode.value = nextMode;
  }

  void addDraft() {
    drafts.value = [...drafts.value, PreMadeTileDraft(id: _nextDraftId++)];
  }

  void updateDraftText(int id, String text) {
    drafts.value = drafts.value.map((draft) {
      if (draft.id != id) return draft;
      return draft.copyWith(text: text);
    }).toList();
  }

  void updateDraftSelection(int id, bool isSelected) {
    drafts.value = drafts.value.map((draft) {
      if (draft.id != id) return draft;
      return draft.copyWith(isSelected: isSelected);
    }).toList();
  }

  void removeDraft(int id) {
    drafts.value = drafts.value.where((draft) => draft.id != id).toList();
  }

  Future<void> saveDraftIfReady(int id) async {
    if (!_savingDraftIds.add(id)) return;

    try {
      PreMadeTileDraft? draft;
      for (final candidate in drafts.value) {
        if (candidate.id == id) {
          draft = candidate;
          break;
        }
      }
      if (draft == null) return;

      final text = draft.text.trim();
      if (text.isEmpty) return;

      await _database.createPreMadeTile(
        text: text,
        isSelected: draft.isSelected,
        sortOrder: _nextSortOrder(),
      );
      drafts.value = drafts.value
          .where((candidate) => candidate.id != id)
          .toList();
    } finally {
      _savingDraftIds.remove(id);
    }
  }

  Future<List<String>> selectedTextsSnapshot() async {
    final savedTexts = tiles.value
        .where((tile) => tile.isSelected)
        .map((tile) => tile.tileText.trim())
        .where((text) => text.isNotEmpty)
        .toList();
    final selectedDrafts = drafts.value
        .where((draft) => draft.isSelected)
        .where((draft) => draft.text.trim().isNotEmpty)
        .toList();
    if (selectedDrafts.isEmpty) {
      return savedTexts;
    }

    var sortOrder = _nextSortOrder();
    for (final draft in selectedDrafts) {
      await _database.createPreMadeTile(
        text: draft.text,
        isSelected: draft.isSelected,
        sortOrder: sortOrder,
      );
      sortOrder += 1;
    }

    final savedDraftIds = selectedDrafts.map((draft) => draft.id).toSet();
    drafts.value = drafts.value
        .where((draft) => !savedDraftIds.contains(draft.id))
        .toList();

    return [...savedTexts, ...selectedDrafts.map((draft) => draft.text.trim())];
  }

  Future<void> updateTileText(PreMadeTile tile, String text) async {
    final normalizedText = text.trim();
    if (normalizedText == tile.tileText) return;

    await _database.updatePreMadeTileText(tile.id, normalizedText);
  }

  Future<void> updateTileSelection(PreMadeTile tile, bool isSelected) async {
    if (tile.isSelected == isSelected) return;

    await _database.updatePreMadeTileSelection(tile.id, isSelected);
  }

  Future<void> deleteTile(PreMadeTile tile) async {
    await _database.deletePreMadeTile(tile.id);
  }

  Future<void> setAllSelected(bool isSelected) async {
    await _database.updateAllPreMadeTileSelection(isSelected);
    drafts.value = drafts.value
        .map((draft) => draft.copyWith(isSelected: isSelected))
        .toList();
  }

  int _nextSortOrder() {
    return tiles.value.fold<int>(
          -1,
          (max, tile) => tile.sortOrder > max ? tile.sortOrder : max,
        ) +
        1;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
