import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc/habit_details_bloc.dart';

class DescriptionFieldWidget extends StatefulWidget {
  @override
  _DescriptionFieldWidgetState createState() => _DescriptionFieldWidgetState();
}

class _DescriptionFieldWidgetState extends State<DescriptionFieldWidget> {
  String? currentInput;

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HabitDetailsBloc>();
    var textEditingController = TextEditingController(text: bloc.description);

    return TextFormField(
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
        bloc.description = currentInput!;
      },
    );
  }
}