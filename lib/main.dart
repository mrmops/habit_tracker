import 'package:flutter/material.dart';

import 'app/UI/HabitsDetails/HabitAddOrEditPage.dart';
import 'app/UI/HabitsList/MainPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      routes: {
        MainPage.routeKey : (buildContext) => MainPage(),
        HabitAddOrEditPage.routingKey : (buildContext) => HabitAddOrEditPage(),
      },
    );
  }
}
