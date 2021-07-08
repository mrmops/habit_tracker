import 'package:habit_tracker/domain/Models/habit.dart';

abstract class HabitListBlocState {}

class HabitsListLoaded extends HabitListBlocState{
  List<HabitModel> _habits;
  List<HabitModel> get habits => _habits;
  HabitsListLoaded(this._habits);
}

class HabitsListLoading extends HabitListBlocState{

}