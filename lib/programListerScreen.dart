import 'package:computer_program_sync/main.dart';
import 'package:computer_program_sync/non-graphics/commandHelper.dart';
import 'package:computer_program_sync/non-graphics/programObject.dart';
import 'package:computer_program_sync/widgets/programEditDialog.dart';
import 'package:computer_program_sync/widgets/actionbutton.dart';
import 'package:computer_program_sync/widgets/programListItem.dart';
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
  List<ProgramObject> visiblePrograms;

  @override
  Widget build(BuildContext context) {
    visiblePrograms = getVisiblePrograms(programs, visiblePlatforms);

    return Scaffold(
      appBar: AppBar(
        title: Text("Added programs"),
        actions: <Widget>[
          ActionButton(icon: Icons.replay, toolTip: "Reload"),
          ActionButton(icon: Icons.save, toolTip: "Save"),
          ActionButton(
            icon: Icons.play_arrow,
            toolTip: "Run",
            onPressed: () => runCommands(visiblePrograms, visiblePlatforms),
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
              itemCount: visiblePrograms.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return ProgramListItem(
                  program: visiblePrograms[index],
                  allAddedPlatforms: allAddedPlatforms,
                  editCallback: refreshPrograms,
                );
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

  void refreshPrograms() {
    setState(() {});
  }

  void _addProgram() {
    ProgramObject program = ProgramObject("New Program", []);

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

  List<ProgramObject> getVisiblePrograms(
      List<ProgramObject> programs, List<String> visiblePlatforms) {
    List<ProgramObject> visiblePrograms = <ProgramObject>[];

    if (visiblePlatforms.isEmpty) return programs;

    for (ProgramObject program in programs) {
      for (CommandObject commandObject in program.commands) {
        if (visiblePlatforms.contains(commandObject.platform)) {
          visiblePrograms.add(program);
          break;
        }
      }
    }

    return visiblePrograms;
  }
}
