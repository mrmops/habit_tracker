import 'package:flutter/material.dart';

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
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter a search term'),
                      ),
                    )),
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

class ChangeSortDirectionButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CortButtonState();
  }
}

class CortButtonState extends State<ChangeSortDirectionButton> {
  bool invertSortDirection = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: invertSortDirection
          ? const Icon(Icons.arrow_upward_outlined)
          : const Icon(Icons.arrow_downward_outlined),
      onPressed: () {
        setState(() {
          invertSortDirection = !invertSortDirection;
        });
      },
    );
  }
}
