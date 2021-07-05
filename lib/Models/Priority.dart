enum Priority{
  HIGH,
  NORMAL,
  LOW
}

extension Priorities on Priority {
  static const String HIGH = 'Высокий';
  static const String NORMAL = 'Нормальный';
  static const String LOW = 'Низкий';

  String? get localizedString {
    switch (this) {
      case Priority.HIGH:
        return HIGH;
      case Priority.NORMAL:
        return NORMAL;
      case Priority.LOW:
        return LOW;
      default:
        return null;
    }
  }

  static Priority? fromString(String str){
    switch(str){
      case HIGH:
        return Priority.HIGH;
      case NORMAL:
        return Priority.NORMAL;
      case LOW:
        return Priority.LOW;
      default:
        return null;
    }
  }
}