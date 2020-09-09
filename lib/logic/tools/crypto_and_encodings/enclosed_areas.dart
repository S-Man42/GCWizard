import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';

final _AlphabetMap = {
  '0' : 1, '6' : 1, '8' : 2, '9' : 1,
  'A' : 1, 'B' : 2, 'D' : 1, 'O' : 1, 'P' : 1, 'Q' : 1, 'R' : 1,
  String.fromCharCode(196) : 1, //Ä
  String.fromCharCode(214) : 1, //Ö
  'a' : 1, 'b' : 1, 'd' : 1, 'o' : 1, 'p' : 1, 'q' : 1,
  String.fromCharCode(228) : 1, //ä
  String.fromCharCode(246) : 1, //ö
};
final _With4 = {'4': 1};

_createAlpabetMap(bool with4) {
  if (with4) {
    var alphabetMap = new Map<String, int>();
    alphabetMap.addAll(_AlphabetMap);
    alphabetMap.addAll(_With4);

    return alphabetMap;
  }
  else
    return _AlphabetMap;
}

String decodeEnclosedAreas(String input, bool with4) {
  if (input == null || input == '')
    return '';

  var alphabetMap = _createAlpabetMap(with4);

  return input
      .split(' ')
      .map((block) => _decodeEnclosedAreaBlock(block, alphabetMap))
      .join(' ');
}

int _decodeEnclosedAreaBlock(String input, Map<String, int> alphabetMap) {
  var output = 0;

  input.split('').forEach((character)
  {
    if (alphabetMap.containsKey(character))
      output += alphabetMap[character];
  });

  return output;
}
