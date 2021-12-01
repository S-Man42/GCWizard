

import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/constant.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/decompiler.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/expression/expression.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/output.dart';

class ConstantExpression extends Expression {

  final Constant constant;
  final int index;
  
  ConstantExpression(this.constant, this.index) {
    super(PRECEDENCE_ATOMIC);
  }

  int getConstantIndex() {
    return index;
  }
  
  void print(Decompiler d, Output out) {
    constant.print(d, out, false);
  }
  
  void printBraced(Decompiler d, Output out) {
    constant.print(d, out, true);
  }
  
  bool isConstant() {
    return true;
  }
  
  bool isUngrouped() {
    return true;
  }
  
  bool isNil() {
    return constant.isNil();
  }
  
  bool isBoolean() {
    return constant.isBoolean();
  }
  
  bool isInteger() {
    return constant.isInteger();
  }
  
  int asInteger() {
    return constant.asInteger();
  }
  
  bool isString() {
    return constant.isString();
  }
  
  bool isIdentifier() {
    return constant.isIdentifier();
  }
    
  String asName() {
    return constant.asName();
  }
  
  bool isBrief() {
    return !constant.isString() || constant.asName().length() <= 10;
  }
  
}
