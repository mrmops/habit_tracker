// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_database_imp.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String? serverId;
  final String name;
  final String? description;
  final DateTime date;
  final List<DateTime> dates;
  final HabitType habitType;
  final HabitPriority habitPriority;
  final int frequency;
  final int count;
  Habit(
      {required this.id,
      this.serverId,
      required this.name,
      this.description,
      required this.date,
      required this.dates,
      required this.habitType,
      required this.habitPriority,
      required this.frequency,
      required this.count});
  factory Habit.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Habit(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      serverId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}server_id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      dates: $HabitsTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}dates']))!,
      habitType: $HabitsTable.$converter1.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}habit_type']))!,
      habitPriority: $HabitsTable.$converter2.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}habit_priority']))!,
      frequency: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}frequency'])!,
      count: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}count'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String?>(serverId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String?>(description);
    }
    map['date'] = Variable<DateTime>(date);
    {
      final converter = $HabitsTable.$converter0;
      map['dates'] = Variable<String>(converter.mapToSql(dates)!);
    }
    {
      final converter = $HabitsTable.$converter1;
      map['habit_type'] = Variable<int>(converter.mapToSql(habitType)!);
    }
    {
      final converter = $HabitsTable.$converter2;
      map['habit_priority'] = Variable<int>(converter.mapToSql(habitPriority)!);
    }
    map['frequency'] = Variable<int>(frequency);
    map['count'] = Variable<int>(count);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      date: Value(date),
      dates: Value(dates),
      habitType: Value(habitType),
      habitPriority: Value(habitPriority),
      frequency: Value(frequency),
      count: Value(count),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      dates: serializer.fromJson<List<DateTime>>(json['dates']),
      habitType: serializer.fromJson<HabitType>(json['habitType']),
      habitPriority: serializer.fromJson<HabitPriority>(json['habitPriority']),
      frequency: serializer.fromJson<int>(json['frequency']),
      count: serializer.fromJson<int>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'date': serializer.toJson<DateTime>(date),
      'dates': serializer.toJson<List<DateTime>>(dates),
      'habitType': serializer.toJson<HabitType>(habitType),
      'habitPriority': serializer.toJson<HabitPriority>(habitPriority),
      'frequency': serializer.toJson<int>(frequency),
      'count': serializer.toJson<int>(count),
    };
  }

  Habit copyWith(
          {int? id,
          String? serverId,
          String? name,
          String? description,
          DateTime? date,
          List<DateTime>? dates,
          HabitType? habitType,
          HabitPriority? habitPriority,
          int? frequency,
          int? count}) =>
      Habit(
        id: id ?? this.id,
        serverId: serverId ?? this.serverId,
        name: name ?? this.name,
        description: description ?? this.description,
        date: date ?? this.date,
        dates: dates ?? this.dates,
        habitType: habitType ?? this.habitType,
        habitPriority: habitPriority ?? this.habitPriority,
        frequency: frequency ?? this.frequency,
        count: count ?? this.count,
      );
  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('dates: $dates, ')
          ..write('habitType: $habitType, ')
          ..write('habitPriority: $habitPriority, ')
          ..write('frequency: $frequency, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          serverId.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(
                      date.hashCode,
                      $mrjc(
                          dates.hashCode,
                          $mrjc(
                              habitType.hashCode,
                              $mrjc(
                                  habitPriority.hashCode,
                                  $mrjc(frequency.hashCode,
                                      count.hashCode))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.name == this.name &&
          other.description == this.description &&
          other.date == this.date &&
          other.dates == this.dates &&
          other.habitType == this.habitType &&
          other.habitPriority == this.habitPriority &&
          other.frequency == this.frequency &&
          other.count == this.count);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String?> serverId;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> date;
  final Value<List<DateTime>> dates;
  final Value<HabitType> habitType;
  final Value<HabitPriority> habitPriority;
  final Value<int> frequency;
  final Value<int> count;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.dates = const Value.absent(),
    this.habitType = const Value.absent(),
    this.habitPriority = const Value.absent(),
    this.frequency = const Value.absent(),
    this.count = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required DateTime date,
    required List<DateTime> dates,
    required HabitType habitType,
    required HabitPriority habitPriority,
    required int frequency,
    required int count,
  })  : name = Value(name),
        date = Value(date),
        dates = Value(dates),
        habitType = Value(habitType),
        habitPriority = Value(habitPriority),
        frequency = Value(frequency),
        count = Value(count);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String?>? serverId,
    Expression<String>? name,
    Expression<String?>? description,
    Expression<DateTime>? date,
    Expression<List<DateTime>>? dates,
    Expression<HabitType>? habitType,
    Expression<HabitPriority>? habitPriority,
    Expression<int>? frequency,
    Expression<int>? count,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (dates != null) 'dates': dates,
      if (habitType != null) 'habit_type': habitType,
      if (habitPriority != null) 'habit_priority': habitPriority,
      if (frequency != null) 'frequency': frequency,
      if (count != null) 'count': count,
    });
  }

  HabitsCompanion copyWith(
      {Value<int>? id,
      Value<String?>? serverId,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? date,
      Value<List<DateTime>>? dates,
      Value<HabitType>? habitType,
      Value<HabitPriority>? habitPriority,
      Value<int>? frequency,
      Value<int>? count}) {
    return HabitsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      dates: dates ?? this.dates,
      habitType: habitType ?? this.habitType,
      habitPriority: habitPriority ?? this.habitPriority,
      frequency: frequency ?? this.frequency,
      count: count ?? this.count,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String?>(serverId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String?>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (dates.present) {
      final converter = $HabitsTable.$converter0;
      map['dates'] = Variable<String>(converter.mapToSql(dates.value)!);
    }
    if (habitType.present) {
      final converter = $HabitsTable.$converter1;
      map['habit_type'] = Variable<int>(converter.mapToSql(habitType.value)!);
    }
    if (habitPriority.present) {
      final converter = $HabitsTable.$converter2;
      map['habit_priority'] =
          Variable<int>(converter.mapToSql(habitPriority.value)!);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('dates: $dates, ')
          ..write('habitType: $habitType, ')
          ..write('habitPriority: $habitPriority, ')
          ..write('frequency: $frequency, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  final GeneratedDatabase _db;
  final String? _alias;
  $HabitsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _serverIdMeta = const VerificationMeta('serverId');
  @override
  late final GeneratedTextColumn serverId = _constructServerId();
  GeneratedTextColumn _constructServerId() {
    return GeneratedTextColumn(
      'server_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedTextColumn name = _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedTextColumn description = _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedDateTimeColumn date = _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _datesMeta = const VerificationMeta('dates');
  @override
  late final GeneratedTextColumn dates = _constructDates();
  GeneratedTextColumn _constructDates() {
    return GeneratedTextColumn(
      'dates',
      $tableName,
      false,
    );
  }

  final VerificationMeta _habitTypeMeta = const VerificationMeta('habitType');
  @override
  late final GeneratedIntColumn habitType = _constructHabitType();
  GeneratedIntColumn _constructHabitType() {
    return GeneratedIntColumn(
      'habit_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _habitPriorityMeta =
      const VerificationMeta('habitPriority');
  @override
  late final GeneratedIntColumn habitPriority = _constructHabitPriority();
  GeneratedIntColumn _constructHabitPriority() {
    return GeneratedIntColumn(
      'habit_priority',
      $tableName,
      false,
    );
  }

  final VerificationMeta _frequencyMeta = const VerificationMeta('frequency');
  @override
  late final GeneratedIntColumn frequency = _constructFrequency();
  GeneratedIntColumn _constructFrequency() {
    return GeneratedIntColumn(
      'frequency',
      $tableName,
      false,
    );
  }

  final VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedIntColumn count = _constructCount();
  GeneratedIntColumn _constructCount() {
    return GeneratedIntColumn(
      'count',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        serverId,
        name,
        description,
        date,
        dates,
        habitType,
        habitPriority,
        frequency,
        count
      ];
  @override
  $HabitsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'habits';
  @override
  final String actualTableName = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    context.handle(_datesMeta, const VerificationResult.success());
    context.handle(_habitTypeMeta, const VerificationResult.success());
    context.handle(_habitPriorityMeta, const VerificationResult.success());
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Habit.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(_db, alias);
  }

  static TypeConverter<List<DateTime>, String> $converter0 =
      DatesTypeConverter();
  static TypeConverter<HabitType, int> $converter1 =
      const EnumIndexConverter<HabitType>(HabitType.values);
  static TypeConverter<HabitPriority, int> $converter2 =
      const EnumIndexConverter<HabitPriority>(HabitPriority.values);
}

abstract class _$HabitDataBaseImp extends GeneratedDatabase {
  _$HabitDataBaseImp(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $HabitsTable habits = $HabitsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [habits];
}
