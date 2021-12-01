

import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/decompiler.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/expression/expression.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/output.dart';


class TableReference extends Expression {

  final Expression table;
  final Expression index;
  
  TableReference(this.table, this.index) {
    super(PRECEDENCE_ATOMIC);
  }

  int getConstantIndex() {
    return Math.max(table.getConstantIndex(), index.getConstantIndex());
  }
  
  void print(Decompiler d, Output out) {
    bool isGlobal = table.isEnvironmentTable(d) && index.isIdentifier();
    if(!isGlobal) {
      if(table.isUngrouped()) {
        out.print("(");
        table.print(d, out);
        out.print(")");
      }
      else
      {
        table.print(d, out);
      }
    }
    if(index.isIdentifier()) {
      if(!isGlobal) {
        out.print(".");
      }
      out.print(index.asName());
    } else {
      out.print("[");
      index.printBraced(d, out);
      out.print("]");
    }
  }

  bool isDotChain() {
    return index.isIdentifier() && table.isDotChain();
  }
  
  bool isMemberAccess() {
    return index.isIdentifier();
  }
  
  bool beginsWithParen() {
    return table.isUngrouped() || table.beginsWithParen();
  }
  
  Expression getTable() {
    return table;
  }
  
  String getField() {
    return index.asName();
  }

  
}
