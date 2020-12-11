import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget actionButtonFactory(IconData icon, String tooltip) {
  return SizedBox(
    width: 50,
    child: Tooltip(
      child: FlatButton(child: Icon(icon)),
      message: tooltip,
    ),
  );
}

Widget createSelectedPlatformsColumnItem(List<String> visiblePlatforms,
    int index, Function removePlatformFromSelection) {
  String text = visiblePlatforms[index];

  return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(children: <Widget>[
        Center(child: Text(text)),
        Center(
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => removePlatformFromSelection(index),
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
