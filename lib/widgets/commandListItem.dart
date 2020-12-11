import 'package:flutter/material.dart';

class CommandListItem extends StatelessWidget {
  CommandListItem({Key key}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textEditingController.text = "dawi";

    return Row(children: [
      DropdownButton(
        onChanged: (value) => {},
      ),
      SizedBox(
        child: TextField(controller: textEditingController),
        height: 60,
        width: 140,
      )
    ]);
  }
}
