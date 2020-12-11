import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String toolTip;

  ActionButton({Key key, @required this.icon, this.toolTip = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Tooltip(
        child: FlatButton(child: Icon(icon)),
        message: toolTip,
      ),
    );
  }
}
