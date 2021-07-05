import 'package:habit_tracker/domain/Models/habit.dart';

extension HabitTypeExtensions on HabitType{

  String get localizedString{
    switch(this) {
      case HabitType.GOOD:
        return 'Хорошая привычка';
      case HabitType.BAD:
        return 'Плохая привычка';
    }
  }
}