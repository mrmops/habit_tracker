import 'package:habit_tracker/data/database/Imp/habit_database_imp.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/interfaces/habit_database_repository.dart';
import 'package:habit_tracker/data/database/habit_database_interface.dart';
import 'package:habit_tracker/infostructure/base_mapper.dart';
import 'package:moor_flutter/moor_flutter.dart';

class HabitDatabaseWrapperImp extends HabitDatabaseRepository {
  HabitDataBase _habitDataBase;
  BaseMapper<HabitModel, Habit> _mapper;

  HabitDatabaseWrapperImp(this._habitDataBase, this._mapper);

  @override
  Stream<List<HabitModel>> watchAllHabitModels() {
    return _habitDataBase
        .watchAllHabits()
        .map((event) => _mapper.mapIterable(event).toList());
  }

  @override
  Future<List<HabitModel>> getAllHabitModels() async {
    var habits = await _habitDataBase.getAllHabits();
    return _mapper.mapIterable(habits).toList();
  }

  @override
  Stream<HabitModel> watchHabitModelByServerId(String id) {
    return _habitDataBase
        .watchHabitByServerId(id)
        .map((event) => _mapper.map(event));
  }

  @override
  Future<HabitModel?> getHabitModelByServerId(String id) async {
    var habit = await _habitDataBase.getHabitByServerId(id);
    return _mapper.tryMap(habit);
  }

  @override
  Stream<HabitModel> watchHabitModelById(int id) {
    return _habitDataBase
        .watchHabitById(id)
        .map((event) => _mapper.map(event));
  }

  @override
  Future<HabitModel> getHabitModelById(int id) async {
    var habit = await _habitDataBase.getHabitById(id);
    return _mapper.map(habit);
  }

  @override
  Stream<List<HabitModel>> watchHabitModelsOrderByDate(bool revert) {
    return _habitDataBase
        .watchHabitsOrderByDate(
        orderDirection: revert ? OrderingMode.desc : OrderingMode.asc)
        .map((event) => _mapper.mapIterable(event).toList());
  }

  @override
  Future<List<HabitModel>> getHabitModelsOrderByDate(bool revert) async {
    var habits = await _habitDataBase
        .getHabitsOrderByDate(
        orderDirection: revert ? OrderingMode.desc : OrderingMode.asc);

    return _mapper.mapIterable(habits).toList();
  }

  @override
  Future<HabitModel> insertHabitModel(String? serverId,
      String name,
      String description,
      DateTime date,
      List<DateTime> dates,
      HabitType habitType,
      HabitPriority habitPriority,
      int frequency,
      int count) async {
    var habitId = await _habitDataBase.insertHabit(
        serverId,
        name,
        description,
        date,
        dates,
        habitType,
        habitPriority,
        frequency,
        count);

    var habit = await _habitDataBase.getHabitById(habitId);
    return _mapper.map(habit);
  }

  @override
  Future<int> addOrUpdateHabitModel(HabitModel habitModel) async {
    if (habitModel.id != null) {
      return await _habitDataBase.updateHabit(_mapper.revertMap(habitModel));
    }

    var localHabit = await _habitDataBase
        .getHabitByServerId(habitModel.serverId);

    if (localHabit != null) {
      habitModel.id = localHabit.id;
      return await _habitDataBase.updateHabit(_mapper.revertMap(habitModel));
    }

    var habitId = await _habitDataBase.insertHabit(
        habitModel.serverId,
        habitModel.name,
        habitModel.description,
        habitModel.dateOfUpdate,
        habitModel.doneDates,
        habitModel.type,
        habitModel.priority,
        habitModel.frequency,
        habitModel.count);
    habitModel.id = habitId;
    return habitId;
  }
}
