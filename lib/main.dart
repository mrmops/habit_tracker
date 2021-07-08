import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habit_tracker/app/RouteController/route_controller.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'domain/Models/habit.dart';
import 'infostructure/base_mapper.dart';

void main() {
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
            create: (context) => HabitDataBaseImplementation()),
        RepositoryProvider<HabitDatabaseRepository>(
            create: (context) =>
                HabitDatabaseWrapperImplementation(context.read(), context.read())),
        RepositoryProvider<RetrofitClient>(
            create: (context) => RetrofitConfigurationHelper.retrofitInstance),
        RepositoryProvider<BaseMapper<HabitModel, HabitDto>>(
            create: (context) => HabitDtoMapper()),
        RepositoryProvider<HabitNetworkRepository>(
            create: (context) =>
                NetworkRepositoryImplementation(context.read(), context.read())),
        RepositoryProvider<HabitService>(
            create: (context) => HabitServiceImplementation(
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
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ru', ''),
        ],
        onGenerateRoute: RouteController.onGenerateRoute,
      ),
    );
  }
}
