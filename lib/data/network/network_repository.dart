import 'package:habit_tracker/data/database/Models/habit.dart';

abstract class NetworkRepository{
  Future<List<HabitModel>> getHabits();
  
  Future<String> addHabit(HabitModel dto);
  
  Future<bool> deleteHabit(String id);
  
  Future<bool> patchHabit(String id, HabitModel habit);
  
  Future<bool> doneHabit(DateTime dto);
}