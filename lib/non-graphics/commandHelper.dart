import 'dart:io';

import 'package:computer_program_sync/non-graphics/programObject.dart';

void runCommands(
    List<ProgramObject> programObjects, List<String> selectedPlatforms) {
  for (ProgramObject programObject in programObjects) {
    runMatchingCommandsInProgram(selectedPlatforms, programObject);
  }
}

void runMatchingCommandsInProgram(
    List<String> selectedPlatforms, ProgramObject programObject) {
  for (CommandObject commandObject in programObject.commands) {
    if (selectedPlatforms.contains(commandObject.platform)) {
      runCommand(commandObject.command);
    }
  }
}

void runCommand(String command) {
  List<String> commands = command.split(" ");
  print(commands);
  Process.run(commands[0], commands.sublist(1, commands.length));
}
