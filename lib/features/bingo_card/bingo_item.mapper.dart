// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bingo_item.dart';

class BingoItemMapper extends ClassMapperBase<BingoItem> {
  BingoItemMapper._();

  static BingoItemMapper? _instance;
  static BingoItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BingoItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BingoItem';

  static String _$id(BingoItem v) => v.id;
  static const Field<BingoItem, String> _f$id = Field('id', _$id);
  static String _$text(BingoItem v) => v.text;
  static const Field<BingoItem, String> _f$text =
      Field('text', _$text, opt: true, def: '');
  static bool _$isDone(BingoItem v) => v.isDone;
  static const Field<BingoItem, bool> _f$isDone =
      Field('isDone', _$isDone, opt: true, def: false);

  @override
  final MappableFields<BingoItem> fields = const {
    #id: _f$id,
    #text: _f$text,
    #isDone: _f$isDone,
  };
  @override
  final bool ignoreNull = true;

  static BingoItem _instantiate(DecodingData data) {
    return BingoItem(
        id: data.dec(_f$id),
        text: data.dec(_f$text),
        isDone: data.dec(_f$isDone));
  }

  @override
  final Function instantiate = _instantiate;

  static BingoItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BingoItem>(map);
  }

  static BingoItem fromJson(String json) {
    return ensureInitialized().decodeJson<BingoItem>(json);
  }
}

mixin BingoItemMappable {
  String toJson() {
    return BingoItemMapper.ensureInitialized()
        .encodeJson<BingoItem>(this as BingoItem);
  }

  Map<String, dynamic> toMap() {
    return BingoItemMapper.ensureInitialized()
        .encodeMap<BingoItem>(this as BingoItem);
  }

  BingoItemCopyWith<BingoItem, BingoItem, BingoItem> get copyWith =>
      _BingoItemCopyWithImpl<BingoItem, BingoItem>(
          this as BingoItem, $identity, $identity);
  @override
  String toString() {
    return BingoItemMapper.ensureInitialized()
        .stringifyValue(this as BingoItem);
  }

  @override
  bool operator ==(Object other) {
    return BingoItemMapper.ensureInitialized()
        .equalsValue(this as BingoItem, other);
  }

  @override
  int get hashCode {
    return BingoItemMapper.ensureInitialized().hashValue(this as BingoItem);
  }
}

extension BingoItemValueCopy<$R, $Out> on ObjectCopyWith<$R, BingoItem, $Out> {
  BingoItemCopyWith<$R, BingoItem, $Out> get $asBingoItem =>
      $base.as((v, t, t2) => _BingoItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BingoItemCopyWith<$R, $In extends BingoItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? text, bool? isDone});
  BingoItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BingoItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BingoItem, $Out>
    implements BingoItemCopyWith<$R, BingoItem, $Out> {
  _BingoItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BingoItem> $mapper =
      BingoItemMapper.ensureInitialized();
  @override
  $R call({String? id, String? text, bool? isDone}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (text != null) #text: text,
        if (isDone != null) #isDone: isDone
      }));
  @override
  BingoItem $make(CopyWithData data) => BingoItem(
      id: data.get(#id, or: $value.id),
      text: data.get(#text, or: $value.text),
      isDone: data.get(#isDone, or: $value.isDone));

  @override
  BingoItemCopyWith<$R2, BingoItem, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BingoItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
