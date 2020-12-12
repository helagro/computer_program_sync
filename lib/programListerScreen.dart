import 'package:computer_program_sync/main.dart';
import 'package:computer_program_sync/programObject.dart';
import 'package:computer_program_sync/widgets/ProgramEditDialog.dart';
import 'package:computer_program_sync/widgets/actionbutton.dart';
import 'package:computer_program_sync/widgets/tagWidget.dart';
import 'package:computer_program_sync/widgets/textInputDialog.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/chat/v1.dart';
import 'dart:io';
import 'package:computer_program_sync/widgetFactories.dart' as mFactory;

class ProgramListerScreen extends StatefulWidget {
  ProgramListerScreen({Key key}) : super(key: key);

  @override
  _ProgramListerScreenState createState() => _ProgramListerScreenState();
}

class _ProgramListerScreenState extends State<ProgramListerScreen> {
  final List<String> allAddedPlatforms = <String>["Windows", "MacOS", "Linux"];
  final List<String> visiblePlatforms = <String>[];
  final List<ProgramObject> programs = <ProgramObject>[];

  _ProgramListerScreenState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Added programs"),
        actions: <Widget>[
          ActionButton(icon: Icons.replay, toolTip: "Reload"),
          ActionButton(icon: Icons.save, toolTip: "Save"),
          ActionButton(
            icon: Icons.play_arrow,
            toolTip: "Run",
            onPressed: () => runCommands(programs, visiblePlatforms),
          ),
        ],
      ),
      body: Column(children: [
        //ANCHOR filter
        SizedBox(
          child: Row(
            children: [
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: visiblePlatforms.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext buildContext, int index) {
                        return TagWidget(
                            text: visiblePlatforms[index],
                            index: index,
                            removeBtnCallback: _removePlatformFromSelection);
                      })),
              DropdownButton(
                items: mFactory
                    .createPlatformsDropdownMenuItems(allAddedPlatforms),
                onChanged: (value) => _handleAddNewPlatformToSelection(value),
              ),
              ActionButton(
                icon: Icons.add,
                toolTip: "Add platform",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext buildContext) =>
                          TextInputDialog(onDone: _addNewPlatform));
                },
              )
            ],
          ),
          height: 80,
        ),
        //ANCHOR listview
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: programs.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return _listItemFactory(programs[index]);
              }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add program',
        child: Icon(Icons.add),
        onPressed: _addProgram,
      ),
    );
  }

  Widget _listItemFactory(ProgramObject programObject) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext buildContext) => ProgramEditDialog(
                  program: programObject,
                  platforms: allAddedPlatforms,
                  editCallback: refreshPrograms,
                ));
      },
      child: Text(programObject.name),
      padding: const EdgeInsets.all(20),
    );
  }

  void refreshPrograms() {
    setState(() {});
  }

  void _addProgram() {
    ProgramObject program = ProgramObject("New Program", [
      CommandObject("Windows", "touch /home/h/github/localWebsites/test.txt"),
      CommandObject("Linux", "touch /home/h/github/localWebsites/test2.txt")
    ]);

    setState(() {
      programs.add(program);
    });
  }

  void _addNewPlatform(String platformName) {
    setState(() {
      allAddedPlatforms.add(platformName);
    });
  }

  void _handleAddNewPlatformToSelection(int index) {
    String platform = allAddedPlatforms[index];
    if (visiblePlatforms.contains(platform)) {
      print(visiblePlatforms);
      return;
    }

    setState(() {
      visiblePlatforms.add(platform);
    });
  }

  void _removePlatformFromSelection(int index) {
    setState(() {
      visiblePlatforms.removeAt(index);
    });
  }
}

void runCommands(
    List<ProgramObject> programObjects, List<String> selectedPlatforms) {
  for (ProgramObject programObject in programObjects) {
    print(programObject.name);
    runMatchingCommandsInProgram(selectedPlatforms, programObject);
  }
}

void runMatchingCommandsInProgram(
    List<String> selectedPlatforms, ProgramObject programObject) {
  for (CommandObject commandObject in programObject.commands) {
    if (selectedPlatforms.contains(commandObject.platform)) {
      runCommand(commandObject.command);
    }
  }
}

void runCommand(String command) {
  List<String> commands = command.split(" ");
  print(commands);
  Process.run(commands[0], commands.sublist(1, commands.length));
}
