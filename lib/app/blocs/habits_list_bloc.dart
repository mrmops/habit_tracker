import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/habit_service.dart';
import 'package:stream_transform/stream_transform.dart';

class HabitsListBloc extends Cubit<List<HabitModel>> {
  HabitService _habitService;

  late Stream<List<HabitModel>> habits;
  FilteringOptions _filteringOptions = FilteringOptions();

  String? get currentFilter => _filteringOptions.filter;

  bool get currentRevertSort => _filteringOptions.isRevertSort;

  StreamController<FilteringOptions> _filteringOptionsStream =
      StreamController();

  HabitsListBloc(this._habitService) : super(List.empty()) {
    habits = _filteringOptionsStream.stream.switchMap((filteringOptions) {
      return _habitService.getHabits(
          filteringOptions.filter, filteringOptions.isRevertSort);
    });
    habits.listen((data) {
      emit(data);
    });
    _filteringOptionsStream.sink.add(_filteringOptions);
  }

  @override
  Future<void> close() {
    _filteringOptionsStream.close();
    return super.close();
  }

  void changeFilter(String? filter) {
    _filteringOptions.filter = filter;
    _filteringOptionsStream.sink.add(_filteringOptions);
  }

  void changeSort(bool revertSort) {
    _filteringOptions.isRevertSort = revertSort;
    _filteringOptionsStream.sink.add(_filteringOptions);
  }
}

class FilteringOptions {
  String? filter;
  bool isRevertSort = false;
}
