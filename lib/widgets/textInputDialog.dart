import 'package:flutter/material.dart';

class TextInputDialog extends StatelessWidget {
  final Function onDone;
  final TextEditingController textEditingController = TextEditingController();

  TextInputDialog({Key key, this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        SizedBox(
          height: 60,
          width: 200,
          child: TextField(
            decoration: InputDecoration(hintText: "Enter text"),
            controller: textEditingController,
          ),
        ),
        RaisedButton(
          child: Text("Done"),
          onPressed: () => onDoneBtnPressed(context),
        ),
      ],
    );
  }

  void onDoneBtnPressed(BuildContext context) {
    Navigator.pop(context);
    onDone(textEditingController.text);
  }
}
