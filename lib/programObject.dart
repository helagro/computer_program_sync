class ProgramObject {
  String name;
  List<Command> commands;

  ProgramObject(this.name, this.commands);
}

class Command {
  String platform;
  String command;
}
