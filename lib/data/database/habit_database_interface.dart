import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'Imp/habit_database_imp.dart';

abstract class HabitDataBase {
  Stream<List<Habit>> watchAllHabits();
  Future<List<Habit>> getAllHabits();

  Stream<Habit> watchHabitByServerId(String id);
  Future<Habit?> getHabitByServerId(String? id);

  Stream<Habit> watchHabitById(int id);
  Future<Habit?> getHabitById(int id);

  Stream<List<Habit>> watchHabitsOrderByDate(
      {OrderingMode orderDirection = OrderingMode.asc});
  Future<List<Habit>> getHabitsOrderByDate(
      {OrderingMode orderDirection = OrderingMode.asc});

  Future<int> insertHabit(
      String? serverId,
      String name,
      String? description,
      DateTime date,
      List<DateTime> dates,
      HabitType habitType,
      HabitPriority habitPriority,
      int frequency,
      int count);

  Future<int> updateHabit(Habit habit);

  Stream<List<Habit>> watchHabitsUpdatedAfter(DateTime date);
  Future<List<Habit>> getHabitsUpdatedAfter(DateTime date);
}
