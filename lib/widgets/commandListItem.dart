import 'package:flutter/material.dart';
import '../widgetFactories.dart';

class CommandListItem extends StatefulWidget {
  final List<String> platforms;

  CommandListItem({Key key, this.platforms}) : super(key: key);

  @override
  _CommandListItemState createState() =>
      _CommandListItemState(platforms: platforms);
}

class _CommandListItemState extends State<CommandListItem> {
  _CommandListItemState({List<String> platforms}) {
    platformsWidgets = createPlatformsDropdownMenuItems(platforms);
  }

  List<DropdownMenuItem> platformsWidgets = [];
  final TextEditingController textEditingController = TextEditingController();
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    textEditingController.text = "dawi";

    return Row(children: [
      DropdownButton(
        value: selectedItem,
        onChanged: (value) => {
          setState(() {
            selectedItem = value;
          })
        },
        items: List<DropdownMenuItem>.from(platformsWidgets),
      ),
      SizedBox(
        child: TextField(controller: textEditingController),
        height: 60,
        width: 140,
      )
    ]);
  }
}
