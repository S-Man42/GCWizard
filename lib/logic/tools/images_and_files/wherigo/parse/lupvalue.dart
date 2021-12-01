
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/bobject.dart';

class LUpvalue extends BObject {

  bool instack;
  int idx;
  
  String name;
  
  bool equals(Object obj) {
    if(obj instanceof LUpvalue) {
      LUpvalue upvalue = (LUpvalue) obj;
      if(!(instack == upvalue.instack && idx == upvalue.idx)) {
        return false;
      }
      if(name == upvalue.name) {
        return true;
      }
      return name != null && name.equals(upvalue.name);
    } else {
      return false;
    }
  }
  
}
