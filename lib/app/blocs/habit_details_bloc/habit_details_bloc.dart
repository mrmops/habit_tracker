import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/habit_service.dart';

import 'habit_details_bloc_states.dart';

class HabitDetailsBloc extends Cubit<HabitModelState> {
  HabitService _habitService;
  HabitModel? _currentHabit;

  String name = '';
  String? description;
  HabitType type = HabitType.BAD;
  HabitPriority priority = HabitPriority.NORMAL;
  int frequency = 1;
  int count = 1;

  HabitDetailsBloc(this._habitService, {int? habitId})
      : super(HabitModelLoading()) {
    if (habitId != null) {
      loadHabit(habitId);
    } else{
      emitValue();
    }
  }

  Future loadHabit(int id) async {
    _currentHabit = await _habitService.getHabitModelById(id);
    if (_currentHabit != null) {
      setValues(_currentHabit!);
    }

    emitValue();
  }

  void emitValue() {
    var currentState = createCurrentState();
    emit(HabitModelLoaded(currentState));
  }

  bool submit() {
    try {
      if (_currentHabit == null) {
        _currentHabit = HabitModel();
      }

      getValues(_currentHabit!);
      _habitService.saveHabit(_currentHabit!);
      return true;
    } catch (e) {}

    return false;
  }

  void getValues(HabitModel to) {
    to.name = name;
    to.description = description;
    to.type = type;
    to.priority = priority;
    to.frequency = frequency;
    to.count = count;
  }

  void setValues(HabitModel from) {
    name = from.name;
    description = from.description;
    type = from.type;
    priority = from.priority;
    frequency = from.frequency;
    count = from.count;
  }

  HabitModelInfo createCurrentState() {
    return HabitModelInfo(
        name, description, type, priority, frequency, count);
  }
}


