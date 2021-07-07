import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc.dart';

class FrequencyTextField extends StatefulWidget {
  @override
  _FrequencyTextFieldState createState() => _FrequencyTextFieldState();
}

class _FrequencyTextFieldState extends State<FrequencyTextField> {
  int currentFrequency = 1;

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController(text: '1');

    return BlocListener<HabitDetailsBloc, HabitModelEditState>(
      listenWhen: (oldValue, newValue) =>
          oldValue.frequency != newValue.frequency,
      listener: (context, state) {
        textController.text = state.frequency.toString();
      },
      child: TextFormField(
        controller: textController,
        keyboardType: TextInputType.number,
        maxLines: null,
        onChanged: (text) {
          context.read<HabitDetailsBloc>().frequency = int.parse(text);
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
      ),
    );
  }
}
