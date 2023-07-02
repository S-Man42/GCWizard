import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';
import 'package:gc_wizard/utils/collection_utils.dart';

const Map<bool, Map<String, String>> _AZToBacon = {
  true: {
    'A': 'AAAAA',
    'B': 'AAAAB',
    'C': 'AAABA',
    'D': 'AAABB',
    'E': 'AABAA',
    'F': 'AABAB',
    'G': 'AABBA',
    'H': 'AABBB',
    'J': 'ABAAA',
    'I': 'ABAAA',
    'K': 'ABAAB',
    'L': 'ABABA',
    'M': 'ABABB',
    'N': 'ABBAA',
    'O': 'ABBAB',
    'P': 'ABBBA',
    'Q': 'ABBBB',
    'R': 'BAAAA',
    'S': 'BAAAB',
    'T': 'BAABA',
    'V': 'BAABB',
    'U': 'BAABB',
    'W': 'BABAA',
    'X': 'BABAB',
    'Y': 'BABBA',
    'Z': 'BABBB',
  },
  false: {
  //https://www.geocachingtoolbox.com/index.php?lang=de&page=baconianCipher
    'A': 'AAAAA',
    'B': 'AAAAB',
    'C': 'AAABA',
    'D': 'AAABB',
    'E': 'AABAA',
    'F': 'AABAB',
    'G': 'AABBA',
    'H': 'AABBB',
    'I': 'ABAAA',
    'J': 'ABAAB',
    'K': 'ABABA',
    'L': 'ABABB',
    'M': 'ABBAA',
    'N': 'ABBAB',
    'O': 'ABBBA',
    'P': 'ABBBB',
    'Q': 'BAAAA',
    'R': 'BAAAB',
    'S': 'BAABA',
    'T': 'BAABB',
    'U': 'BABAA',
    'V': 'BABAB',
    'W': 'BABBA',
    'X': 'BABBB',
    'Y': 'BBAAA',
    'Z': 'BBAAB',
  }
};

final Map<bool, Map<String, String>> _BaconToAZ = {};

String encodeBacon(String input, bool inverse, bool binary, bool original) {
  if (input.isEmpty) return '';
// I has same code as J, so I replaces J in mapping; J will not occur in this map
// U has same code as V, so U replaces V in mapping; V will not occur in this map
  _BaconToAZ[true] = switchMapKeyValue(_AZToBacon[true]!);
  _BaconToAZ[false] = switchMapKeyValue(_AZToBacon[false]!);

  var out = input.toUpperCase().split('').map((character) {
    var bacon = _AZToBacon[original]?[character];
    return bacon ?? '';
  }).join();

  if (inverse) out = _inverseString(out);

  if (binary) {
    out = substitution(out, {'A': '0', 'B': '1'});
  }

  return out;
}

String decodeBacon(String input, bool invers, bool binary, bool original) {
  if (input.isEmpty) return '';
// I has same code as J, so I replaces J in mapping; J will not occur in this map
// U has same code as V, so U replaces V in mapping; V will not occur in this map
  _BaconToAZ[true] = switchMapKeyValue(_AZToBacon[true]!);
  _BaconToAZ[false] = switchMapKeyValue(_AZToBacon[false]!);

  if (binary) {
    input = input.toUpperCase().replaceAll(RegExp('[A-B]'), '');
    input = substitution(input, {'0': 'A', '1': 'B'});
  }

  input = input.toUpperCase().replaceAll(RegExp(r'[^A-B]'), '');
  if (invers) input = _inverseString(input);

  input = input.substring(0, input.length - (input.length % 5));

  var out = '';
  int i = 0;
  while (i < input.length) {
    out += _BaconToAZ[original]?[input.substring(i, i + 5)] ?? '';
    i += 5;
  }

  return out;
}

String _inverseString(String text) {
  return substitution(text, {'A': 'B', 'B': 'A'});
}
