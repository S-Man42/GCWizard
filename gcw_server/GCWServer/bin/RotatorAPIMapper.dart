import 'APIMapper.dart';
 import '../../../lib/tools/crypto_and_encodings/reverse/logic/reverse.dart';
 // import 'D:/GitHub/GCWizard/lib/logic/tools/crypto_and_encodings/reverse.dart';

class RotatorAPIMapper extends APIMapper {

  @override
  Function doLogic() {
    return logic; //Rotator().rot13;
  }
  String logic(String text) {
    return reverse('test');
  }

  @override
  Map<String, String> toMap(Object stuff) {
    return <String, String>{};
  }
}
