import 'package:computer_program_sync/programObject.dart';
import 'package:computer_program_sync/widgets/actionbutton.dart';
import 'package:computer_program_sync/widgets/commandListItem.dart';

import 'package:flutter/material.dart';

class ProgramEditDialog extends StatefulWidget {
  final List<String> platforms;
  final ProgramObject program;
  final Function deleteCallback;
  final Function editCallback;

  ProgramEditDialog(
      {Key key,
      @required this.program,
      this.editCallback,
      this.deleteCallback,
      @required this.platforms})
      : super(key: key);

  @override
  _ProgramEditDialogState createState() => _ProgramEditDialogState(
        program: program,
        platforms: platforms,
        editCallback: editCallback,
      );
}

class _ProgramEditDialogState extends State<ProgramEditDialog> {
  final ProgramObject program;
  final Function deleteCallback;
  final Function editCallback;
  final List<String> platforms;
  final TextEditingController nameEditingController = TextEditingController();

  _ProgramEditDialogState(
      {@required this.program,
      this.editCallback,
      this.deleteCallback,
      @required this.platforms});

  @override
  Widget build(BuildContext context) {
    nameEditingController.text = program.name;

    return AlertDialog(
      title: Center(child: Text("Edit program")),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  child: TextField(controller: nameEditingController),
                  height: 60,
                  width: 400,
                ),
                ActionButton(
                    icon: Icons.save,
                    toolTip: "Save",
                    onPressed: () => onSaveBtn(context))
              ],
            ),
            SizedBox(
              child: Column(children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: program.commands.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext buildContext, int index) {
                      return CommandListItem(
                        platforms: platforms,
                        command: program.commands[index],
                        deleteCallback: () => deleteCommand(index),
                      );
                    }),
                ActionButton(
                  icon: Icons.add,
                  toolTip: "Add command",
                  onPressed: addCommand,
                )
              ]),
              height: 400,
              width: 400,
            )
          ],
        )
      ],
    );
  }

  void addCommand() {
    setState(() {
      program.commands.add(CommandObject(platforms[0], ""));
    });
  }

  void deleteCommand(index) {
    print(program.commands[index].platform);
    setState(() {
      program.commands.removeAt(index);
    });
  }

  void onSaveBtn(BuildContext context) {
    program.name = nameEditingController.text;
    Navigator.pop(context);
    editCallback();
  }
}
