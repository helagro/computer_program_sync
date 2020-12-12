import 'package:computer_program_sync/programObject.dart';
import 'package:computer_program_sync/widgets/actionbutton.dart';
import 'package:flutter/material.dart';
import '../widgetFactories.dart';

class CommandListItem extends StatefulWidget {
  final List<String> platforms;
  final CommandObject command;
  final Function deleteCallback;

  CommandListItem({Key key, this.platforms, this.command, this.deleteCallback})
      : super(key: key);

  @override
  _CommandListItemState createState() => _CommandListItemState(
      platforms: platforms, command: command, deleteCallback: deleteCallback);
}

class _CommandListItemState extends State<CommandListItem> {
  _CommandListItemState(
      {List<String> platforms, this.command, this.deleteCallback}) {
    platformsWidgets = createPlatformsDropdownMenuItems(platforms);
    selectedItem = platforms.indexOf(command.platform);
  }

  List<DropdownMenuItem> platformsWidgets = [];
  final CommandObject command;
  final Function deleteCallback;
  final TextEditingController textEditingController = TextEditingController();
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    textEditingController.text = command.command;

    return SizedBox(
      child: Row(children: [
        DropdownButton(
          value: selectedItem,
          onChanged: (value) => {
            setState(() {
              selectedItem = value;
            })
          },
          items: platformsWidgets,
        ),
        Expanded(
          child: TextField(controller: textEditingController),
        ),
        ActionButton(
          icon: Icons.delete,
          toolTip: "Delete command",
          onPressed: deleteCallback,
        )
      ]),
      height: 60,
      width: 200,
    );
  }
}
