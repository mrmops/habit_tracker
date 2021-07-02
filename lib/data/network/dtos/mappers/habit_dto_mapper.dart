import 'package:habit_tracker/data/database/Models/habit.dart';
import 'package:habit_tracker/infostructure/base_mapper.dart';

import '../habit_dto.dart';

class HabitDtoMapper extends BaseMapper<HabitModel, HabitDto> {
  @override
  HabitModel map(HabitDto r) {
    return HabitModel(r.id,
        name: r.title ?? '',
        description: r.description,
        type: r.type ?? HabitType.GOOD,
        priority: r.priority ?? HabitPriority.NORMAL,
        frequency: r.frequency ?? 1,
        count: r.count ?? 1,
        dateOfUpdate: r.dateOfUpdate,
        doneDates: r.doneDates);
  }

  @override
  HabitDto revertMap(HabitModel t) {
    return HabitDto(id: t.id,
        title: t.name,
        description: t.description,
        type: t.type,
        priority: t.priority,
        frequency: t.frequency,
        count: t.count,
        dateOfUpdate: t.dateOfUpdate,
        doneDates: t.doneDates);
  }
}
