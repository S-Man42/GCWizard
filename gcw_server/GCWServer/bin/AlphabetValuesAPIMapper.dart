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
    var key = 0;
    if (parameter1 != null && parameter1.isNotEmpty) {
      key = int.parse(parameter1);
    }

    final _currentAlphabetKey = ALL_ALPHABETS.alphabetAZ.;
    var _currentAlphabet = _getAlphabetByKey(_currentAlphabetKey).alphabet;

    return intListToString(
        logic.AlphabetValues(alphabet: alphabet).textToValues(_currentEncodeInput, keepNumbers: true),
        delimiter: ' ');
    return Rotator().rotate(input, key);
  }

  /// convert doLogic output to map
  @override
  Map<String, String> toMap(Object result) {
    return <String, String>{enumName(WEBPARAMETER.result.toString()) : result.toString()};
  }
}

Alphabet _getAlphabetByKey(String key) {
  var _alphabets = List<Alphabet>.from(ALL_ALPHABETS);
  return _alphabets.firstWhere((alphabet) => alphabet.key == key);
}
