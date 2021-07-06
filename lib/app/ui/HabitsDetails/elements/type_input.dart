import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc.dart';
import 'package:habit_tracker/domain/Models/habit.dart';

class HabitTypeRadio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HabitTypeRadioState();
  }
}

class HabitTypeRadioState extends State<HabitTypeRadio> {
  HabitType? currentInput;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitDetailsBloc, HabitModelEditState>(
      buildWhen: (oldValue, newValue) => oldValue.type != newValue.type,
      builder: (context, state) {
        currentInput ??= state.type;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Тип привычки'),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: GestureDetector(
                child: Text('Хорошая'),
                onTap: () => updateState(context, HabitType.GOOD),
              ),
              leading: Radio<HabitType>(
                value: HabitType.GOOD,
                groupValue: currentInput,
                onChanged: (HabitType? value) {
                  setState(() => updateState(context, value!));
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: GestureDetector(
                child: Text('Плохая'),
                onTap: () => updateState(context, HabitType.BAD),
              ),
              leading: Radio<HabitType>(
                value: HabitType.BAD,
                groupValue: currentInput,
                onChanged: (HabitType? value) => updateState(context, value!),
              ),
            ),
          ],
        );
      },
    );
  }

  void updateState(BuildContext context, HabitType value) {
    context.read<HabitDetailsBloc>().type = value;
    setState(() {
      currentInput = value;
    });
  }
}
