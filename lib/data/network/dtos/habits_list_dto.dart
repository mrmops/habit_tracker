import 'package:json_annotation/json_annotation.dart';

import 'habit_dto.dart';

part 'habits_list_dto.g.dart';

@JsonSerializable()
class HabitsListDto{
  int count;
  List<HabitDto>? habits;

  HabitsListDto(this.count, this.habits);

  factory HabitsListDto.fromJson(Map<String, dynamic> json) =>
      _$HabitsListDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HabitsListDtoToJson(this);
}