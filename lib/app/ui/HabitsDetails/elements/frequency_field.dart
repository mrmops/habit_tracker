import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc/habit_details_bloc.dart';

class FrequencyTextField extends StatefulWidget {
  @override
  _FrequencyTextFieldState createState() => _FrequencyTextFieldState();
}

class _FrequencyTextFieldState extends State<FrequencyTextField> {
  int currentFrequency = 1;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HabitDetailsBloc>();
    var textController = TextEditingController(text: bloc.frequency.toString());

    return TextFormField(
      controller: textController,
      keyboardType: TextInputType.number,
      maxLines: null,
      onChanged: (text) {
        bloc.frequency = int.parse(text);
      },
      decoration: InputDecoration(
        labelText: 'Периодичность',
        helperText:
            'Количество дней, за которые необходимо сделать указанное количество повторений',
        helperMaxLines: 2,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF6200EE)),
        ),
      ),
    );
  }
}
