import 'package:flutter/material.dart';
import 'package:habit_tracker/app/UI/HabitsDetails/HabitAddOrEditPage.dart';
import 'FilteringOptionsWidget.dart';
import 'HabitsListWidget.dart';

class MainPage extends StatefulWidget {
  static const String routeKey = 'MainPageKey';

  @override
  State<MainPage> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersistantBottomSheetCallBack = showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitsListBloc>(
      create: (context) => HabitsListBloc(context.read()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Habits'),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_alt_outlined),
                tooltip: 'Открыть фильтры!',
                onPressed: _showPersistantBottomSheetCallBack,
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: 'Плохие привычки'),
                Tab(text: 'Хорошие привычки'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BlocBuilder<HabitsListBloc, List<HabitModel>>(
                  builder: (context, state) =>
                      HabitsListWidget(context.read<HabitsListBloc>())),
              BlocBuilder<HabitsListBloc, List<HabitModel>>(
                  builder: (context, state) =>
                      HabitsListWidget(context.read<HabitsListBloc>())),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, HabitAddOrEditPage.routingKey),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            tooltip: 'Добавить привычку!',
          ),
        ),
      ),
    );
  }

  void showBottomSheet() {
    setState(() {
      _showPersistantBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        ?.showBottomSheet(
          (context) {
            return FilteringOptionsWidget();
          },
        )
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersistantBottomSheetCallBack = showBottomSheet;
            });
          }
        });
  }
}
