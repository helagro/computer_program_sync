class ProgramObject {
  String name;
  List<CommandObject> commands;

  ProgramObject(this.name, this.commands);
}

class CommandObject {
  String platform;
  String command;

  CommandObject(this.platform, this.command);
}
