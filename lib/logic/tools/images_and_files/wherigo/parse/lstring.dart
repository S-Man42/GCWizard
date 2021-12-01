
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/bsizet.dart';
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/lobject.dart';

class LString extends LObject {

  final BSizeT size;
  final String value;
  
  LString(this.size, this.value) {
  }
  
  String deref() {
    return value;
  }
  
  String toString() {
    return "\"" + value + "\"";
  }
  
  bool equals(Object o) {
    if(o instanceof LString) {
      LString os = (LString) o;
      return os.value.equals(value);
    }
    return false;
  }
  
}
