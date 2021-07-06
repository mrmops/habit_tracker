import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'habit_dto.g.dart';

@JsonSerializable()
class HabitDto {
  @JsonKey(name: 'uid', includeIfNull: false)
  String? id;
  String? title = '';
  int? color = 0;
  String? description;
  @JsonKey(
      name: 'date',
      toJson: tryDateToJson,
      fromJson: tryDateFromJson)
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

  Map<String, dynamic> toJson() {
    var $habitDtoToJson = _$HabitDtoToJson(this);
    return $habitDtoToJson;
  }

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

  static DateTime? tryDateFromJson(int? json) {
    return json != null ? DateTime.fromMillisecondsSinceEpoch(json) : null;
  }

  static int? tryDateToJson(DateTime? dateTime) {
    return dateTime?.millisecondsSinceEpoch;
  }
}
