// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitDto _$HabitDtoFromJson(Map<String, dynamic> json) {
  return HabitDto(
    id: json['id'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    type: HabitDto.typeFromJson(json['type'] as int?),
    priority: HabitDto.priorityFromJson(json['priority'] as int?),
    frequency: json['frequency'] as int?,
    count: json['count'] as int?,
    doneDates: HabitDto.datesFromDto(json['doneDates'] as List<int>?),
    dateOfUpdate:
        json['date'] == null ? null : DateTime.parse(json['date'] as String),
  )..color = json['color'] as int?;
}

Map<String, dynamic> _$HabitDtoToJson(HabitDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
      'description': instance.description,
      'date': instance.dateOfUpdate?.toIso8601String(),
      'doneDates': HabitDto.datesToDto(instance.doneDates),
      'type': HabitDto.typeToJson(instance.type),
      'priority': HabitDto.priorityToJson(instance.priority),
      'frequency': instance.frequency,
      'count': instance.count,
    };
