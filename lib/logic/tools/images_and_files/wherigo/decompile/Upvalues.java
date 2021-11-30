
import 'java.dart';

class Upvalues
{
  final List<unluac_parse_LUpvalue> upvalues;

  Upvalues(unluac_parse_LFunction func, List<Declaration> parentDecls, int line)
  {
    this.upvalues = func.upvalues;
    for (unluac_parse_LUpvalue upvalue in upvalues) {
    if ((upvalue.name == null) || upvalue.name.isEmpty()) {
      if (upvalue.instack) {
        if (parentDecls != null) {
          for (Declaration decl in parentDecls) {
            if (((decl.register == upvalue.idx) && (line >= decl.begin)) && (line < decl.end)) {
              upvalue.name = decl.name;
              break;
            }
          }
        }
      } else {
        List<unluac_parse_LUpvalue> parentvals = func.parent.upvalues;
        if ((upvalue.idx >= 0) && (upvalue.idx < parentvals.length)) {
          upvalue.name = parentvals[upvalue.idx].name;
        }
      }
    }
  }
  }

  String getName(int index)
  {
    if (((index < upvalues.length) && (upvalues[index].name != null)) && (!upvalues[index].name.isEmpty())) {
      return upvalues[index].name;
    } else {
      return ("_UPVALUE" + index) + "_";
    }
  }

  unluac_decompile_expression_UpvalueExpression getExpression(int index)
  {
    return new unluac_decompile_expression_UpvalueExpression(getName(index));
  }
}