import 'package:computer_program_sync/programObject.dart';
import 'package:computer_program_sync/widgets/actionbutton.dart';
import 'package:computer_program_sync/widgets/commandListItem.dart';

import 'package:flutter/material.dart';

class ProgramEditDialog extends StatelessWidget {
  final ProgramObject program;
  final Function deleteCallback;
  final Function editCallback;
  final List<String> platforms;
  final TextEditingController nameEditingController = TextEditingController();

  ProgramEditDialog(
      {Key key,
      @required this.program,
      this.editCallback,
      this.deleteCallback,
      @required this.platforms})
      : super(key: key);

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
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: program.commands.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext buildContext, int index) {
                    return CommandListItem(
                        platforms: platforms, command: program.commands[index]);
                  }),
              height: 400,
              width: 400,
            )
          ],
        )
      ],
    );
  }

  void onSaveBtn(BuildContext context) {
    program.name = nameEditingController.text;
    print(program.name);
    Navigator.pop(context);
    editCallback();
  }
}
