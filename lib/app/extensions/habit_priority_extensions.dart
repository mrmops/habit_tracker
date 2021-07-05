import 'package:habit_tracker/domain/Models/habit.dart';

extension Priorities on HabitPriority {
  static const String HIGH = 'Высокий';
  static const String NORMAL = 'Нормальный';
  static const String LOW = 'Низкий';

  String get localizedString {
    switch (this) {
      case HabitPriority.HIGH:
        return HIGH;
      case HabitPriority.NORMAL:
        return NORMAL;
      case HabitPriority.LOW:
        return LOW;
    }
  }

  static HabitPriority? fromString(String str){
    switch(str){
      case HIGH:
        return HabitPriority.HIGH;
      case NORMAL:
        return HabitPriority.NORMAL;
      case LOW:
        return HabitPriority.LOW;
      default:
        return null;
    }
  }
}