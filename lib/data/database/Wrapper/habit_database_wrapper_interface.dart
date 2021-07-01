import 'package:habit_tracker/data/database/Models/habit.dart';

abstract class HabitDatabaseWrapper{

  Future<List<HabitModel>> getAllHabitModels();

  Future<HabitModel> getHabitModelById(String id);

  Future<List<HabitModel>> getHabitModelsOrderByDate();

  Future<List<HabitModel>> getHabitModelsDescOrderByDate();

  Future insertHabitModel(HabitModel habitModel);

  Future updateHabitModel(HabitModel habitModel);
}