import 'package:gc_wizard/utils/common_utils.dart';

final _AlphabetMap = {
  'B': '8', 'E': '3', 'G': '9', 'g': '6', 'h': '4', 'I': '1', 'L': '7', 'O': '0', 'S': '5', 'Z': '2', ' ': ' ', '.': '.'};


String decodeBeghilos(String input) {
  return _translateBeghilos(input, _AlphabetMap);
}

String encodeBeghilos(String input) {
  return _translateBeghilos(input, switchMapKeyValue(_AlphabetMap));
}

String _translateBeghilos(String input, Map<String, String> alphabetMap) {
  if (input == null || input == '') return '';

  var output = input
      .split('')
      .map((letter) {
      return alphabetMap.containsKey(letter) ? alphabetMap[letter] : '';
      })
      .join();

  return output = output.split('').reversed.join('');
}
