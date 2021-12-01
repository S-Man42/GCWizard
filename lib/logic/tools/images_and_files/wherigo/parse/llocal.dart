
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/bobject.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/lstring.dart';

class LLocal extends BObject {

  final LString name;
  final int start;
  final int end;
  
  /* Used by the decompiler for annotation. */
  bool forLoop = false;
  
  LLocal(this.name, this.start, this.end) {
  }
  
  String toString() {
    return name.deref();
  }
  
}
