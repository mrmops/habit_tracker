import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/habit_service.dart';

class HabitDetailsBloc extends Cubit<HabitModelEditState> {
  HabitService _habitService;
  HabitModel? _currentHabit;

  String name = '';
  String? description;
  HabitType type = HabitType.BAD;
  HabitPriority priority = HabitPriority.NORMAL;
  int frequency = 1;
  int count = 1;

  HabitDetailsBloc(this._habitService, {int? habitId})
      : super(HabitModelEditState('', null, HabitType.BAD, HabitPriority.NORMAL, 1, 1)) {
    if (habitId != null) loadHabit(habitId);
  }

  Future loadHabit(int id) async {
    _currentHabit = await _habitService.getHabitModelById(id);
    if (_currentHabit != null) {
      setValues(_currentHabit!);
      var currentState = createCurrentState();
      emit(currentState);
    }
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



  HabitModelEditState createCurrentState() {
    return HabitModelEditState(
        name, description, type, priority, frequency, count);
  }
}

class HabitModelEditState {
  String _name;
  String? _description;
  HabitType _type;
  HabitPriority _priority;
  int _frequency;
  int _count;

  HabitModelEditState(this._name, this._description, this._type, this._priority,
      this._frequency, this._count);

  String get name => _name;

  String? get description => _description;

  HabitType get type => _type;

  HabitPriority get priority => _priority;

  int get frequency => _frequency;

  int get count => _count;
}
