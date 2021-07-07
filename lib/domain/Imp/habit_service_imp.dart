import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/domain/habit_service.dart';
import 'package:habit_tracker/domain/interfaces/habit_database_repository.dart';
import 'package:habit_tracker/domain/interfaces/habit_network_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitServiceImp extends HabitService {
  static const String lastDateOfUpdateKey = 'lastDateOfUpdateKey@example.com';
  static const int dayMilis = 24 * 60 * 60 * 1000;

  HabitDatabaseRepository _databaseRepository;
  HabitNetworkRepository _networkRepository;

  HabitServiceImp(this._databaseRepository, this._networkRepository) {
    trySyncWithServer();
  }

  Future trySyncWithServer() async {
    await updateHabitsFromServer();
    await addLocalHabitsToServer();
  }

  @override
  Future<void> updateHabitsFromServer() async {
    var date = await findLastUpdateDate();

    var habits = await _networkRepository.getHabits();
    var millisecondsSinceEpoch2 = date.millisecondsSinceEpoch;
    for (var habit in habits.where((element) =>
        element.dateOfUpdate.millisecondsSinceEpoch >
        millisecondsSinceEpoch2)) {
      await _databaseRepository.addOrUpdateHabitModel(habit);
    }
  }

  @override
  Future addLocalHabitsToServer() async {
    var date = await findLastUpdateDate();
    var localHabits = await _databaseRepository.getHabitsUpdatedAfter(date);

    for (var habit in localHabits) {
      await saveHabit(habit);
    }

    var sharedPreferences = (await SharedPreferences.getInstance());
    sharedPreferences.setString(
        lastDateOfUpdateKey, DateTime.now().toIso8601String());
  }

  @override
  Future<bool> doneHabit(HabitModel localHabit) async {
    var dateTime = DateTime.now();
    localHabit.doneDates.add(dateTime);

    try {
      if (localHabit.serverId == null) {
        var id = await _networkRepository.addHabit(localHabit);
        localHabit.serverId = id;
        return true;
      }
      return await _networkRepository.doneHabit(localHabit.serverId!, dateTime);
    } catch (e) {
      return false;
    } finally {
      await _databaseRepository.addOrUpdateHabitModel(localHabit);
    }
  }

  @override
  Stream<List<HabitModel>> getHabits(String? filter, bool revertSort) {
    return _databaseRepository.watchHabitModelsOrderByDate(revertSort).map(
        (event) => filter == null
            ? event
            : event
                .where((element) =>
                    element.name.toLowerCase().contains(filter.toLowerCase()))
                .toList());
  }

  @override
  Future<int> repsLeft(HabitModel habit) async {
    var allowableTimeDifference = dayMilis * habit.frequency;
    var currentDateMilis = DateTime.now().millisecondsSinceEpoch;
    return habit.count -
        habit.doneDates
            .where((element) =>
                (currentDateMilis - element.millisecondsSinceEpoch) <
                allowableTimeDifference)
            .length;
  }

  @override
  Future<bool> saveHabit(HabitModel habit) async {
    try {
      habit.dateOfUpdate = DateTime.now();
      var serverId = await _networkRepository.addOrUpdateHabit(habit);
      habit.serverId = serverId;
      return true;
    } catch (e) {
      habit.dateOfUpdate = DateTime.now();
    } finally {
      await _databaseRepository.addOrUpdateHabitModel(habit);
    }
    return false;
  }

  Future<DateTime> findLastUpdateDate() async {
    var sharedPreferences = (await SharedPreferences.getInstance());
    var dateOfUpdate = sharedPreferences.getString(lastDateOfUpdateKey);
    return dateOfUpdate == null ? DateTime(1970) : DateTime.parse(dateOfUpdate);
  }

  Future<HabitModel> requiredHabitById(String habitServerId) async {
    var localHabit =
        await _databaseRepository.getHabitModelByServerId(habitServerId);
    return localHabit == null
        ? throw new ArgumentError(
            'Привычка с таким serverId $habitServerId не найдена локально!')
        : localHabit;
  }

  @override
  Future<HabitModel?> getHabitModelById(int id) {
    return _databaseRepository.getHabitModelById(id);
  }

  @override
  Future<HabitModel?> getHabitModelByServerId(String id) {
    return _databaseRepository.getHabitModelByServerId(id);
  }

  @override
  Stream<HabitModel> watchHabitModelById(int id) {
    return _databaseRepository.watchHabitModelById(id);
  }

  @override
  Stream<HabitModel> watchHabitModelByServerId(String id) {
    return _databaseRepository.watchHabitModelByServerId(id);
  }
}
