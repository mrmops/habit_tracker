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

  HabitServiceImp(this._databaseRepository, this._networkRepository);

  @override
  Future addLocalHabitsToServer() async {
    var date = await findLastUpdateDate();
    var localHabits = await _databaseRepository.getHabitsUpdatedAfter(date);

    for (var habit in localHabits) {
      var serverId = habit.serverId;
      if (serverId != null)
        await _networkRepository.patchHabit(serverId, habit);
      else {
        var serverId = await _networkRepository.addHabit(habit);
        habit.serverId = serverId;
        await _databaseRepository.addOrUpdateHabitModel(habit);
      }
    }

    var sharedPreferences = (await SharedPreferences.getInstance());
    sharedPreferences.setString(
        lastDateOfUpdateKey, DateTime.now().toIso8601String());
  }

  @override
  Future<bool> doneHabit(String habitServerId) async {
    var localHabit = await requiredHabitById(habitServerId);

    var dateTime = DateTime.now();
    localHabit.doneDates.add(dateTime);
    await _databaseRepository.addOrUpdateHabitModel(localHabit);
    return await _networkRepository.doneHabit(dateTime);
  }

  @override
  Stream<List<HabitModel>> getHabits(String? filter, bool revertSort) {
    return _databaseRepository.watchHabitModelsOrderByDate(revertSort).map(
        (event) => filter == null
            ? event
            : event.where((element) => element.name.contains(filter)).toList());
  }

  @override
  Future<int> remainingReps(String habitServerId) async {
    var habit = await requiredHabitById(habitServerId);

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
      var serverId = await _networkRepository.addHabit(habit);
      habit.serverId = serverId;
      await _databaseRepository.addOrUpdateHabitModel(habit);
      return true;
    } catch (e) {
      habit.dateOfUpdate = DateTime.now();
    } finally {
      await _databaseRepository.addOrUpdateHabitModel(habit);
    }
    return false;
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
}
