import 'package:gc_wizard/tools/crypto_and_encodings/roman_numbers/roman_numbers/logic/roman_numbers.dart';

import 'APIMapper.dart';

class RomanNumbersAPIMapper extends APIMapper {

  @override
  String doLogic() {
    var input = getWebParameter(WEBPARAMETER.input);
    if (input == null) {
      return '';
    }

    if (getWebParameter(WEBPARAMETER.mode) == enumName(MODE.encode.toString())) {
      return encodeRomanNumbers(int.tryParse(input) ?? 0);
    } else {
      return decodeRomanNumbers(input)?.toString() ?? '';
    }
  }

  /// convert doLogic output to map
  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{enumName(WEBPARAMETER.result.toString()) : result.toString()};
  }
}

