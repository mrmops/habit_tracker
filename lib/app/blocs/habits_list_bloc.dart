import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/habit_service.dart';
import 'package:stream_transform/stream_transform.dart';

class HabitsListBloc  extends Cubit<List<HabitModel>> {

  HabitService _habitService;

  late Stream<List<HabitModel>> habits;

  StreamController<FilteringOptions> _filteringOptions = StreamController();

  HabitsListBloc(this._habitService) : super(List.empty()) {
    habits = _filteringOptions.stream.switchMap((filteringOptions) => _habitService.getHabits(filteringOptions.filter, filteringOptions.revertSort));
    habits.listen((event) => emit(event));
    _filteringOptions.sink.add(FilteringOptions());
  }

  @override
  Future<void> close() {
    _filteringOptions.close();
    return super.close();
  }
}

class FilteringOptions {
  String? filter;
  bool revertSort = false;
}