import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc.dart';

class DescriptionFieldWidget extends StatefulWidget {
  @override
  _DescriptionFieldWidgetState createState() => _DescriptionFieldWidgetState();
}

class _DescriptionFieldWidgetState extends State<DescriptionFieldWidget> {
  String? currentInput;

  @override
  Widget build(BuildContext context) {
    var textEditingController = TextEditingController(text: currentInput);
    return BlocListener<HabitDetailsBloc, HabitModelEditState>(
      listenWhen: (oldValue, newValue) =>
      oldValue.description != newValue.description,
      listener: (context, state) => textEditingController.text = state.description ?? currentInput ?? '',
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          labelText: 'Описание',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF6200EE)),
          ),
        ),
        onChanged: (text) {
          currentInput = text;
          context
              .read<HabitDetailsBloc>()
              .description = currentInput!;
        },
      ),
    );
  }
}