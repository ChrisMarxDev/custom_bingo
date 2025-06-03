import 'package:dart_mappable/dart_mappable.dart';

part 'bingo_item.mapper.dart';

@MappableClass(ignoreNull: true)
class BingoItem with BingoItemMappable {
  BingoItem({
    required this.id,
    this.text = '',
    this.isDone = false,
  });

  final String id;
  final String text;
  final bool isDone;
}
