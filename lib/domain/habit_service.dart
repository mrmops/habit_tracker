import 'Models/habit.dart';

abstract class HabitService{

  Stream<List<HabitModel>> getHabits(String? filter, bool revertSort);

  Future updateHabitsFromServer();

  Future addLocalHabitsToServer();

  Future<bool> saveHabit(HabitModel habit);

  Future<bool> doneHabit(HabitModel habit);

  Future<int> repsLeft(HabitModel habit);

  Stream<HabitModel> watchHabitModelByServerId(String id);

  Future<HabitModel?> getHabitModelByServerId(String id);

  Stream<HabitModel> watchHabitModelById(int id);

  Future<HabitModel?> getHabitModelById(int id);
}