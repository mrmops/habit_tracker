import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Models/HabitType.dart';
import 'package:habit_tracker/Models/Priority.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              initialValue: null,
              maxLength: 40,
              decoration: InputDecoration(
                icon: Icon(Icons.drive_file_rename_outline),
                labelText: 'Имя привычки',
                suffix: IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  onPressed: () {
                    textEditingController.clear();
                  },
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
                  PriorityWidget(),
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

class PriorityWidget extends StatefulWidget {
  @override
  State<PriorityWidget> createState() {
    return PriorityState();
  }
}

class PriorityState extends State<PriorityWidget> {
  var dropdownValue = Priority.LOW;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Приоритетность привычки'),
        DropdownButton<Priority>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 18,
            elevation: 16,
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (Priority? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: Priority.values
                .map<DropdownMenuItem<Priority>>((Priority value) {
              return DropdownMenuItem<Priority>(
                value: value,
                child: Text(value.localizedString ?? ''),
              );
            }).toList()),
      ],
    );
  }
}
