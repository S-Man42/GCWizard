import 'java.dart';

class Registers
{
    const int registers;
    const int length;
  final List<List<Declaration>> decls;
  final Function f;
  final List<List<unluac_decompile_expression_Expression>> values;
  final List<List<int>> updated;

  Registers(int registers, int length, List<Declaration> declList, Function f)
  {
    this.registers = registers;
    this.length = length;
    decls = new List<Declaration>(registers)[length + 1];
    for (int i = 0; i < declList.length; i++) {
      Declaration decl = declList[i];
      int register = 0;
      while (decls[register][decl.begin] != null) {
        register++;
      }
      decl.register = register;
      for (int line = decl.begin; line <= decl.end; line++) {
        decls[register][line] = decl;
      }
    }
    values = new List<unluac_decompile_expression_Expression>(registers)[length + 1];
    for (int register = 0; register < registers; register++) {
      values[register][0] = Expression_.NIL;
    }
    updated = new List<int>(registers)[length + 1];
    startedLines = new List<bool>((length + 1));
    Arrays.fill(startedLines, false);
    this.f = f;
  }

  bool isAssignable(int register, int line)
  {
    return isLocal(register, line) && (!decls[register][line].forLoop);
  }

  bool isLocal(int register, int line)
  {
    if (register < 0) {
      return false;
    }
    return decls[register][line] != null;
  }

  bool isNewLocal(int register, int line)
  {
    Declaration decl = decls[register][line];
    return ((decl != null) && (decl.begin == line)) && (!decl.forLoop);
  }

  java_util_List<Declaration> getNewLocals(int line)
  {
    java_util_ArrayList<Declaration> locals = new java_util_ArrayList<Declaration>(registers);
    for (int register = 0; register < registers; register++) {
      if (isNewLocal(register, line)) {
        locals.add(getDeclaration(register, line));
      }
    }
    return locals;
  }

  Declaration getDeclaration(int register, int line)
  {
    return decls[register][line];
  }
  List<bool> startedLines;

  void startLine(int line)
  {
    startedLines[line] = true;
    for (int register = 0; register < registers; register++) {
      values[register][line] = values[register][line - 1];
      updated[register][line] = updated[register][line - 1];
    }
  }

  unluac_decompile_expression_Expression getExpression(int register, int line)
  {
    if (isLocal(register, line - 1)) {
      return new unluac_decompile_expression_LocalVariable(getDeclaration(register, line - 1));
    } else {
      return values[register][line - 1];
    }
  }

  unluac_decompile_expression_Expression getKExpression(int register, int line)
  {
    if (f.isConstant(register)) {
      return f.getConstantExpression(f.constantIndex(register));
    } else {
      return getExpression(register, line);
    }
  }

  unluac_decompile_expression_Expression getValue(int register, int line)
  {
    return values[register][line - 1];
  }

  int getUpdated(int register, int line)
  {
    return updated[register][line];
  }

  void setValue(int register, int line, unluac_decompile_expression_Expression expression)
  {
    values[register][line] = expression;
    updated[register][line] = line;
  }

  unluac_decompile_target_Target getTarget(int register, int line)
  {
    if (!isLocal(register, line)) {
      throw new IllegalStateException((("No declaration exists in register " + register) + " at line ") + line);
    }
    return new unluac_decompile_target_VariableTarget(decls[register][line]);
  }

  void setInternalLoopVariable(int register, int begin, int end)
  {
    Declaration decl = getDeclaration(register, begin);
    if (decl == null) {
      decl = new Declaration("_FOR_", begin, end);
      decl.register = register;
      newDeclaration(decl, register, begin, end);
    }
    decl.forLoop = true;
  }

  void setExplicitLoopVariable(int register, int begin, int end)
  {
    Declaration decl = getDeclaration(register, begin);
    if (decl == null) {
      decl = new Declaration(("_FORV_" + register) + "_", begin, end);
      decl.register = register;
      newDeclaration(decl, register, begin, end);
    }
    decl.forLoopExplicit = true;
  }

  void newDeclaration(Declaration decl, int register, int begin, int end)
  {
    for (int line = begin; line <= end; line++) {
      decls[register][line] = decl;
    }
  }
}