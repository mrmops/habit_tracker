import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/habit_service.dart';
import 'package:stream_transform/stream_transform.dart';

import 'habits_list_bloc_states.dart';

class HabitsListBloc extends Cubit<HabitListBlocState> {
  HabitService _habitService;

  late Stream<List<HabitModel>> habits;
  ListParameters _listParameters = ListParameters();

  String? get currentFilter => _listParameters.filter;

  bool get currentRevertSort => _listParameters.isRevertSort;

  StreamController<ListParameters> _listParametersStream =
      StreamController();

  HabitsListBloc(this._habitService) : super(HabitsListLoading()) {
    habits = _listParametersStream.stream.switchMap((listParameters) {
      return _habitService.getHabits(
          listParameters.filter, listParameters.isRevertSort);
    });
    habits.listen((data) => emit(HabitsListLoaded(data)));
    updateParameters();
  }

  @override
  Future<void> close() {
    _listParametersStream.close();
    return super.close();
  }

  void changeFilter(String? filter) {
    _listParameters.filter = filter;
    updateParameters();
  }

  void changeSort(bool revertSort) {
    _listParameters.isRevertSort = revertSort;
    updateParameters();
  }

  void updateParameters() {
    emit(HabitsListLoading());
    _listParametersStream.sink.add(_listParameters);
  }

  Future doneHabit(HabitModel model) async {
    await _habitService.doneHabit(model);
  }

  Future<int> repsLeft(HabitModel model) async {
    return await _habitService.repsLeft(model);
  }
}

class ListParameters {
  String? filter;
  bool isRevertSort = false;
}
