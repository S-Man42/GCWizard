
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/bheader.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/bobject.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/llocal.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/lobject.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/lupvalue.dart';

class LFunction extends BObject {
  
  BHeader header;
  LFunction parent;
  List<int> code;
  List<LLocal> locals;
  List<LObject> constants;
  List<LUpvalue> upvalues;
  List<LFunction> functions;
  int maximumStackSize;
  int numUpvalues;
  int numParams;
  int vararg;
  bool stripped;
  
  LFunction(BHeader header, List<int> code, List<LLocal> locals, List<LObject> constants, List<LUpvalue> upvalues, List<LFunction> functions, int maximumStackSize, int numUpValues, int numParams, int vararg) {
    this.header = header;
    this.code = code;
    this.locals = locals;
    this.constants = constants;
    this.upvalues = upvalues;
    this.functions = functions;
    this.maximumStackSize = maximumStackSize;
    this.numUpvalues = numUpValues;
    this.numParams = numParams;
    this.vararg = vararg;
    this.stripped = false;
  }
  
}
