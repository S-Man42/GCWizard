import 'APIMapper.dart';
import '../../../lib/tools/crypto_and_encodings/rotation/logic/rotator.dart';
//import '../../../lib/utils/string_utils.dart';

class RotatorAPIMapper extends APIMapper {

  @override
  String doLogic() {
    var input = params[WEBPARAMETER.input.name];
    if (input == null) {
      return '';
    }
    var parameter1 = params[WEBPARAMETER.parameter1.name];
    var key = 0;
    if (parameter1 != null && parameter1.isNotEmpty) {
      key = int.parse(parameter1);
    }

    return Rotator().rotate(input, key);
  }

  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{WEBPARAMETER.result.name : result.toString()};
  }
}
