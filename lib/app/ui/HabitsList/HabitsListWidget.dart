import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habits_list_bloc.dart';
import 'package:habit_tracker/app/extensions/habit_priority_extensions.dart';
import 'package:habit_tracker/app/ui/HabitsDetails/HabitAddOrEditPage.dart';
import 'package:habit_tracker/domain/Models/habit.dart';

class HabitsTypedListWidget extends StatefulWidget {
  final HabitType _habitType;

  HabitsTypedListWidget(this._habitType);

  @override
  _HabitsTypedListWidgetState createState() => _HabitsTypedListWidgetState();
}

class _HabitsTypedListWidgetState extends State<HabitsTypedListWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsListBloc, List<HabitModel>>(
        builder: (context, state) {
      var habits = state
          .where((element) => element.type == widget._habitType)
          .map((e) => HabitItemStateInfo(e, true))
          .toList();

      return ListView.builder(
        itemBuilder: (context, position) {
          return HabitItem(habits[position]);
        },
        itemCount: habits.length,
      );
    });
  }
}

class HabitItemStateInfo {
  HabitModel habitModel;
  bool hidden;

  HabitItemStateInfo(this.habitModel, this.hidden);
}

class HabitItem extends StatefulWidget {
  final HabitItemStateInfo info;

  HabitItem(this.info);

  @override
  State<HabitItem> createState() => HabitItemState();
}

class HabitItemState extends State<HabitItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, HabitAddOrEditPage.routingKey,
          arguments: widget.info.habitModel.id),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text(widget.info.habitModel.name),
              subtitle:
                  Text(widget.info.habitModel.dateOfUpdate.toIso8601String()),
              trailing: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  MaterialButton(
                    color: Color(0xFF6200EE),
                    child: Text('Сохранить'),
                    onPressed: () async {
                      await context
                        .read<HabitsListBloc>()
                        .doneHabit(widget.info.habitModel);

                    },
                  ),
                  IconButton(
                    icon: widget.info.hidden
                        ? const Icon(Icons.arrow_drop_down_sharp)
                        : const Icon(Icons.arrow_drop_up_sharp),
                    onPressed: () {
                      setState(() {
                        widget.info.hidden = !widget.info.hidden;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (!widget.info.hidden) buildHiddenProperties(),
          ],
        ),
      ),
    );
  }

  Widget buildHiddenProperties() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Number of completed: ${widget.info.habitModel.count}'),
              Text('Frequency: ${widget.info.habitModel.frequency}'),
              Text(widget.info.habitModel.priority.localizedString),
            ],
          ),
          Text(widget.info.habitModel.description ?? ''),
        ],
      ),
    );
  }
}
