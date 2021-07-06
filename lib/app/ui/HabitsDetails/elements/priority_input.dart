import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habit_details_bloc.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:habit_tracker/app/extensions/habit_priority_extensions.dart';

class HabitPriorityWidget extends StatefulWidget {
  @override
  State<HabitPriorityWidget> createState() {
    return HabitPriorityState();
  }
}

class HabitPriorityState extends State<HabitPriorityWidget> {
  HabitPriority? currentValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitDetailsBloc, HabitModelEditState>(
      buildWhen: (oldValue, newValue) => oldValue.priority != newValue.priority,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Приоритетность привычки'),
            DropdownButton<HabitPriority>(
                value: currentValue ?? state.priority,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 18,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (HabitPriority? newValue) {
                  setState(() {
                    currentValue = newValue;
                    context.read<HabitDetailsBloc>().priority =
                        currentValue ?? HabitPriority.NORMAL;
                  });
                },
                items: HabitPriority.values
                    .map<DropdownMenuItem<HabitPriority>>(
                        (HabitPriority value) {
                  return DropdownMenuItem<HabitPriority>(
                    value: value,
                    child: Text(value.localizedString),
                  );
                }).toList()),
          ],
        );
      },
    );
  }
}
