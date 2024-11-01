// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ActivityDbTable extends ActivityDb
    with TableInfo<$ActivityDbTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityDbTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtitleMeta =
      const VerificationMeta('subtitle');
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
      'subtitle', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _patientNameMeta =
      const VerificationMeta('patientName');
  @override
  late final GeneratedColumn<String> patientName = GeneratedColumn<String>(
      'patient_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
      'time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
      'area', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _consultTypeMeta =
      const VerificationMeta('consultType');
  @override
  late final GeneratedColumn<String> consultType = GeneratedColumn<String>(
      'consult_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        subtitle,
        patientName,
        description,
        date,
        time,
        area,
        consultType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_db';
  @override
  VerificationContext validateIntegrity(Insertable<Activity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(_subtitleMeta,
          subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta));
    } else if (isInserting) {
      context.missing(_subtitleMeta);
    }
    if (data.containsKey('patient_name')) {
      context.handle(
          _patientNameMeta,
          patientName.isAcceptableOrUnknown(
              data['patient_name']!, _patientNameMeta));
    } else if (isInserting) {
      context.missing(_patientNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
          _areaMeta, area.isAcceptableOrUnknown(data['area']!, _areaMeta));
    } else if (isInserting) {
      context.missing(_areaMeta);
    }
    if (data.containsKey('consult_type')) {
      context.handle(
          _consultTypeMeta,
          consultType.isAcceptableOrUnknown(
              data['consult_type']!, _consultTypeMeta));
    } else if (isInserting) {
      context.missing(_consultTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      subtitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subtitle'])!,
      patientName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}patient_name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      time: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time'])!,
      area: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area'])!,
      consultType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}consult_type'])!,
    );
  }

  @override
  $ActivityDbTable createAlias(String alias) {
    return $ActivityDbTable(attachedDatabase, alias);
  }
}

class Activity extends DataClass implements Insertable<Activity> {
  final String id;
  final String title;
  final String subtitle;
  final String patientName;
  final String description;
  final DateTime date;
  final String time;
  final String area;
  final String consultType;
  const Activity(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.patientName,
      required this.description,
      required this.date,
      required this.time,
      required this.area,
      required this.consultType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['subtitle'] = Variable<String>(subtitle);
    map['patient_name'] = Variable<String>(patientName);
    map['description'] = Variable<String>(description);
    map['date'] = Variable<DateTime>(date);
    map['time'] = Variable<String>(time);
    map['area'] = Variable<String>(area);
    map['consult_type'] = Variable<String>(consultType);
    return map;
  }

  ActivityDbCompanion toCompanion(bool nullToAbsent) {
    return ActivityDbCompanion(
      id: Value(id),
      title: Value(title),
      subtitle: Value(subtitle),
      patientName: Value(patientName),
      description: Value(description),
      date: Value(date),
      time: Value(time),
      area: Value(area),
      consultType: Value(consultType),
    );
  }

