import 'package:gc_wizard/tools/crypto_and_encodings/alphabet_values/logic/alphabet_values.dart' as logic;
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/collection_utils.dart';

import 'APIMapper.dart';

class AlphabetValuesAPIMapper extends APIMapper {

  @override
  String doLogic() {
    var input = getWebParameter(WEBPARAMETER.input);
    if (input == null) {
      return '';
    }
    var parameter1 = getWebParameter(WEBPARAMETER.parameter1);
    var key = '';
    if (parameter1 != null && parameter1.isNotEmpty) {
      key = parameter1;
    }
    var alphabet = _getAlphabetByKey(key).alphabet;

    if (getWebParameter(WEBPARAMETER.mode) == enumName(MODE.encode.toString())) {
      var values = textToIntList(input);
      return logic.AlphabetValues(alphabet: alphabet).valuesToText(values);
    } else {
      return intListToString(
          logic.AlphabetValues(alphabet: alphabet).textToValues(input, keepNumbers: true),
          delimiter: ' ');
    }



  }

  /// convert doLogic output to map
  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{enumName(WEBPARAMETER.result.toString()) : result.toString()};
  }
}

Alphabet _getAlphabetByKey(String key) {
  var _alphabets = List<Alphabet>.from(ALL_ALPHABETS);
  Alphabet? alphabet;
  if (key.isNotEmpty) {
    try {
      alphabet = _alphabets.firstWhere((alphabet) => alphabet.key == key);
    } catch (e) {}
  }
  if (alphabet == null) {
    alphabet = alphabetAZ;
  }

  return alphabet;
}
