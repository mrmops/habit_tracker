import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/habit_service.dart';
import 'package:stream_transform/stream_transform.dart';

class HabitsListBloc  extends Cubit<List<HabitModel>> {

  HabitService _habitService;

  late Stream<List<HabitModel>> habits;
  FilteringOptions _filteringOptions = FilteringOptions();
  String? get currentFilter => _filteringOptions.filter;
  bool get currentRevertSort => _filteringOptions.revertSort;

  StreamController<FilteringOptions> _filteringOptionsStream = StreamController();

  HabitsListBloc(this._habitService) : super(List.empty()) {
    habits = _filteringOptionsStream.stream.switchMap((filteringOptions) => _habitService.getHabits(filteringOptions.filter, filteringOptions.revertSort));
    habits.listen((event) => emit(event));
    _filteringOptionsStream.sink.add(_filteringOptions);
  }

  @override
  Future<void> close() {
    _filteringOptionsStream.close();
    return super.close();
  }

  void changeFilter(String? filter){
    _filteringOptions.filter = filter;
    _filteringOptionsStream.sink.add(_filteringOptions);
  }

  void changeSort(bool revertSort){
    _filteringOptions.revertSort = revertSort;
    _filteringOptionsStream.sink.add(_filteringOptions);
  }
}

class FilteringOptions {
  String? filter;
  bool revertSort = false;
}