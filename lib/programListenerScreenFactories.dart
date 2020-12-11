import 'package:flutter/material.dart';

Widget actionButtonFactory(IconData icon, String tooltip) {
  return SizedBox(
    width: 50,
    child: Tooltip(
      child: FlatButton(child: Icon(icon)),
      message: tooltip,
    ),
  );
}

Widget createSelectedPlatformsColumnItem(String text) {
  return SizedBox(
      width: 200,
      child: Row(children: <Widget>[
        SizedBox(width: 80, child: Text(text)),
        SizedBox(
          width: 20,
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
        )
      ]));
}

List<DropdownMenuItem> createPlatformsDropdownMenuItems(
    List<String> allAddedPlatforms) {
  List<DropdownMenuItem> dropdownMenuItems = [];
  for (int i = 0; i < allAddedPlatforms.length; i++) {
    final String platformStr = allAddedPlatforms[i];
    final DropdownMenuItem dropdownMenuItem = DropdownMenuItem(
      child: Text(platformStr),
      value: i,
    );
    dropdownMenuItems.add(dropdownMenuItem);
  }
  return dropdownMenuItems;
}
