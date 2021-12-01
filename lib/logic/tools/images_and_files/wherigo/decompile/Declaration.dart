
class Declaration
{
  final String name;
  int begin;
  int end;
  int register;
  bool forLoop = false;
  bool forLoopExplicit = false;

  Declaration(unluac_parse_LLocal local) {
    this.name = local.toString();
    this.begin = local.start;
    this.end = local.end;
  }

  Declaration(this.name, this.begin, this.end) {}
}