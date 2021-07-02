import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:habit_tracker/data/network/Dtos/date_time_dto.dart';

part 'habit_dto.g.dart';

@JsonSerializable()
class HabitDto {
  String? id;
  String? title = '';
  int? color = 0;
  String? description;
  @JsonKey(
      name: 'date',
      toJson: DateTimeDto.dateToJson,
      fromJson: DateTimeDto.dateFromJson)
  DateTime? dateOfUpdate = DateTime.now();
  @JsonKey(toJson: datesToDto, fromJson: datesFromDto)
  List<DateTime>? doneDates = List.empty();
  @JsonKey(fromJson: typeFromJson, toJson: typeToJson)
  HabitType? type;
  @JsonKey(fromJson: priorityFromJson, toJson: priorityToJson)
  HabitPriority? priority;
  int? frequency;
  int? count;

  HabitDto(
      {required this.id,
      required this.title,
      this.description,
      required this.type,
      required this.priority,
      required this.frequency,
      required this.count,
      required this.doneDates,
      required this.dateOfUpdate});

  factory HabitDto.fromJson(Map<String, dynamic> json) =>
      _$HabitDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HabitDtoToJson(this);

  static HabitType? typeFromJson(int? intHabitType) =>
      intHabitType != null ? HabitType.values[intHabitType] : null;

  static int? typeToJson(HabitType? habitType) => habitType?.index;

  static HabitPriority? priorityFromJson(int? intHabitPriority) =>
      intHabitPriority != null ? HabitPriority.values[intHabitPriority] : null;

  static int? priorityToJson(HabitPriority? habitPriority) =>
      habitPriority?.index;

  static List<int>? datesToDto(List<DateTime>? dates) {
    return dates?.map((e) => dateToJson(e)).toList();
  }

  static List<DateTime>? datesFromDto(List<int>? dates) {
    return dates?.map((e) => dateFromJson(e)).toList();
  }

  static DateTime dateFromJson(int json) {
    return DateTime.fromMillisecondsSinceEpoch(json);
  }

  static int dateToJson(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }
}
