import 'package:json_annotation/json_annotation.dart';

part 'success_dto.g.dart';

@JsonSerializable()
class SuccessDto{
  bool success;

  SuccessDto(this.success);

  factory SuccessDto.fromJson(Map<String, dynamic> json) =>
      _$SuccessDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessDtoToJson(this);
}