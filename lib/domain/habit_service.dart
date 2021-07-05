import 'Models/habit.dart';

abstract class HabitService{

  Stream<List<HabitModel>> getHabits(String filter, bool revertSort);

  Future updateHabitsFromServer();

  Future addLocalHabitsToServer();

  Future<bool> saveHabit(HabitModel habit);

  Future<bool> doneHabit(String habitServerId);

  Future<int> remainingReps(String habitServerId);
}