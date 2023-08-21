import 'package:gc_wizard/tools/crypto_and_encodings/morse/logic/morse.dart';

import 'APIMapper.dart';

class MorseAPIMapper extends APIMapper {

  @override
  String doLogic() {
    var input = getWebParameter(WEBPARAMETER.input);
    if (input == null) {
      return '';
    }

    if (getWebParameter(WEBPARAMETER.mode) == enumName(MODE.encode.toString())) {
      return encodeMorse(input);
    } else {
      return decodeMorse(input);
    }
  }

  /// convert doLogic output to map
  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{enumName(WEBPARAMETER.result.toString()) : result.toString()};
  }
}

