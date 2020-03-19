const AZToBacon = {
  'A' : 'AAAAA', 'B' : 'AAAAB', 'C' : 'AAABA', 'D' : 'AAABB', 'E' : 'AABAA', 'F' : 'AABAB', 'G' : 'AABBA', 'H' : 'AABBB', 'J' : 'ABAAA', 'I' : 'ABAAA', 'K' : 'ABAAB', 'L' : 'ABABA', 'M' : 'ABABB',
  'N' : 'ABBAA', 'O' : 'ABBAB', 'P' : 'ABBBA', 'Q' : 'ABBBB', 'R' : 'BAAAA', 'S' : 'BAAAB', 'T' : 'BAABA', 'V' : 'BAABB', 'U' : 'BAABB', 'W' : 'BABAA', 'X' : 'BABAB', 'Y' : 'BABBA', 'Z' : 'BABBB',
};

// I has same code as J, so I replaces J in mapping; J will not occur in this map
// U has same code as V, so U replaces V in mapping; V will not occur in this map
final BaconToAZ = AZToBacon.map((k, v) => MapEntry(v, k));

String encodeBacon(String input) {
  if (input == null || input == '')
    return '';

  return input
      .toUpperCase()
      .split('')
      .map((character) {
        var bacon = AZToBacon[character];
        return bacon != null ? bacon : '';
      })
      .join();
}

String decodeBacon(String input) {
  if (input == null || input == '')
    return '';

  input = input.toUpperCase().replaceAll(RegExp(r'[^A-B]'), '');
  input = input.substring(0, input.length - (input.length % 5));

  var out = '';
  int i = 0;
  while (i < input.length) {
    out += BaconToAZ[input.substring(i, i + 5)];
    i += 5;
  }

  return out;
}