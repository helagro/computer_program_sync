import 'package:flutter/material.dart';

class ProgramListerScreen extends StatelessWidget {
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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add program',
        child: Icon(Icons.add),
      ),
    );
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