  factory Activity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Activity(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String>(json['subtitle']),
      patientName: serializer.fromJson<String>(json['patientName']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      time: serializer.fromJson<String>(json['time']),
      area: serializer.fromJson<String>(json['area']),
      consultType: serializer.fromJson<String>(json['consultType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String>(subtitle),
      'patientName': serializer.toJson<String>(patientName),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<DateTime>(date),
      'time': serializer.toJson<String>(time),
      'area': serializer.toJson<String>(area),
      'consultType': serializer.toJson<String>(consultType),
    };
  }

  Activity copyWith(
          {String? id,
          String? title,
          String? subtitle,
          String? patientName,
          String? description,
          DateTime? date,
          String? time,
          String? area,
          String? consultType}) =>
      Activity(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        patientName: patientName ?? this.patientName,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
        area: area ?? this.area,
        consultType: consultType ?? this.consultType,
      );
  Activity copyWithCompanion(ActivityDbCompanion data) {
    return Activity(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      patientName:
          data.patientName.present ? data.patientName.value : this.patientName,
      description:
          data.description.present ? data.description.value : this.description,
      date: data.date.present ? data.date.value : this.date,
      time: data.time.present ? data.time.value : this.time,
      area: data.area.present ? data.area.value : this.area,
      consultType:
          data.consultType.present ? data.consultType.value : this.consultType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Activity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('patientName: $patientName, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('area: $area, ')
          ..write('consultType: $consultType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, subtitle, patientName, description,
      date, time, area, consultType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Activity &&
          other.id == this.id &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.patientName == this.patientName &&
          other.description == this.description &&
          other.date == this.date &&
          other.time == this.time &&
          other.area == this.area &&
          other.consultType == this.consultType);
}

class ActivityDbCompanion extends UpdateCompanion<Activity> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> subtitle;
  final Value<String> patientName;
  final Value<String> description;
  final Value<DateTime> date;
  final Value<String> time;
  final Value<String> area;
  final Value<String> consultType;
  final Value<int> rowid;
  const ActivityDbCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.patientName = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.area = const Value.absent(),
    this.consultType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityDbCompanion.insert({
    required String id,
    required String title,
    required String subtitle,
    required String patientName,
    required String description,
    required DateTime date,
    required String time,
    required String area,
    required String consultType,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        subtitle = Value(subtitle),
        patientName = Value(patientName),
        description = Value(description),
        date = Value(date),
        time = Value(time),
        area = Value(area),
        consultType = Value(consultType);
  static Insertable<Activity> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? patientName,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<String>? time,
    Expression<String>? area,
    Expression<String>? consultType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (patientName != null) 'patient_name': patientName,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (area != null) 'area': area,
      if (consultType != null) 'consult_type': consultType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityDbCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? subtitle,
      Value<String>? patientName,
      Value<String>? description,
      Value<DateTime>? date,
      Value<String>? time,
      Value<String>? area,
      Value<String>? consultType,
      Value<int>? rowid}) {
    return ActivityDbCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      patientName: patientName ?? this.patientName,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      area: area ?? this.area,
      consultType: consultType ?? this.consultType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (patientName.present) {
      map['patient_name'] = Variable<String>(patientName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (consultType.present) {
      map['consult_type'] = Variable<String>(consultType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityDbCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('patientName: $patientName, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('area: $area, ')
          ..write('consultType: $consultType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ActivityDbTable activityDb = $ActivityDbTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [activityDb];
}

typedef $$ActivityDbTableCreateCompanionBuilder = ActivityDbCompanion Function({
  required String id,
  required String title,
  required String subtitle,
  required String patientName,
  required String description,
  required DateTime date,
  required String time,
  required String area,
  required String consultType,
  Value<int> rowid,
});
typedef $$ActivityDbTableUpdateCompanionBuilder = ActivityDbCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> subtitle,
  Value<String> patientName,
  Value<String> description,
  Value<DateTime> date,
  Value<String> time,
  Value<String> area,
  Value<String> consultType,
  Value<int> rowid,
});

class $$ActivityDbTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityDbTable> {
  $$ActivityDbTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subtitle => $composableBuilder(
      column: $table.subtitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get area => $composableBuilder(
      column: $table.area, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get consultType => $composableBuilder(
      column: $table.consultType, builder: (column) => ColumnFilters(column));
}

class $$ActivityDbTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityDbTable> {
  $$ActivityDbTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subtitle => $composableBuilder(
      column: $table.subtitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get time => $composableBuilder(
      column: $table.time, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get area => $composableBuilder(
      column: $table.area, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get consultType => $composableBuilder(
      column: $table.consultType, builder: (column) => ColumnOrderings(column));
}

class $$ActivityDbTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityDbTable> {
  $$ActivityDbTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get patientName => $composableBuilder(
      column: $table.patientName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get consultType => $composableBuilder(
      column: $table.consultType, builder: (column) => column);
}

class $$ActivityDbTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActivityDbTable,
    Activity,
    $$ActivityDbTableFilterComposer,
    $$ActivityDbTableOrderingComposer,
    $$ActivityDbTableAnnotationComposer,
    $$ActivityDbTableCreateCompanionBuilder,
    $$ActivityDbTableUpdateCompanionBuilder,
    (Activity, BaseReferences<_$AppDatabase, $ActivityDbTable, Activity>),
    Activity,
    PrefetchHooks Function()> {
  $$ActivityDbTableTableManager(_$AppDatabase db, $ActivityDbTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityDbTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityDbTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityDbTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> subtitle = const Value.absent(),
            Value<String> patientName = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> time = const Value.absent(),
            Value<String> area = const Value.absent(),
            Value<String> consultType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivityDbCompanion(
            id: id,
            title: title,
            subtitle: subtitle,
            patientName: patientName,
            description: description,
            date: date,
            time: time,
            area: area,
            consultType: consultType,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String subtitle,
            required String patientName,
            required String description,
            required DateTime date,
            required String time,
            required String area,
            required String consultType,
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivityDbCompanion.insert(
            id: id,
            title: title,
            subtitle: subtitle,
            patientName: patientName,
            description: description,
            date: date,
            time: time,
            area: area,
            consultType: consultType,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ActivityDbTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActivityDbTable,
    Activity,
    $$ActivityDbTableFilterComposer,
    $$ActivityDbTableOrderingComposer,
    $$ActivityDbTableAnnotationComposer,
    $$ActivityDbTableCreateCompanionBuilder,
    $$ActivityDbTableUpdateCompanionBuilder,
    (Activity, BaseReferences<_$AppDatabase, $ActivityDbTable, Activity>),
    Activity,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ActivityDbTableTableManager get activityDb =>
      $$ActivityDbTableTableManager(_db, _db.activityDb);
}
