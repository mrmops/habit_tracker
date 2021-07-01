import 'Imp/habit_database_imp.dart';

abstract class HabitDataBase {
  Future<List<Habit>> getAllHabits();

  Future<Habit> getHabitById(String id);

  Future<List<Habit>> getHabitsOrderByDate();

  Future<List<Habit>> getHabitsDescOrderByDate();

  Future insertHabit(Habit habit);

  Future updateHabit(Habit habit);
}
