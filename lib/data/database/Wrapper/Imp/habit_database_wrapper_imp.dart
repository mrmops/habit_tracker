import 'package:habit_tracker/data/database/Imp/habit_database_imp.dart';
import 'package:habit_tracker/data/database/Models/habit.dart';
import 'package:habit_tracker/data/database/Wrapper/habit_database_wrapper_interface.dart';
import 'package:habit_tracker/data/database/habit_database_interface.dart';
import 'package:habit_tracker/infostructure/base_mapper.dart';

class HabitDatabaseWrapperImp extends HabitDatabaseWrapper {
  HabitDataBase _habitDataBase;
  BaseMapper<HabitModel, Habit> _mapper;

  HabitDatabaseWrapperImp(this._habitDataBase, this._mapper);

  @override
  Future<List<HabitModel>> getAllHabitModels() async {
    var result = await _habitDataBase.getAllHabits();
    return _mapper.mapIterable(result).toList();
  }

  @override
  Future<HabitModel> getHabitModelById(String id) async {
    var result = await _habitDataBase.getHabitById(id);
    return _mapper.map(result);
  }

  @override
  Future<List<HabitModel>> getHabitModelsDescOrderByDate() async {
    var result = await _habitDataBase.getHabitsDescOrderByDate();
    return _mapper.mapIterable(result).toList();
  }

  @override
  Future<List<HabitModel>> getHabitModelsOrderByDate() async {
    var result = await _habitDataBase.getHabitsOrderByDate();
    return _mapper.mapIterable(result).toList();
  }

  @override
  Future insertHabitModel(HabitModel habitModel) async =>
      await _habitDataBase.insertHabit(_mapper.revertMap(habitModel));

  @override
  Future updateHabitModel(HabitModel habitModel) async =>
      await _habitDataBase.updateHabit(_mapper.revertMap(habitModel));
}
