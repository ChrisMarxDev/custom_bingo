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
  static DateTime? _$fullfilledAt(BingoItem v) => v.fullfilledAt;
  static const Field<BingoItem, DateTime> _f$fullfilledAt =
      Field('fullfilledAt', _$fullfilledAt, opt: true);

  @override
  final MappableFields<BingoItem> fields = const {
    #id: _f$id,
    #text: _f$text,
    #fullfilledAt: _f$fullfilledAt,
  };
  @override
  final bool ignoreNull = true;

  static BingoItem _instantiate(DecodingData data) {
    return BingoItem(
        id: data.dec(_f$id),
        text: data.dec(_f$text),
        fullfilledAt: data.dec(_f$fullfilledAt));
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
  $R call({String? id, String? text, DateTime? fullfilledAt});
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
  $R call({String? id, String? text, Object? fullfilledAt = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (text != null) #text: text,
        if (fullfilledAt != $none) #fullfilledAt: fullfilledAt
      }));
  @override
  BingoItem $make(CopyWithData data) => BingoItem(
      id: data.get(#id, or: $value.id),
      text: data.get(#text, or: $value.text),
      fullfilledAt: data.get(#fullfilledAt, or: $value.fullfilledAt));

  @override
  BingoItemCopyWith<$R2, BingoItem, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BingoItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BingoCardStateMapper extends ClassMapperBase<BingoCardState> {
  BingoCardStateMapper._();

  static BingoCardStateMapper? _instance;
  static BingoCardStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BingoCardStateMapper._());
      BingoItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BingoCardState';

  static String _$name(BingoCardState v) => v.name;
  static const Field<BingoCardState, String> _f$name = Field('name', _$name);
  static List<List<BingoItem>> _$gridItems(BingoCardState v) => v.gridItems;
  static const Field<BingoCardState, List<List<BingoItem>>> _f$gridItems =
      Field('gridItems', _$gridItems);
  static DateTime? _$lastChangeDateTime(BingoCardState v) =>
      v.lastChangeDateTime;
  static const Field<BingoCardState, DateTime> _f$lastChangeDateTime =
      Field('lastChangeDateTime', _$lastChangeDateTime);

  @override
  final MappableFields<BingoCardState> fields = const {
    #name: _f$name,
    #gridItems: _f$gridItems,
    #lastChangeDateTime: _f$lastChangeDateTime,
  };
  @override
  final bool ignoreNull = true;

  static BingoCardState _instantiate(DecodingData data) {
    return BingoCardState(
        name: data.dec(_f$name),
        gridItems: data.dec(_f$gridItems),
        lastChangeDateTime: data.dec(_f$lastChangeDateTime));
  }

  @override
  final Function instantiate = _instantiate;

  static BingoCardState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BingoCardState>(map);
  }

  static BingoCardState fromJson(String json) {
    return ensureInitialized().decodeJson<BingoCardState>(json);
  }
}

mixin BingoCardStateMappable {
  String toJson() {
    return BingoCardStateMapper.ensureInitialized()
        .encodeJson<BingoCardState>(this as BingoCardState);
  }

  Map<String, dynamic> toMap() {
    return BingoCardStateMapper.ensureInitialized()
        .encodeMap<BingoCardState>(this as BingoCardState);
  }

  BingoCardStateCopyWith<BingoCardState, BingoCardState, BingoCardState>
      get copyWith =>
          _BingoCardStateCopyWithImpl<BingoCardState, BingoCardState>(
              this as BingoCardState, $identity, $identity);
  @override
  String toString() {
    return BingoCardStateMapper.ensureInitialized()
        .stringifyValue(this as BingoCardState);
  }

  @override
  bool operator ==(Object other) {
    return BingoCardStateMapper.ensureInitialized()
        .equalsValue(this as BingoCardState, other);
  }

  @override
  int get hashCode {
    return BingoCardStateMapper.ensureInitialized()
        .hashValue(this as BingoCardState);
  }
}

extension BingoCardStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BingoCardState, $Out> {
  BingoCardStateCopyWith<$R, BingoCardState, $Out> get $asBingoCardState =>
      $base.as((v, t, t2) => _BingoCardStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BingoCardStateCopyWith<$R, $In extends BingoCardState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, List<BingoItem>,
      ObjectCopyWith<$R, List<BingoItem>, List<BingoItem>>> get gridItems;
  $R call(
      {String? name,
      List<List<BingoItem>>? gridItems,
      DateTime? lastChangeDateTime});
  BingoCardStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _BingoCardStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BingoCardState, $Out>
    implements BingoCardStateCopyWith<$R, BingoCardState, $Out> {
  _BingoCardStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BingoCardState> $mapper =
      BingoCardStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, List<BingoItem>,
          ObjectCopyWith<$R, List<BingoItem>, List<BingoItem>>>
      get gridItems => ListCopyWith($value.gridItems,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(gridItems: v));
  @override
  $R call(
          {String? name,
          List<List<BingoItem>>? gridItems,
          Object? lastChangeDateTime = $none}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (gridItems != null) #gridItems: gridItems,
        if (lastChangeDateTime != $none) #lastChangeDateTime: lastChangeDateTime
      }));
  @override
  BingoCardState $make(CopyWithData data) => BingoCardState(
      name: data.get(#name, or: $value.name),
      gridItems: data.get(#gridItems, or: $value.gridItems),
      lastChangeDateTime:
          data.get(#lastChangeDateTime, or: $value.lastChangeDateTime));

  @override
  BingoCardStateCopyWith<$R2, BingoCardState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _BingoCardStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
