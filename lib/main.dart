import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    );
  }
}

class MainPage extends StatefulWidget {
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
    return Scaffold(
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
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return HabitItem();
        },
        itemCount: 200,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'Добавить привычку!',
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
            return new Container(
              height: 200.0,
              color: Colors.teal[100],
              child: Center(
                child: FilterFragment(),
              ),
            );
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

class HabitItem extends StatefulWidget {
  @override
  State<HabitItem> createState() => HabitItemState();
}

class HabitItemState extends State<HabitItem> {
  bool _hiddenState = true;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 64,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Name',
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              '30.02.2077 +5',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text('Priority'),
                    ),
                    Container(
                      child: IconButton(
                        icon: _hiddenState
                            ? const Icon(Icons.arrow_drop_down_sharp)
                            : const Icon(Icons.arrow_drop_up_sharp),
                        onPressed: () {
                          setState(() {
                            _hiddenState = !_hiddenState;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!_hiddenState) buildHiddenProperties(),
          ],
        ),
      ),
    );
  }

  Widget buildHiddenProperties() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text('Number of completed'), Text('still need')],
        ),
        Text('Description')
      ],
    );
  }
}

class FilterFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
        child: Text(
          'Фильтрация',
          style: TextStyle(fontSize: 18, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
