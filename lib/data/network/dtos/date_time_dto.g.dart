// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_time_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTimeDto _$DateTimeDtoFromJson(Map<String, dynamic> json) {
  return DateTimeDto(
    DateTimeDto.dateFromJson(json['date'] as int?),
  );
}

Map<String, dynamic> _$DateTimeDtoToJson(DateTimeDto instance) =>
    <String, dynamic>{
      'date': DateTimeDto.dateToJson(instance.dateTime),
    };
