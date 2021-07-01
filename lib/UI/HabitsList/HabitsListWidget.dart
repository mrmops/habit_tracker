import 'package:flutter/material.dart';

class HabitsListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return HabitItem();
      },
      itemCount: 20,
    );
  }
}

class HabitItem extends StatefulWidget {
  @override
  State<HabitItem> createState() => HabitItemState();
}

class HabitItemState extends State<HabitItem> {
  bool _hiddenState = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Name'),
            subtitle: Text('30.02.2077 +5'),
            trailing: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('Normal'),
                IconButton(
                  icon: _hiddenState
                      ? const Icon(Icons.arrow_drop_down_sharp)
                      : const Icon(Icons.arrow_drop_up_sharp),
                  onPressed: () {
                    setState(() {
                      _hiddenState = !_hiddenState;
                    });
                  },
                ),
              ],
            ),
          ),
          if (!_hiddenState) buildHiddenProperties(),
        ],
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
            children: [Text('Number of completed'), Text('still need')],
          ),
          Text('Description')
        ],
      ),
    );
  }

  //TODO delete old version
  // @override
  // Widget build(BuildContext context) {
  //   return IntrinsicHeight(
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 16),
  //       child: Column(
  //         children: [
  //           Container(
  //             height: 64,
  //             child: Padding(
  //               padding: EdgeInsets.symmetric(vertical: 8),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: <Widget>[
  //                         Text(
  //                           'Name',
  //                           style: TextStyle(fontSize: 18),
  //                         ),
  //                         Text(
  //                           '30.02.2077 +5',
  //                           style: TextStyle(fontSize: 14),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Text('Normal'),
  //                   IconButton(
  //                     icon: _hiddenState
  //                         ? const Icon(Icons.arrow_drop_down_sharp)
  //                         : const Icon(Icons.arrow_drop_up_sharp),
  //                     onPressed: () {
  //                       setState(() {
  //                         _hiddenState = !_hiddenState;
  //                       });
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           if (!_hiddenState) buildHiddenProperties(),
  //         ],
  //       ),
  //     ),
  //   );
  //}
  //
  // Widget buildHiddenProperties() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [Text('Number of completed'), Text('still need')],
  //       ),
  //       Text('Description')
  //     ],
  //   );
  // }
}
