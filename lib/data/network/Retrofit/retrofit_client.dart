import 'package:habit_tracker/data/network/dtos/habit_dto.dart';
import 'package:habit_tracker/data/network/dtos/habits_list_dto.dart';
import 'package:habit_tracker/data/network/dtos/success_dto.dart';
import 'package:habit_tracker/data/network/dtos/date_time_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'retrofit_client.g.dart';

@RestApi(baseUrl: 'https://habits-internship.doubletapp.ai/api')
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @GET("/habits")
  Future<HabitsListDto> getHabits();

  @POST("/habits")
  Future<HabitDto> addHabit(@Body() HabitDto dto);

  @DELETE("/habits/{id}")
  Future<SuccessDto> deleteHabit(@Path() String id);

  @PATCH('/habits/{id}')
  Future<SuccessDto> patchHabit(@Path() String id, @Body() HabitDto dto);

  @POST('/habits/{id}/complete')
  Future<SuccessDto> doneHabit(@Body() DateTimeDto dto);
}