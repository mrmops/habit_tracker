import 'package:json_annotation/json_annotation.dart';

part 'date_time_dto.g.dart';

@JsonSerializable()
class DateTimeDto {
  @JsonKey(name: 'date', fromJson: dateFromJson, toJson: dateToJson)
  DateTime? dateTime;

  DateTimeDto(this.dateTime);

  factory DateTimeDto.fromJson(Map<String, dynamic> json) =>
      _$DateTimeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DateTimeDtoToJson(this);

  static DateTime? dateFromJson(int? json) {
    return json != null ? DateTime.fromMillisecondsSinceEpoch(json) : null;
  }

  static int? dateToJson(DateTime? dateTime) {
    return dateTime?.millisecondsSinceEpoch;
  }
}
