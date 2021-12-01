
import 'package:gc_wizard/logic/tools/images_and_files/wherigo/parse/bobject.dart';

abstract class LObject extends BObject {

  String deref() {
    throw new IllegalStateException();
  }
  
  bool equals(Object o);
  
}
