import 'package:computer_program_sync/main.dart';
import 'package:flutter/material.dart';

class ProgramListerScreen extends StatefulWidget {
  ProgramListerScreen({Key key}) : super(key: key);

  @override
  _ProgramListerScreenState createState() => _ProgramListerScreenState();
}

class _ProgramListerScreenState extends State<ProgramListerScreen> {
  final List<String> listItems = <String>["some", "example", "text"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Added programs"),
        actions: <Widget>[
          _actionButtonFactory(Icons.replay, "Reload"),
          _actionButtonFactory(Icons.save, "Save"),
          _actionButtonFactory(Icons.play_arrow, "Run"),
        ],
      ),
      body: ListView.builder(
          itemCount: listItems.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return _listItemFactory(listItems[index]);
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add program',
        child: Icon(Icons.add),
        onPressed: addItem,
      ),
    );
  }

  void addItem() {
    setState(() {
      listItems.add("I am added from btn");
    });
  }
}

Widget _actionButtonFactory(IconData icon, String tooltip) {
  return SizedBox(
    width: 50,
    child: Tooltip(
      child: FlatButton(child: Icon(icon)),
      message: tooltip,
    ),
  );
}

Widget _listItemFactory(String text) {
  return RaisedButton(child: Text(text));
}
