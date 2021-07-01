class Habit {
  String _id;
  String get id => _id;
  String name = '';
  String? description;
  DateTime date = DateTime.now();
  List<DateTime> _doneDates = List.empty();
  List<DateTime> get doneDates => _doneDates;
  HabitType type;
  HabitPriority priority;
  int frequency;
  int count;

  Habit(this._id,
      {this.name = '',
      this.description = '',
      this.type = HabitType.GOOD,
      this.priority = HabitPriority.NORMAL,
      this.frequency = 1,
      this.count = 1,
      doneDates}){
     if(doneDates != null)
        this._doneDates = doneDates;
  }
}

enum HabitPriority { HIGH, NORMAL, LOW }

enum HabitType { GOOD, BAD }
