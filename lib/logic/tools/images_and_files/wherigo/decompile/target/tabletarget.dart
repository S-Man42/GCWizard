

//import unluac.decompile.Decompiler;
//import unluac.decompile.Output;
//import unluac.decompile.expression.Expression;
//import unluac.decompile.expression.TableReference;

import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/decompiler.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/expression/expression.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/output.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/target/target.dart';

class TableTarget extends Target {

  final Expression table;
  final Expression index;
  
  TableTarget(this.table, this.index) {
  }

  void print(Decompiler d, Output out) {
    new TableReference(table, index).print(d, out);
  }
  
  void printMethod(Decompiler d, Output out) {
    table.print(d, out);
    out.print(":");
    out.print(index.asName());
  }
  
  bool isFunctionName() {
    if(!index.isIdentifier()) {
      return false;
    }
    if(!table.isDotChain()) {
      return false;
    }
    return true;
  }
  
  bool beginsWithParen() {
    return table.isUngrouped() || table.beginsWithParen();
  }
  
}
