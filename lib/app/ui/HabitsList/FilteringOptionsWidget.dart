import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/app/blocs/habits_list_bloc/habits_list_bloc.dart';

class FilteringOptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.all(20),
      child: Row(
        verticalDirection: VerticalDirection.down,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Фильтрация',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Сортировка по дате'),
                    ChangeSortDirectionButton()
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Фильтрация по названию'),
                    Expanded(
                      child: Container(
                        child: FilterInput(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterInput extends StatefulWidget {
  @override
  _FilterInputState createState() => _FilterInputState();
}

class _FilterInputState extends State<FilterInput> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HabitsListBloc>(context, listen: false);
    return TextField(
      controller: TextEditingController(text: bloc.currentFilter),
      onChanged: (text) => bloc.changeFilter(text),
      decoration:
          InputDecoration(border: OutlineInputBorder(), hintText: 'Фильтр'),
    );
  }
}

class ChangeSortDirectionButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CortButtonState();
  }
}

class CortButtonState extends State<ChangeSortDirectionButton> {
  bool revertSortDirection = false;

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<HabitsListBloc>(context, listen: false);
    return IconButton(
      icon: revertSortDirection
          ? const Icon(Icons.arrow_upward_outlined)
          : const Icon(Icons.arrow_downward_outlined),
      onPressed: () {
        bloc.changeSort(revertSortDirection);
        setState(() {
          revertSortDirection = !revertSortDirection;
        });
      },
    );
  }
}
