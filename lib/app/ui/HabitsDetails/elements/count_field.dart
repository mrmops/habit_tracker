import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc.dart';

class CountTextField extends StatefulWidget {
  @override
  _CountTextFieldState createState() => _CountTextFieldState();
}

class _CountTextFieldState extends State<CountTextField> {
  int currentCount = 1;

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController(text: '1');

    return BlocListener<HabitDetailsBloc, HabitModelEditState>(
      listenWhen: (oldValue, newValue) => oldValue.count != newValue.count,
      listener: (context, state) {
        textController.text = state.count.toString();
      },
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.number,
        maxLines: null,
        onChanged: (text) {
          context.read<HabitDetailsBloc>().count = int.parse(text);
        },
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
    );
  }
}