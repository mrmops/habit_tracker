
import 'package:habit_tracker/domain/Models/habit.dart';

abstract class HabitDatabaseRepository{

  Stream<List<HabitModel>> watchAllHabitModels();

  Future<List<HabitModel>> getAllHabitModels();

  Stream<HabitModel> watchHabitModelByServerId(String id);

  Future<HabitModel?> getHabitModelByServerId(String id);

  Stream<HabitModel> watchHabitModelById(int id);

  Future<HabitModel> getHabitModelById(int id);

  Stream<List<HabitModel>> watchHabitModelsOrderByDate(bool revert);

  Future<List<HabitModel>> getHabitModelsOrderByDate(bool revert);

  Future<HabitModel> insertHabitModel(
      String? serverId,
      String name,
      String description,
      DateTime date,
      List<DateTime> dates,
      HabitType habitType,
      HabitPriority habitPriority,
      int frequency,
      int count);

  Future addOrUpdateHabitModel(HabitModel habitModel);
}