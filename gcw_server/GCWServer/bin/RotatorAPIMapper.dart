import 'package:gc_wizard/tools/crypto_and_encodings/rotation/logic/rotator.dart';

import 'APIMapper.dart';

class RotatorAPIMapper extends APIMapper {

  @override
  String doLogic() {
    var input = getWebParameter(WEBPARAMETER.input);
    if (input == null) {
      return '';
    }
    var parameter1 = getWebParameter(WEBPARAMETER.parameter1);
    var key = 0;
    if (parameter1 != null && parameter1.isNotEmpty) {
      key = int.parse(parameter1);
    }

    return Rotator().rotate(input, key);
  }

  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{enumName(WEBPARAMETER.result.toString()) : result.toString()};
  }
}
