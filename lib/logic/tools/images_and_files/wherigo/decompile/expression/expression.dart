
//import unluac.decompile.Constant;
//import unluac.parse.LNil;

import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/decompiler.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/output.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/target/target.dart';

class Expression {

  int PRECEDENCE_OR = 1;
  final int PRECEDENCE_AND = 2;
  final int PRECEDENCE_COMPARE = 3;
  final int PRECEDENCE_BOR = 4;
  final int PRECEDENCE_BXOR = 5;
  final int PRECEDENCE_BAND = 6;
  final int PRECEDENCE_SHIFT = 7;
  final int PRECEDENCE_CONCAT = 8;
  final int PRECEDENCE_ADD = 9;
  final int PRECEDENCE_MUL = 10;
  final int PRECEDENCE_UNARY = 11;
  final int PRECEDENCE_POW = 12;
  final int PRECEDENCE_ATOMIC = 13;
  
  final int ASSOCIATIVITY_NONE = 0;
  final int ASSOCIATIVITY_LEFT = 1;
  final int ASSOCIATIVITY_RIGHT = 2;
  
  final Expression NIL = new ConstantExpression(new Constant(LNil.NIL), -1);
  
  BinaryExpression makeCONCAT(Expression left, Expression right) {
    return new BinaryExpression("..", left, right, PRECEDENCE_CONCAT, ASSOCIATIVITY_RIGHT);
  }
  
