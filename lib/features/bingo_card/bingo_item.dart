import 'package:dart_mappable/dart_mappable.dart';

part 'bingo_item.mapper.dart';

@MappableClass(ignoreNull: true)
class BingoItem with BingoItemMappable {
  BingoItem({
    required this.id,
    this.text = '',
    this.fullfilledAt,
  });

  final String id;
  final String text;
  final DateTime? fullfilledAt;

  bool get isDone => fullfilledAt != null;
}

@MappableClass(ignoreNull: true)
class BingoCardState with BingoCardStateMappable {
  BingoCardState({
    required this.name,
    required this.gridItems,
    required this.lastChangeDateTime,
  });

  final String name;
  final List<List<BingoItem>> gridItems;
  final DateTime? lastChangeDateTime;
}
