import 'package:habit_tracker/data/database/Imp/habit_database_imp.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/infostructure/base_mapper.dart';

class HabitDatabaseMapper extends BaseMapper<HabitModel, Habit> {
  @override
  HabitModel map(Habit r) {
    return HabitModel(id :r.id,
        serverId: r.serverId,
        name: r.name,
        description: r.description,
        type: r.habitType,
        priority: r.habitPriority,
        frequency: r.frequency,
        count: r.count,
        doneDates: r.dates,
        dateOfUpdate: r.date);
  }

  @override
  Habit revertMap(HabitModel t) {
    return Habit(
        id: t.id!,
        serverId: t.serverId,
        name: t.name,
        description: t.description,
        habitType: t.type,
        habitPriority: t.priority,
        frequency: t.frequency,
        count: t.count,
        dates: t.doneDates,
        date: t.dateOfUpdate);
  }
}
