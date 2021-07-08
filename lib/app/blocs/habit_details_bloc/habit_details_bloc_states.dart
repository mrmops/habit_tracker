import 'package:habit_tracker/domain/Models/habit.dart';

abstract class HabitModelState {

}

class HabitModelLoading extends HabitModelState{

}

class HabitModelLoaded extends HabitModelState{
  final HabitModelInfo habitInfo;

  HabitModelLoaded(this.habitInfo);
}

class HabitModelInfo {
  final String name;
  final String? description;
  final HabitType type;
  final HabitPriority priority;
  final int frequency;
  final int count;

  HabitModelInfo(this.name, this.description, this.type, this.priority,
      this.frequency, this.count);
}