// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PreMadeTilesTable extends PreMadeTiles
    with TableInfo<$PreMadeTilesTable, PreMadeTile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreMadeTilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tileTextMeta = const VerificationMeta(
    'tileText',
  );
  @override
  late final GeneratedColumn<String> tileText = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
    'is_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tileText,
    isSelected,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pre_made_tiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreMadeTile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('text')) {
      context.handle(
        _tileTextMeta,
        tileText.isAcceptableOrUnknown(data['text']!, _tileTextMeta),
      );
    } else if (isInserting) {
      context.missing(_tileTextMeta);
    }
    if (data.containsKey('is_selected')) {
      context.handle(
        _isSelectedMeta,
        isSelected.isAcceptableOrUnknown(data['is_selected']!, _isSelectedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PreMadeTile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreMadeTile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tileText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_selected'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PreMadeTilesTable createAlias(String alias) {
    return $PreMadeTilesTable(attachedDatabase, alias);
  }
}

class PreMadeTile extends DataClass implements Insertable<PreMadeTile> {
  final int id;
  final String tileText;
  final bool isSelected;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PreMadeTile({
    required this.id,
    required this.tileText,
    required this.isSelected,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['text'] = Variable<String>(tileText);
    map['is_selected'] = Variable<bool>(isSelected);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PreMadeTilesCompanion toCompanion(bool nullToAbsent) {
    return PreMadeTilesCompanion(
      id: Value(id),
      tileText: Value(tileText),
      isSelected: Value(isSelected),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PreMadeTile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreMadeTile(
      id: serializer.fromJson<int>(json['id']),
      tileText: serializer.fromJson<String>(json['tileText']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tileText': serializer.toJson<String>(tileText),
      'isSelected': serializer.toJson<bool>(isSelected),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PreMadeTile copyWith({
    int? id,
    String? tileText,
    bool? isSelected,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PreMadeTile(
    id: id ?? this.id,
    tileText: tileText ?? this.tileText,
    isSelected: isSelected ?? this.isSelected,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PreMadeTile copyWithCompanion(PreMadeTilesCompanion data) {
    return PreMadeTile(
      id: data.id.present ? data.id.value : this.id,
      tileText: data.tileText.present ? data.tileText.value : this.tileText,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreMadeTile(')
          ..write('id: $id, ')
          ..write('tileText: $tileText, ')
          ..write('isSelected: $isSelected, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tileText, isSelected, sortOrder, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreMadeTile &&
          other.id == this.id &&
          other.tileText == this.tileText &&
          other.isSelected == this.isSelected &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PreMadeTilesCompanion extends UpdateCompanion<PreMadeTile> {
  final Value<int> id;
  final Value<String> tileText;
  final Value<bool> isSelected;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PreMadeTilesCompanion({
    this.id = const Value.absent(),
    this.tileText = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PreMadeTilesCompanion.insert({
    this.id = const Value.absent(),
    required String tileText,
    this.isSelected = const Value.absent(),
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : tileText = Value(tileText),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PreMadeTile> custom({
    Expression<int>? id,
    Expression<String>? tileText,
    Expression<bool>? isSelected,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tileText != null) 'text': tileText,
      if (isSelected != null) 'is_selected': isSelected,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PreMadeTilesCompanion copyWith({
    Value<int>? id,
    Value<String>? tileText,
    Value<bool>? isSelected,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PreMadeTilesCompanion(
      id: id ?? this.id,
      tileText: tileText ?? this.tileText,
      isSelected: isSelected ?? this.isSelected,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tileText.present) {
      map['text'] = Variable<String>(tileText.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreMadeTilesCompanion(')
          ..write('id: $id, ')
          ..write('tileText: $tileText, ')
          ..write('isSelected: $isSelected, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PreMadeTilesTable preMadeTiles = $PreMadeTilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [preMadeTiles];
}

typedef $$PreMadeTilesTableCreateCompanionBuilder =
    PreMadeTilesCompanion Function({
      Value<int> id,
      required String tileText,
      Value<bool> isSelected,
      required int sortOrder,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$PreMadeTilesTableUpdateCompanionBuilder =
    PreMadeTilesCompanion Function({
      Value<int> id,
      Value<String> tileText,
      Value<bool> isSelected,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$PreMadeTilesTableFilterComposer
    extends Composer<_$AppDatabase, $PreMadeTilesTable> {
  $$PreMadeTilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tileText => $composableBuilder(
    column: $table.tileText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PreMadeTilesTableOrderingComposer
    extends Composer<_$AppDatabase, $PreMadeTilesTable> {
  $$PreMadeTilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tileText => $composableBuilder(
    column: $table.tileText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PreMadeTilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreMadeTilesTable> {
  $$PreMadeTilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tileText =>
      $composableBuilder(column: $table.tileText, builder: (column) => column);

  GeneratedColumn<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PreMadeTilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PreMadeTilesTable,
          PreMadeTile,
          $$PreMadeTilesTableFilterComposer,
          $$PreMadeTilesTableOrderingComposer,
          $$PreMadeTilesTableAnnotationComposer,
          $$PreMadeTilesTableCreateCompanionBuilder,
          $$PreMadeTilesTableUpdateCompanionBuilder,
          (
            PreMadeTile,
            BaseReferences<_$AppDatabase, $PreMadeTilesTable, PreMadeTile>,
          ),
          PreMadeTile,
          PrefetchHooks Function()
        > {
  $$PreMadeTilesTableTableManager(_$AppDatabase db, $PreMadeTilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreMadeTilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreMadeTilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreMadeTilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tileText = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PreMadeTilesCompanion(
                id: id,
                tileText: tileText,
                isSelected: isSelected,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tileText,
                Value<bool> isSelected = const Value.absent(),
                required int sortOrder,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => PreMadeTilesCompanion.insert(
                id: id,
                tileText: tileText,
                isSelected: isSelected,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PreMadeTilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PreMadeTilesTable,
      PreMadeTile,
      $$PreMadeTilesTableFilterComposer,
      $$PreMadeTilesTableOrderingComposer,
      $$PreMadeTilesTableAnnotationComposer,
      $$PreMadeTilesTableCreateCompanionBuilder,
      $$PreMadeTilesTableUpdateCompanionBuilder,
      (
        PreMadeTile,
        BaseReferences<_$AppDatabase, $PreMadeTilesTable, PreMadeTile>,
      ),
      PreMadeTile,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PreMadeTilesTableTableManager get preMadeTiles =>
      $$PreMadeTilesTableTableManager(_db, _db.preMadeTiles);
}
