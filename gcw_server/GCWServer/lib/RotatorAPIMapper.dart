import 'package:gcw_server/APIMapper.dart';
// import '../../../lib/logic/tools/crypto_and_encodings/rotator.dart';
// import 'D:/GitHub/GCWizard/lib/logic/tools/crypto_and_encodings/rotator.dart';

class RotatorAPIMapper extends APIMapper {

  @override
  Function doLogic() {
    return null; //Rotator().rot13;
  }

  @override
  Map<String, String> toMap(dynamic stuff) {
    return Map<String, String>();
  }
}