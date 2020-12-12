import 'package:computer_program_sync/non-graphics/programObject.dart';
import 'package:flutter/material.dart';

import 'programEditDialog.dart';

class ProgramListItem extends StatelessWidget {
  final ProgramObject program;
  final List<String> allAddedPlatforms;
  final Function editCallback;

  const ProgramListItem(
      {Key key,
      @required this.program,
      @required this.allAddedPlatforms,
      this.editCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext buildContext) => ProgramEditDialog(
                  program: program,
                  platforms: allAddedPlatforms,
                  editCallback: editCallback,
                ));
      },
      child: Text(program.name),
      padding: const EdgeInsets.all(20),
    );
  }
}
