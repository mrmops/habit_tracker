import 'package:habit_tracker/domain/Models/habit.dart';

abstract class HabitNetworkRepository{
  Future<List<HabitModel>> getHabits();
  
  Future<String> addHabit(HabitModel dto);

  Future<String> addOrUpdateHabit(HabitModel dto);
  
  Future<bool> deleteHabit(String id);
  
  Future<bool> patchHabit(String id, HabitModel habit);
  
  Future<bool> doneHabit(String habitId, DateTime dto);
}