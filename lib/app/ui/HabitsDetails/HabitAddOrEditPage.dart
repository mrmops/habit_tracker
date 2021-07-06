import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc.dart';
import 'package:habit_tracker/app/ui/HabitsDetails/elements/description_input.dart';
import 'elements/name_input.dart';
import 'elements/priority_input.dart';
import 'elements/type_input.dart';

class HabitAddOrEditPage extends StatefulWidget {
  final int? habitId;

  HabitAddOrEditPage({this.habitId});

  static const routingKey = 'HabitAddOrEditPage';

  @override
  _HabitAddOrEditPageState createState() => _HabitAddOrEditPageState(habitId);
}

class _HabitAddOrEditPageState extends State<HabitAddOrEditPage> {
  int? habitId;

  _HabitAddOrEditPageState(this.habitId);

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HabitDetailsBloc>(
      create: (context) => HabitDetailsBloc(context.read(), habitId: habitId),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('AddOrEditHabit'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                NameInputFieldWidget(),
                DescriptionFieldWidget(),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: HabitTypeRadio()),
                      HabitPriorityWidget(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Количество повторений',
                          helperText:
                              'Количество повторений, которое необходимо выполниться за указанный период',
                          helperMaxLines: 2,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6200EE)),
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Периодичность',
                          helperText:
                              'Количество дней, за которые необходимо сделать указанное количество повторений',
                          helperMaxLines: 2,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6200EE)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: SubmitButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Color(0xFF6200EE),
      child: Text('Сохранить'),
      onPressed: () {
        if(context.read<HabitDetailsBloc>().submit())
          Navigator.pop(context);
      },
    );
  }
}
