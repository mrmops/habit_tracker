class HabitModel {
  int? id;

  String? _serverId;

  String? get serverId => _serverId;

  String name = '';
  String? description;
  DateTime dateOfUpdate = DateTime.now();

  List<DateTime> _doneDates = List.empty();

  List<DateTime> get doneDates => _doneDates;

  HabitType type;
  HabitPriority priority;
  int frequency;
  int count;

  HabitModel(
      {this.id,
      String? serverId,
      this.name = '',
      this.description = '',
      this.type = HabitType.GOOD,
      this.priority = HabitPriority.NORMAL,
      this.frequency = 1,
      this.count = 1,
      List<DateTime>? doneDates,
      DateTime? dateOfUpdate}) {
    if (doneDates != null) this._doneDates = doneDates;

    if (dateOfUpdate != null) this.dateOfUpdate = dateOfUpdate;

    this._serverId = serverId;
  }
}

enum HabitPriority { HIGH, NORMAL, LOW }

enum HabitType { GOOD, BAD }
