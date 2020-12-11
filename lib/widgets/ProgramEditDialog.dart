import 'package:computer_program_sync/programObject.dart';
import 'package:computer_program_sync/widgets/commandListItem.dart';

import 'package:flutter/material.dart';

class ProgramEditDialog extends StatelessWidget {
  final ProgramObject program;
  final Function deleteCallback;
  final Function editCallback;
  final List<String> platforms;

  ProgramEditDialog(
      {Key key,
      @required this.program,
      this.editCallback,
      this.deleteCallback,
      @required this.platforms})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit program"),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: TextField(),
              height: 60,
              width: 400,
            ),
            SizedBox(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
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
}
