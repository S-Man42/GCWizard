import 'java.dart';

class Declaration
{
  final String name;
    const int begin;
    const int end;
  int register;
  bool forLoop = false;
  bool forLoopExplicit = false;

  Declaration(unluac_parse_LLocal local)
  {
    this.name = local.toString();
    this.begin = local.start;
    this.end = local.end;
  }

  Declaration(String name, int begin, int end)
  {
    this.name = name;
    this.begin = begin;
    this.end = end;
  }
}