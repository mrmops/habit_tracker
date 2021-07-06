import 'package:habit_tracker/data/network/dtos/date_time_dto.dart';
import 'package:habit_tracker/data/network/dtos/habit_dto.dart';
import 'package:habit_tracker/data/network/Retrofit/retrofit_client.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/interfaces/habit_network_repository.dart';
import 'package:habit_tracker/infostructure/base_mapper.dart';

class NetworkRepositoryImp extends HabitNetworkRepository {
  RetrofitClient _retrofitClient;
  BaseMapper<HabitModel, HabitDto> _mapper;

  NetworkRepositoryImp(this._retrofitClient, this._mapper);

  @override
  Future<String> addHabit(HabitModel dto) async =>
      (await _retrofitClient.addHabit(_mapper.revertMap(dto))).id!;

  @override
  Future<bool> deleteHabit(String id) async =>
      (await _retrofitClient.deleteHabit(id)).success;

  @override
  Future<bool> doneHabit(String habitId, DateTime dto) async =>
      (await _retrofitClient.doneHabit(habitId, DateTimeDto(dto))).success;

  @override
  Future<List<HabitModel>> getHabits() async {
    var habitsListDto = (await _retrofitClient.getHabits());
    if (habitsListDto.habits == null) return List.empty();

    return _mapper.mapIterable(habitsListDto.habits!).toList();
  }

  @override
  Future<bool> patchHabit(String id, HabitModel habit) async =>
      (await _retrofitClient.patchHabit(id, _mapper.revertMap(habit))).success;

  @override
  Future<String> addOrUpdateHabit(HabitModel dto) async {
    if(dto.serverId != null) {
      await patchHabit(dto.serverId!, dto);
      return dto.serverId!;
    } else {
      return await addHabit(dto);
    }
  }
}
