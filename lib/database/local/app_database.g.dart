// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CardUIModelTableTable extends CardUIModelTable
    with TableInfo<$CardUIModelTableTable, CardDetailModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardUIModelTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timeoutDateMeta =
      const VerificationMeta('timeoutDate');
  @override
  late final GeneratedColumn<DateTime> timeoutDate = GeneratedColumn<DateTime>(
      'timeout_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, title, url, duration, timeoutDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_u_i_model_table';
  @override
  VerificationContext validateIntegrity(Insertable<CardDetailModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('timeout_date')) {
      context.handle(
          _timeoutDateMeta,
          timeoutDate.isAcceptableOrUnknown(
              data['timeout_date']!, _timeoutDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardDetailModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardDetailModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      timeoutDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timeout_date']),
    );
  }

  @override
  $CardUIModelTableTable createAlias(String alias) {
    return $CardUIModelTableTable(attachedDatabase, alias);
  }
}

class CardUIModelTableCompanion extends UpdateCompanion<CardDetailModel> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> url;
  final Value<int> duration;
  final Value<DateTime?> timeoutDate;
  const CardUIModelTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.url = const Value.absent(),
    this.duration = const Value.absent(),
    this.timeoutDate = const Value.absent(),
  });
  CardUIModelTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String url,
    required int duration,
    this.timeoutDate = const Value.absent(),
  })  : title = Value(title),
        url = Value(url),
        duration = Value(duration);
  static Insertable<CardDetailModel> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? url,
    Expression<int>? duration,
    Expression<DateTime>? timeoutDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (url != null) 'url': url,
      if (duration != null) 'duration': duration,
      if (timeoutDate != null) 'timeout_date': timeoutDate,
    });
  }

  CardUIModelTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? url,
      Value<int>? duration,
      Value<DateTime?>? timeoutDate}) {
    return CardUIModelTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      duration: duration ?? this.duration,
      timeoutDate: timeoutDate ?? this.timeoutDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (timeoutDate.present) {
      map['timeout_date'] = Variable<DateTime>(timeoutDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardUIModelTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('url: $url, ')
          ..write('duration: $duration, ')
          ..write('timeoutDate: $timeoutDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CardUIModelTableTable cardUIModelTable =
      $CardUIModelTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cardUIModelTable];
}

typedef $$CardUIModelTableTableCreateCompanionBuilder
    = CardUIModelTableCompanion Function({
  Value<int> id,
  required String title,
  required String url,
  required int duration,
  Value<DateTime?> timeoutDate,
});
typedef $$CardUIModelTableTableUpdateCompanionBuilder
    = CardUIModelTableCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> url,
  Value<int> duration,
  Value<DateTime?> timeoutDate,
});

class $$CardUIModelTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardUIModelTableTable,
    CardDetailModel,
    $$CardUIModelTableTableFilterComposer,
    $$CardUIModelTableTableOrderingComposer,
    $$CardUIModelTableTableCreateCompanionBuilder,
    $$CardUIModelTableTableUpdateCompanionBuilder> {
  $$CardUIModelTableTableTableManager(
      _$AppDatabase db, $CardUIModelTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CardUIModelTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CardUIModelTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<DateTime?> timeoutDate = const Value.absent(),
          }) =>
              CardUIModelTableCompanion(
            id: id,
            title: title,
            url: url,
            duration: duration,
            timeoutDate: timeoutDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String url,
            required int duration,
            Value<DateTime?> timeoutDate = const Value.absent(),
          }) =>
              CardUIModelTableCompanion.insert(
            id: id,
            title: title,
            url: url,
            duration: duration,
            timeoutDate: timeoutDate,
          ),
        ));
}

class $$CardUIModelTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CardUIModelTableTable> {
  $$CardUIModelTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get duration => $state.composableBuilder(
      column: $state.table.duration,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get timeoutDate => $state.composableBuilder(
      column: $state.table.timeoutDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CardUIModelTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CardUIModelTableTable> {
  $$CardUIModelTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get duration => $state.composableBuilder(
      column: $state.table.duration,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get timeoutDate => $state.composableBuilder(
      column: $state.table.timeoutDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CardUIModelTableTableTableManager get cardUIModelTable =>
      $$CardUIModelTableTableTableManager(_db, _db.cardUIModelTable);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appDatabaseHash() => r'4f48bd753c0b40b632cdb094df07cd563f818074';

/// See also [appDatabase].
@ProviderFor(appDatabase)
final appDatabaseProvider = AutoDisposeProvider<AppDatabase>.internal(
  appDatabase,
  name: r'appDatabaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$appDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AppDatabaseRef = AutoDisposeProviderRef<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
