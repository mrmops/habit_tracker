// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitDto _$HabitDtoFromJson(Map<String, dynamic> json) {
  return HabitDto(
    id: json['uid'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    type: HabitDto.typeFromJson(json['type'] as int?),
    priority: HabitDto.priorityFromJson(json['priority'] as int?),
    frequency: json['frequency'] as int?,
    count: json['count'] as int?,
    doneDates: HabitDto.datesFromDto(json['doneDates'] as List<int>?),
    dateOfUpdate: HabitDto.tryDateFromJson(json['date'] as int?),
  )..color = json['color'] as int?;
}

Map<String, dynamic> _$HabitDtoToJson(HabitDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uid', instance.id);
  val['title'] = instance.title;
  val['color'] = instance.color;
  val['description'] = instance.description;
  val['date'] = HabitDto.tryDateToJson(instance.dateOfUpdate);
  val['doneDates'] = HabitDto.datesToDto(instance.doneDates);
  val['type'] = HabitDto.typeToJson(instance.type);
  val['priority'] = HabitDto.priorityToJson(instance.priority);
  val['frequency'] = instance.frequency;
  val['count'] = instance.count;
  return val;
}
