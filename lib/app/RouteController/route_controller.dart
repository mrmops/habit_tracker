import 'package:flutter/material.dart';
import 'package:habit_tracker/app/ui/HabitsDetails/HabitAddOrEditPage.dart';
import 'package:habit_tracker/app/ui/HabitsList/MainPage.dart';

mixin RouteController {

  static Route<dynamic>? onGenerateRoute(RouteSettings setting){
    switch (setting.name) {
      case MainPage.routeKey:
        return MaterialPageRoute(builder: (_) => MainPage());
      case HabitAddOrEditPage.routingKey:
        return MaterialPageRoute(
            builder: (_) =>
                HabitAddOrEditPage(habitId: setting.arguments as int?));
      default:
        return null;
    }
  }

}