  BinaryExpression makeADD(Expression left, Expression right) {
    return new BinaryExpression("+", left, right, PRECEDENCE_ADD, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeSUB(Expression left, Expression right) {
    return new BinaryExpression("-", left, right, PRECEDENCE_ADD, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeMUL(Expression left, Expression right) {
    return new BinaryExpression("*", left, right, PRECEDENCE_MUL, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeDIV(Expression left, Expression right) {
    return new BinaryExpression("/", left, right, PRECEDENCE_MUL, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeMOD(Expression left, Expression right) {
    return new BinaryExpression("%", left, right, PRECEDENCE_MUL, ASSOCIATIVITY_LEFT);
  }
  
  UnaryExpression makeUNM(Expression expression) {
    return new UnaryExpression("-", expression, PRECEDENCE_UNARY);
  }
  
  UnaryExpression makeNOT(Expression expression) {
    return new UnaryExpression("not ", expression, PRECEDENCE_UNARY);
  }
  
  UnaryExpression makeLEN(Expression expression) {
    return new UnaryExpression("#", expression, PRECEDENCE_UNARY);
  }
  
  BinaryExpression makePOW(Expression left, Expression right) {
    return new BinaryExpression("^", left, right, PRECEDENCE_POW, ASSOCIATIVITY_RIGHT);
  }
  
  BinaryExpression makeIDIV(Expression left, Expression right) {
    return new BinaryExpression("//", left, right, PRECEDENCE_MUL, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeBAND(Expression left, Expression right) {
    return new BinaryExpression("&", left, right, PRECEDENCE_BAND, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeBOR(Expression left, Expression right) {
    return new BinaryExpression("|", left, right, PRECEDENCE_BOR, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeBXOR(Expression left, Expression right) {
    return new BinaryExpression("~", left, right, PRECEDENCE_BXOR, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeSHL(Expression left, Expression right) {
    return new BinaryExpression("<<", left, right, PRECEDENCE_SHIFT, ASSOCIATIVITY_LEFT);
  }
  
  BinaryExpression makeSHR(Expression left, Expression right) {
    return new BinaryExpression(">>", left, right, PRECEDENCE_SHIFT, ASSOCIATIVITY_LEFT);
  }
  
  UnaryExpression makeBNOT(Expression expression) {
    return new UnaryExpression("~", expression, PRECEDENCE_UNARY);
  }
  
  /**
   * Prints out a sequences of expressions with commas, and optionally
   * handling multiple expressions and return value adjustment.
   */
  void printSequence(Decompiler d, Output out, List<Expression> exprs, bool linebreak, bool multiple) {
    int n = exprs.size();
    int i = 1;
    for (int i = 0; i < exprs.length; i++) {
      bool last = (i == n);
      if(exprs[i].isMultiple()) {
        last = true;
      }
      if(last) {
        if(multiple) {
          exprs[i].printMultiple(d, out);
        } else {
          exprs[i].print(d, out);
        }
        break;
      } else {
        exprs[].print(d, out);
        out.print(",");
        if(linebreak) {
          out.println();
        } else {
          out.print(" ");
        }
      }
      i++;
    }
  }
  
  final int precedence;
  
  Expression(int precedence) {
    this.precedence = precedence;
  }
  
  void printUnary(Decompiler d, Output out, String op, Expression expression) {
    out.print(op);
    expression.print(d, out);
  }
  
  void printBinary(Decompiler d, Output out, String op, Expression left, Expression right) {
    left.print(d, out);
    out.print(" ");
    out.print(op);
    out.print(" ");
    right.print(d, out);
  }
  
  void print(Decompiler d, Output out);
  
  /**
   * Prints the expression in a context where it is surrounded by braces.
   * (Thus if the expression would begin with a brace, it must be enclosed
   * in parentheses to avoid ambiguity.)
   */
  void printBraced(Decompiler d, Output out) {
    print(d, out);
  }
  
  /**
   * Prints the expression in a context that accepts multiple values.
   * (Thus, if an expression that normally could return multiple values
   * doesn't, it should use parens to adjust to 1.)
   */
  void printMultiple(Decompiler d, Output out) {
    print(d, out);
  }
  
  /**
   * Determines the index of the last-declared constant in this expression.
   * If there is no constant in the expression, return -1.
   */
  int getConstantIndex();
  
  bool beginsWithParen() {
    return false;
  }
  
  bool isNil() {
    return false;
  }
  
  bool isClosure() {
    return false;
  }
  
  bool isConstant() {
    return false;
  }
  
  /**
   * An ungrouped expression is one that needs to be enclosed in parentheses
   * before it can be dereferenced. This doesn't apply to multiply-valued expressions
   * as those will be given parentheses automatically when converted to a single value.
   * e.g.
   *  (a+b).c; ("asdf"):gsub()
   */
  bool isUngrouped() {
    return false;
  }
  
  // Only supported for closures
  bool isUpvalueOf(int register) {
    throw new IllegalStateException();
  }
  
  bool isBoolean() {
    return false;
  }
  
  bool isInteger() {
    return false;
  }
  
  int asInteger() {
    throw new IllegalStateException();
  }
  
  bool isString() {
    return false;
  }
  
  bool isIdentifier() {
    return false;
  }
  
  /**
   * Determines if this can be part of a function name.
   * Is it of the form: {Name . } Name
   */
  bool isDotChain() {
    return false;
  }
  
  int closureUpvalueLine() {
    throw new IllegalStateException();
  }
  
  void printClosure(Decompiler d, Output out, Target name) {
    throw new IllegalStateException();
  }
  
  String asName() {
    throw new IllegalStateException();
  }
  
  bool isTableLiteral() {
    return false;
  }
  
  bool isNewEntryAllowed() {
    throw new IllegalStateException();
  }
  
  void addEntry(TableLiteral.Entry entry) {
    throw new IllegalStateException();
  }
  
  /**
   * Whether the expression has more than one return stored into registers.
   */
  bool isMultiple() {
    return false;
  }
  
  bool isMemberAccess() {
    return false;
  }
  
  Expression getTable() {
    throw new IllegalStateException();
  }
  
  String getField() {
    throw new IllegalStateException();
  }  
  
  bool isBrief() {
    return false;
  }
  
  bool isEnvironmentTable(Decompiler d) {
    return false;
  }
  
}
