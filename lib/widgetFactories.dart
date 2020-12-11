import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
