import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/app/extensions/habit_priority_extensions.dart';

class HabitAddOrEditPage extends StatelessWidget {
  static const routingKey = 'HabitAddOrEditPage';
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var textEditingController =
        TextEditingController(text: 'Перестать давать еду собаке');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('AddOrEditHabit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: textEditingController,
                initialValue: null,
                maxLength: 40,
                decoration: InputDecoration(
                  labelText: 'Имя привычки',
                  suffix: SizedBox(
                    height: 24,
                    width: 24,
                    child: IconButton(
                      padding: new EdgeInsets.all(0.0),
                      iconSize: 24,
                      icon: Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                ),
              ),
              TextFormField(
                initialValue:
                    'Перестать давать еду собаке когда она просит, даже если она делает очень красивые глазки, она не голодная!',
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Описание',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF6200EE)),
                  ),
                ),
              ),
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
                child: MaterialButton(
                  color:  Color(0xFF6200EE),
                  child: Text('Сохранить'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HabitTypeRadio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HabitTypeRadioState();
  }
}

class HabitTypeRadioState extends State<HabitTypeRadio> {
  HabitType _typeGroupValue = HabitType.GOOD;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Тип привычки'),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: GestureDetector(
            child: Text('Хорошая'),
            onTap: () {
              setState(() {
                _typeGroupValue = HabitType.GOOD;
              });
            },
          ),
          leading: Radio<HabitType>(
            value: HabitType.GOOD,
            groupValue: _typeGroupValue,
            onChanged: (HabitType? value) {
              setState(() {
                _typeGroupValue = value!;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: GestureDetector(
            child: Text('Плохая'),
            onTap: () {
              setState(() {
                _typeGroupValue = HabitType.BAD;
              });
            },
          ),
          leading: Radio<HabitType>(
            value: HabitType.BAD,
            groupValue: _typeGroupValue,
            onChanged: (HabitType? value) {
              setState(() {
                _typeGroupValue = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}

class HabitPriorityWidget extends StatefulWidget {
  @override
  State<HabitPriorityWidget> createState() {
    return HabitPriorityState();
  }
}

class HabitPriorityState extends State<HabitPriorityWidget> {
  var dropdownValue = HabitPriority.LOW;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Приоритетность привычки'),
        DropdownButton<HabitPriority>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 18,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (HabitPriority? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: HabitPriority.values
                .map<DropdownMenuItem<HabitPriority>>((HabitPriority value) {
              return DropdownMenuItem<HabitPriority>(
                value: value,
                child: Text(value.localizedString),
              );
            }).toList()),
      ],
    );
  }
}


