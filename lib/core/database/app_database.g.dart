// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ScanRecordsTable extends ScanRecords
    with TableInfo<$ScanRecordsTable, ScanRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSavedMeta = const VerificationMeta(
    'isSaved',
  );
  @override
  late final GeneratedColumn<bool> isSaved = GeneratedColumn<bool>(
    'is_saved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_saved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    content,
    title,
    isSaved,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('is_saved')) {
      context.handle(
        _isSavedMeta,
        isSaved.isAcceptableOrUnknown(data['is_saved']!, _isSavedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      isSaved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_saved'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ScanRecordsTable createAlias(String alias) {
    return $ScanRecordsTable(attachedDatabase, alias);
  }
}

class ScanRecord extends DataClass implements Insertable<ScanRecord> {
  final int id;
  final String content;
  final String? title;
  final bool isSaved;
  final DateTime createdAt;
  const ScanRecord({
    required this.id,
    required this.content,
    this.title,
    required this.isSaved,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['is_saved'] = Variable<bool>(isSaved);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ScanRecordsCompanion toCompanion(bool nullToAbsent) {
    return ScanRecordsCompanion(
      id: Value(id),
      content: Value(content),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      isSaved: Value(isSaved),
      createdAt: Value(createdAt),
    );
  }

  factory ScanRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanRecord(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      title: serializer.fromJson<String?>(json['title']),
      isSaved: serializer.fromJson<bool>(json['isSaved']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'title': serializer.toJson<String?>(title),
      'isSaved': serializer.toJson<bool>(isSaved),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ScanRecord copyWith({
    int? id,
    String? content,
    Value<String?> title = const Value.absent(),
    bool? isSaved,
    DateTime? createdAt,
  }) => ScanRecord(
    id: id ?? this.id,
    content: content ?? this.content,
    title: title.present ? title.value : this.title,
    isSaved: isSaved ?? this.isSaved,
    createdAt: createdAt ?? this.createdAt,
  );
  ScanRecord copyWithCompanion(ScanRecordsCompanion data) {
    return ScanRecord(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      title: data.title.present ? data.title.value : this.title,
      isSaved: data.isSaved.present ? data.isSaved.value : this.isSaved,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanRecord(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('title: $title, ')
          ..write('isSaved: $isSaved, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, content, title, isSaved, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanRecord &&
          other.id == this.id &&
          other.content == this.content &&
          other.title == this.title &&
          other.isSaved == this.isSaved &&
          other.createdAt == this.createdAt);
}

class ScanRecordsCompanion extends UpdateCompanion<ScanRecord> {
  final Value<int> id;
  final Value<String> content;
  final Value<String?> title;
  final Value<bool> isSaved;
  final Value<DateTime> createdAt;
  const ScanRecordsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.title = const Value.absent(),
    this.isSaved = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ScanRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    this.title = const Value.absent(),
    this.isSaved = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : content = Value(content);
  static Insertable<ScanRecord> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? title,
    Expression<bool>? isSaved,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (title != null) 'title': title,
      if (isSaved != null) 'is_saved': isSaved,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ScanRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? content,
    Value<String?>? title,
    Value<bool>? isSaved,
    Value<DateTime>? createdAt,
  }) {
    return ScanRecordsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      title: title ?? this.title,
      isSaved: isSaved ?? this.isSaved,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isSaved.present) {
      map['is_saved'] = Variable<bool>(isSaved.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanRecordsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('title: $title, ')
          ..write('isSaved: $isSaved, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScanRecordsTable scanRecords = $ScanRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scanRecords];
}

typedef $$ScanRecordsTableCreateCompanionBuilder =
    ScanRecordsCompanion Function({
      Value<int> id,
      required String content,
      Value<String?> title,
      Value<bool> isSaved,
      Value<DateTime> createdAt,
    });
typedef $$ScanRecordsTableUpdateCompanionBuilder =
    ScanRecordsCompanion Function({
      Value<int> id,
      Value<String> content,
      Value<String?> title,
      Value<bool> isSaved,
      Value<DateTime> createdAt,
    });

class $$ScanRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableFilterComposer({
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

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSaved => $composableBuilder(
    column: $table.isSaved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScanRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSaved => $composableBuilder(
    column: $table.isSaved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScanRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanRecordsTable> {
  $$ScanRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get isSaved =>
      $composableBuilder(column: $table.isSaved, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ScanRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanRecordsTable,
          ScanRecord,
          $$ScanRecordsTableFilterComposer,
          $$ScanRecordsTableOrderingComposer,
          $$ScanRecordsTableAnnotationComposer,
          $$ScanRecordsTableCreateCompanionBuilder,
          $$ScanRecordsTableUpdateCompanionBuilder,
          (
            ScanRecord,
            BaseReferences<_$AppDatabase, $ScanRecordsTable, ScanRecord>,
          ),
          ScanRecord,
          PrefetchHooks Function()
        > {
  $$ScanRecordsTableTableManager(_$AppDatabase db, $ScanRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<bool> isSaved = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ScanRecordsCompanion(
                id: id,
                content: content,
                title: title,
                isSaved: isSaved,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String content,
                Value<String?> title = const Value.absent(),
                Value<bool> isSaved = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ScanRecordsCompanion.insert(
                id: id,
                content: content,
                title: title,
                isSaved: isSaved,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScanRecordsTable, ScanRecord>(table),
                  BaseReferences<_$AppDatabase, $ScanRecordsTable, ScanRecord>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScanRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanRecordsTable,
      ScanRecord,
      $$ScanRecordsTableFilterComposer,
      $$ScanRecordsTableOrderingComposer,
      $$ScanRecordsTableAnnotationComposer,
      $$ScanRecordsTableCreateCompanionBuilder,
      $$ScanRecordsTableUpdateCompanionBuilder,
      (
        ScanRecord,
        BaseReferences<_$AppDatabase, $ScanRecordsTable, ScanRecord>,
      ),
      ScanRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScanRecordsTableTableManager get scanRecords =>
      $$ScanRecordsTableTableManager(_db, _db.scanRecords);
}
