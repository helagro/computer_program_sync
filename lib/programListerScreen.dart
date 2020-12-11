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
  final List<String> listItems = <String>["some", "example", "text"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Added programs"),
        actions: <Widget>[
          ActionButton(icon: Icons.replay, toolTip: "Reload"),
          ActionButton(icon: Icons.save, toolTip: "Save"),
          ActionButton(icon: Icons.play_arrow, toolTip: "Run"),
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
                            removeBtnCallback: removePlatformFromSelection);
                      })),
              DropdownButton(
                items: mFactory
                    .createPlatformsDropdownMenuItems(allAddedPlatforms),
                onChanged: (value) => handleAddNewPlatformToSelection(value),
              ),
              ActionButton(
                icon: Icons.add,
                toolTip: "Add platform",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext buildContext) =>
                          TextInputDialog(onDone: addNewPlatform));
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
              itemCount: listItems.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return _listItemFactory(listItems[index]);
              }),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add program',
        child: Icon(Icons.add),
        onPressed: _addItem,
      ),
    );
  }

  Widget _listItemFactory(String text) {
    return FlatButton(
      onPressed: () {
        CommandObject command = CommandObject("Windows", "touch test.txt");
        ProgramObject program = ProgramObject("Test", [command]);
        showDialog(
            context: context,
            builder: (BuildContext buildContext) => ProgramEditDialog(
                  program: program,
                  platforms: allAddedPlatforms,
                ));
      },
      child: Text(text),
      padding: const EdgeInsets.all(20),
    );
  }

  void _addItem() {
    setState(() {
      listItems.add("I am added from btn");
    });
    //Process.run('touch', ['/home/h/github/localWebsites/hi.txt']);
  }

  void addNewPlatform(String platformName) {
    setState(() {
      allAddedPlatforms.add(platformName);
    });
  }

  void handleAddNewPlatformToSelection(int index) {
    String platform = allAddedPlatforms[index];
    if (visiblePlatforms.contains(platform)) {
      print(visiblePlatforms);
      return;
    }

    setState(() {
      visiblePlatforms.add(platform);
    });
  }

  void removePlatformFromSelection(int index) {
    setState(() {
      visiblePlatforms.removeAt(index);
    });
  }
}
