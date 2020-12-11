import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget(
      {Key key, @required this.text, this.index, this.removeBtnCallback})
      : super(key: key);

  final String text;
  final Function removeBtnCallback;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(children: <Widget>[
          Center(child: Text(text)),
          Center(
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => removeBtnCallback(index),
            ),
          )
        ]));
  }
}
