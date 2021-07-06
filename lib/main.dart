import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/ui/HabitsDetails/HabitAddOrEditPage.dart';
import 'package:habit_tracker/app/ui/HabitsList/MainPage.dart';
import 'package:habit_tracker/data/database/Imp/habit_database_imp.dart';
import 'package:habit_tracker/data/database/habit_database_interface.dart';
import 'package:habit_tracker/data/database/mappers/habit_database_mapper.dart';
import 'package:habit_tracker/data/database/repository_wrapper/habit_database_wrapper_imp.dart';
import 'package:habit_tracker/data/network/Retrofit/retrofit_client.dart';
import 'package:habit_tracker/data/network/configuration/retrofit_configaretion_helper.dart';
import 'package:habit_tracker/data/network/dtos/habit_dto.dart';
import 'package:habit_tracker/data/network/dtos/mappers/habit_dto_mapper.dart';
import 'package:habit_tracker/data/network/network_repository_imp.dart';
import 'package:habit_tracker/domain/Imp/habit_service_imp.dart';
import 'package:habit_tracker/domain/habit_service.dart';
import 'package:habit_tracker/domain/interfaces/habit_database_repository.dart';
import 'package:habit_tracker/domain/interfaces/habit_network_repository.dart';

import 'domain/Models/habit.dart';
import 'infostructure/base_mapper.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BaseMapper<HabitModel, Habit>>(
            create: (context) => HabitDatabaseMapper()),
        RepositoryProvider<HabitDataBase>(
            create: (context) => HabitDataBaseImp()),
        RepositoryProvider<HabitDatabaseRepository>(
            create: (context) =>
                HabitDatabaseWrapperImp(context.read(), context.read())),
        RepositoryProvider<RetrofitClient>(
            create: (context) => RetrofitConfigurationHelper.retrofitInstance),
        RepositoryProvider<BaseMapper<HabitModel, HabitDto>>(
            create: (context) => HabitDtoMapper()),
        RepositoryProvider<HabitNetworkRepository>(
            create: (context) =>
                NetworkRepositoryImp(context.read(), context.read())),
        RepositoryProvider<HabitService>(
            create: (context) => HabitServiceImp(
                  context.read<HabitDatabaseRepository>(),
                  context.read<HabitNetworkRepository>(),
                )),
      ],
      child: MaterialApp(
        title: 'Habit Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
        onGenerateRoute: (setting) {
          switch (setting.name) {
            case MainPage.routeKey:
              return MaterialPageRoute(builder: (_) => MainPage());
            case HabitAddOrEditPage.routingKey:
              return MaterialPageRoute(
                  builder: (_) =>
                      HabitAddOrEditPage(habitId: setting.arguments as int?));
            default:
              return MaterialPageRoute(
                  builder: (_) => Text('Неизвестная траница'));
          }
        },
      ),
    );
  }
}
