import 'package:habit_tracker/data/database/Models/habit.dart';
import 'package:habit_tracker/data/database/habit_database_interface.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'Converters/datetime_list_converter.dart';

part 'habit_database_imp.g.dart';

@UseMoor(tables: [Habits])
class HabitDataBaseImp extends _$HabitDataBaseImp implements HabitDataBase {
  HabitDataBaseImp()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: 'habitDb.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  @override
  Future<List<Habit>> getAllHabits() => select(habits).get();

  @override
  Future<Habit> getHabitById(String id) async => (select(habits)..where((tbl)
  => tbl.id.equals(id)))
      .getSingle();

  @override
  Future<List<Habit>> getHabitsOrderByDate()
  => (select(habits)..orderBy([(x) => OrderingTerm.asc(x.date)]))
      .get();

  @override
  Future<List<Habit>> getHabitsDescOrderByDate()
  => (select(habits)..orderBy([(x) => OrderingTerm.desc(x.date)]))
      .get();

  @override
  Future insertHabit(Habit habit) => into(habits).insert(habit, mode: InsertMode.insertOrReplace);

  @override
  Future updateHabit(Habit habit) => update(habits).replace(habit);
}

class Habits extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  DateTimeColumn get date => dateTime()();

  TextColumn get dates => text().map(DatesTypeConverter())();

  IntColumn get habitType => intEnum<HabitType>()();

  IntColumn get habitPriority => intEnum<HabitPriority>()();

  IntColumn get frequency => integer()();

  IntColumn get count => integer()();
}