import 'package:habit_tracker/data/database/habit_database_interface.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'Converters/datetime_list_converter.dart';

part 'habit_database_imp.g.dart';

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get serverId => text().nullable()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get date => dateTime()();

  TextColumn get dates => text().map(DatesTypeConverter())();

  IntColumn get habitType => intEnum<HabitType>()();

  IntColumn get habitPriority => intEnum<HabitPriority>()();

  IntColumn get frequency => integer()();

  IntColumn get count => integer()();
}

@UseMoor(tables: [Habits])
class HabitDataBaseImp extends _$HabitDataBaseImp implements HabitDataBase {
  HabitDataBaseImp()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'habitDb.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  @override
  Stream<List<Habit>> watchAllHabits() => select(habits).watch();

  @override
  Future<List<Habit>> getAllHabits() => select(habits).get();

  @override
  Stream<Habit> watchHabitByServerId(String serverId) =>
      (select(habits)..where((tbl) => tbl.serverId.equals(serverId)))
          .watchSingle();

  @override
  Future<Habit?> getHabitByServerId(String? serverId) => (select(habits)
        ..where((tbl) => tbl.serverId.isNull())
        ..where((tbl) => tbl.serverId.equals(serverId)))
      .getSingleOrNull();

  @override
  Stream<Habit> watchHabitById(int id) =>
      (select(habits)..where((tbl) => tbl.id.equals(id))).watchSingle();

  @override
  Future<Habit?> getHabitById(int id) =>
      (select(habits)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  @override
  Stream<List<Habit>> watchHabitsOrderByDate(
          {OrderingMode orderDirection = OrderingMode.asc}) =>
      (select(habits)
            ..orderBy([
              (x) => OrderingTerm(expression: x.date, mode: orderDirection)
            ]))
          .watch();

  @override
  Future<List<Habit>> getHabitsOrderByDate(
          {OrderingMode orderDirection = OrderingMode.asc}) =>
      (select(habits)
            ..orderBy([
              (x) => OrderingTerm(expression: x.date, mode: orderDirection)
            ]))
          .get();

  @override
  Future<int> insertHabit(
          String? serverId,
          String name,
          String? description,
          DateTime date,
          List<DateTime> dates,
          HabitType habitType,
          HabitPriority habitPriority,
          int frequency,
          int count) =>
      into(habits).insert(
          HabitsCompanion.insert(
              serverId: Value(serverId),
              name: name,
              date: date,
              dates: dates,
              habitType: habitType,
              habitPriority: habitPriority,
              frequency: frequency,
              count: count),
          mode: InsertMode.insertOrReplace);

  @override
  Future<int> updateHabit(Habit habit) =>
      into(habits).insert(habit, mode: InsertMode.insertOrReplace);

  @override
  Future<List<Habit>> getHabitsUpdatedAfter(DateTime date) {
    return (select(habits)..where((tbl) => tbl.date.isBiggerThanValue(date))).get();
  }

  @override
  Stream<List<Habit>> watchHabitsUpdatedAfter(DateTime date) {
    return (select(habits)..where((tbl) => tbl.date.isSmallerThanValue(date))).watch();
  }
}
