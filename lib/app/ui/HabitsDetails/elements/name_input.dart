import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc/habit_details_bloc.dart';

class NameInputFieldWidget extends StatefulWidget {
  @override
  _NameInputFieldWidgetState createState() => _NameInputFieldWidgetState();
}

class _NameInputFieldWidgetState extends State<NameInputFieldWidget> {
  String? currentInput;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HabitDetailsBloc>();
    var textEditingController = TextEditingController(text: bloc.name);

    return TextFormField(
      controller: textEditingController,
      initialValue: null,
      onChanged: (text) {
        currentInput = text;
        bloc.name = currentInput!;
      },
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
              currentInput = null;
              bloc.name = '';
              textEditingController.clear();
            },
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
        ),
      ),
    );
  }
}
