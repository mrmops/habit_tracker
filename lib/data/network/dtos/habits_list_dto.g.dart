// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitsListDto _$HabitsListDtoFromJson(Map<String, dynamic> json) {
  return HabitsListDto(
    json['count'] as int,
    (json['habits'] as List<dynamic>?)
        ?.map((e) => HabitDto.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HabitsListDtoToJson(HabitsListDto instance) =>
    <String, dynamic>{
      'count': instance.count,
      'habits': instance.habits,
    };
