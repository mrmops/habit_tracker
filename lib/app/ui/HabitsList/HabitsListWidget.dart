import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habit_tracker/app/blocs/habits_list_bloc.dart';
import 'package:habit_tracker/app/extensions/habit_priority_extensions.dart';
import 'package:habit_tracker/app/ui/HabitsDetails/HabitAddOrEditPage.dart';
import 'package:habit_tracker/domain/Models/habit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

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
  static DateFormat _dateFormat = DateFormat('HH:mm dd-MM-yyyy', 'ru');

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
                  Text(_dateFormat.format(widget.info.habitModel.dateOfUpdate)),
              trailing: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  MaterialButton(
                    color: Color(0xFF6200EE),
                    child: Text('Выполнить!'),
                    onPressed: () => doneHabit(context),
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

  doneHabit(BuildContext context) async {
    var habitService = context.read<HabitsListBloc>();
    await habitService.doneHabit(widget.info.habitModel);
    var repsLeft = await habitService.repsLeft(widget.info.habitModel);
    String msg = '';
    var localizations = AppLocalizations.of(context)!;
    if (widget.info.habitModel.type == HabitType.GOOD) {
      if (repsLeft > 0) {
        msg = localizations.goodRepsLeft(repsLeft);
      } else {
        msg = localizations.stopDoingItGood;
      }
    } else {
      if (repsLeft > 0) {
        msg = localizations.badRepsLeft(repsLeft);
      } else {
        msg = localizations.stopDoingItBad;
      }
    }
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3);
  }
}
