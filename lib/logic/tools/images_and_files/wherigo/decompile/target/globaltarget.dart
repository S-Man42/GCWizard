
//import unluac.decompile.Decompiler;
//import unluac.decompile.Output;

import 'package:gc_wizard/logic/tools/images_and_files/wherigo/decompile/target/target.dart';

class GlobalTarget extends Target {

  final String name;
  
  GlobalTarget(this.name) {
  }

  void print(Decompiler d, Output out) {
    out.print(name);
  }
  
  void printMethod(Decompiler d, Output out) {
    throw new IllegalStateException();
  }
  
}
