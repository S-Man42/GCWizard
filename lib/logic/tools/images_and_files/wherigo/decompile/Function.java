import 'java.dart';

class Function
{
  List<Constant> constants;
    const int constantsOffset;

  Function(unluac_parse_LFunction function)
  {
    constants = new List<Constant>(function.constants.length);
    for (int i = 0; i < constants.length; i++) {
      constants[i] = new Constant(function.constants[i]);
    }
    if (function.header.version == Version.LUA50) {
      constantsOffset = 250;
    } else {
      constantsOffset = 256;
    }
  }

  bool isConstant(int register)
  {
    return register >= constantsOffset;
  }

  int constantIndex(int register)
  {
    return register - constantsOffset;
  }

  String getGlobalName(int constantIndex)
  {
    return constants[constantIndex].asName();
  }

  unluac_decompile_expression_ConstantExpression getConstantExpression(int constantIndex)
  {
    return new unluac_decompile_expression_ConstantExpression(constants[constantIndex], constantIndex);
  }

  unluac_decompile_expression_GlobalExpression getGlobalExpression(int constantIndex)
  {
    return new unluac_decompile_expression_GlobalExpression(getGlobalName(constantIndex), constantIndex);
  }
}