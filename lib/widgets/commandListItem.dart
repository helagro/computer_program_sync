import 'package:computer_program_sync/programObject.dart';
import 'package:computer_program_sync/widgets/actionbutton.dart';
import 'package:flutter/material.dart';
import '../widgetFactories.dart';

class CommandListItem extends StatefulWidget {
  final List<String> platforms;
  final CommandObject command;
  final Function deleteCallback;

  CommandListItem(
      {Key key, this.platforms, this.command, this.deleteCallback}) {
    print("commandList init statefull" + command.toString());
  }

  @override
  _CommandListItemState createState() {
    return _CommandListItemState();
  }
}

class _CommandListItemState extends State<CommandListItem> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CommandObject command = widget.command;
    List<DropdownMenuItem> platformsWidgets =
        createPlatformsDropdownMenuItems(widget.platforms);

    textEditingController.text = command.command;
    textEditingController.addListener(() {
      command.command = textEditingController.text;
    });

    return SizedBox(
      child: Row(children: [
        DropdownButton(
          value: widget.platforms.indexOf(command.platform),
          onChanged: (value) => {
            setState(() {
              command.platform = widget.platforms[value];
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
          onPressed: widget.deleteCallback,
        )
      ]),
      height: 60,
      width: 200,
    );
  }
}
