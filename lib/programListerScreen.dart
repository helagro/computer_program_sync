import 'package:computer_program_sync/main.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/chat/v1.dart';
import 'package:computer_program_sync/programListenerScreenFactories.dart'
    as mFactory;

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
          mFactory.actionButtonFactory(Icons.replay, "Reload"),
          mFactory.actionButtonFactory(Icons.save, "Save"),
          mFactory.actionButtonFactory(Icons.play_arrow, "Run"),
        ],
      ),
      body: Column(children: [
        SizedBox(
          child: Row(
            children: [
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: visiblePlatforms.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext buildContext, int index) {
                        return mFactory.createSelectedPlatformsColumnItem(
                            visiblePlatforms,
                            index,
                            removePlatformFromSelection);
                      })),
              SizedBox(
                child: DropdownButton(
                  items: mFactory
                      .createPlatformsDropdownMenuItems(allAddedPlatforms),
                  onChanged: (value) => handleAddNewPlatformToSelection(value),
                ),
              )
            ],
          ),
          height: 80,
        ),
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
      onPressed: _addItem,
      child: Text(text),
      padding: const EdgeInsets.all(20),
    );
  }

  void _addItem() {
    setState(() {
      listItems.add("I am added from btn");
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
