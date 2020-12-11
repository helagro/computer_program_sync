import 'package:computer_program_sync/programObject.dart';
import 'package:flutter/material.dart';
import '../widgetFactories.dart';

class CommandListItem extends StatefulWidget {
  final List<String> platforms;
  final CommandObject command;

  CommandListItem({Key key, this.platforms, this.command}) : super(key: key);

  @override
  _CommandListItemState createState() =>
      _CommandListItemState(platforms: platforms, command: command);
}

class _CommandListItemState extends State<CommandListItem> {
  _CommandListItemState({List<String> platforms, this.command}) {
    platformsWidgets = createPlatformsDropdownMenuItems(platforms);
  }

  List<DropdownMenuItem> platformsWidgets = [];
  final CommandObject command;
  final TextEditingController textEditingController = TextEditingController();
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    textEditingController.text = command.command;

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
