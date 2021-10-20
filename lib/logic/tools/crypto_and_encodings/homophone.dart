import 'dart:math';

class HomophoneOutput {
  final String output;
  final String grid;
  final ErrorCode errorCode;

  HomophoneOutput(this.output, this.grid, this.errorCode);
}

enum KeyType { OWN1, OWN2, GENERATED }
enum Alphabet {
  alphabetGerman1,
  alphabetEnglish1,
  alphabetSpanish2,
  alphabetPolish1,
  alphabetGreek1,
  alphabetGreek2,
  alphabetRussian1
}
enum ErrorCode { OK, TABLE, OWNKEYCOUNT, OWNDOUBLEKEY }

final letterFrequencyAlphabetGerman1 = {
  'A': 6,
  'B': 2,
  'C': 2,
  'D': 5,
  'E': 17,
  'F': 2,
  'G': 3,
  'H': 5,
  'I': 8,
  'J': 1,
  'K': 1,
  'L': 3,
  'M': 2,
  'N': 10,
  'O': 2,
  'P': 1,
  'Q': 1,
  'R': 7,
  'S': 7,
  'T': 6,
  'U': 4,
  'V': 1,
  'W': 1,
  'X': 1,
  'Y': 1,
  'Z': 1
};
final letterFrequencyAlphabetEnglish1 = {
  'A': 8,
  'B': 2,
  'C': 3,
  'D': 4,
  'E': 12,
  'F': 2,
  'G': 2,
  'H': 6,
  'I': 6,
  'J': 1,
  'K': 1,
  'L': 4,
  'M': 2,
  'N': 6,
  'O': 7,
  'P': 2,
  'Q': 1,
  'R': 6,
  'S': 6,
  'T': 9,
  'U': 3,
  'V': 1,
  'W': 2,
  'X': 1,
  'Y': 2,
  'Z': 1
};
final letterFrequencyAlphabetSpanish2 = {
  'A': 12,
  'B': 1,
  'C': 4,
  'D': 5,
  'E': 13,
  'F': 1,
  'G': 1,
  'H': 1,
  'I': 6,
  'J': 1,
  'K': 1,
  'L': 5,
  'M': 3,
  'N': 6,
  'Ñ': 1,
  'O': 8,
  'P': 2,
  'Q': 1,
  'R': 7,
  'S': 8,
  'T': 4,
  'U': 4,
  'V': 1,
  'W': 1,
  'X': 1,
  'Y': 1,
  'Z': 1
};
final letterFrequencyAlphabetRussian1 = {
  'А': 7,
  'Б': 2,
  'В': 4,
  'Г': 1,
  'Д': 3,
  'Е': 9,
  'Ё': 1,
  'Ж': 1,
  'З': 1,
  'И': 7,
  'Й': 1,
  'К': 3,
  'Л': 5,
  'М': 3,
  'Н': 7,
  'О': 11,
  'П': 2,
  'Р': 4,
  'С': 5,
  'Т': 6,
  'У': 2,
  'Ф': 1,
  'Х': 1,
  'Ц': 1,
  'Ч': 1,
  'Ш': 1,
  'Щ': 1,
  'Ъ': 1,
  'Ы': 2,
  'Ь': 2,
  'Э': 1,
  'Ю': 1,
  'Я': 2
};
final letterFrequencyAlphabetPolish1 = {
  'A': 8,
  'Ą': 1,
  'B': 2,
  'C': 4,
  'Ć': 1,
  'D': 3,
  'E': 8,
  'Ę': 1,
  'F': 1,
  'G': 1,
  'H': 1,
  'I': 9,
  'J': 2,
  'K': 3,
  'L': 2,
  'Ł': 2,
  'M': 3,
  'N': 6,
  'Ń': 1,
  'O': 7,
  'Ó': 1,
  'P': 3,
  'R': 4,
  'S': 4,
  'Ś': 1,
  'T': 4,
  'U': 2,
  'W': 4,
  'Y': 4,
  'Z': 5,
  'Ź': 1,
  'Ż': 1
};
final letterFrequencyAlphabetGreek1 = {
  'Α': 13,
  'Β': 1,
  'Γ': 2,
  'Δ': 2,
  'Ε': 9,
  'Ζ': 1,
  'Η': 5,
  'Θ': 1,
  'Ι': 9,
  'Κ': 4,
  'Λ': 2,
  'Μ': 3,
  'Ν': 6,
  'Ξ': 1,
  'Ο': 9,
  'Π': 4,
  'Ρ': 4,
  'Σ': 7,
  'Τ': 8,
  'Υ': 4,
  'Φ': 1,
  'Χ': 1,
  'Ψ': 1,
  'Ω': 2
};
final letterFrequencyAlphabetGreek2 = {
  'Ά': 2,
  'Α': 11,
  'Β': 1,
  'Γ': 2,
  'Δ': 2,
  'Ε': 7,
  'Έ': 2,
  'Ζ': 1,
  'Η': 3,
  'Ή': 2,
  'Θ': 1,
  'Ι': 7,
  'Ί': 2,
  'Κ': 4,
  'Λ': 2,
  'Μ': 3,
  'Ν': 6,
  'Ξ': 1,
  'Ο': 7,
  'Ό': 2,
  'Π': 4,
  'Ρ': 4,
  'Σ': 7,
  'Τ': 8,
  'Υ': 3,
  'Ύ': 1,
  'Φ': 1,
  'Χ': 1,
  'Ψ': 1,
  'Ω': 1,
  'Ώ': 1
};

HomophoneOutput encryptHomophone(
    String input, KeyType keyType, Alphabet alphabet, int rotation, int multiplier, String own1Keys, Map<String, String> own2Map) {
  if (input == null || input == '') return HomophoneOutput('', '', ErrorCode.OK);

  var output = "";
  Map<String, List<int>> table;
  List<int> ownKeyList;
  var errorCode = ErrorCode.OK;

  if (keyType == KeyType.OWN1) {
    ownKeyList = _ownKeyList(own1Keys, checkKeyLength: 100);
    if (ownKeyList == null) return HomophoneOutput('', '', ErrorCode.OWNKEYCOUNT);

    if (ownKeyList.length != ownKeyList.toSet().length ) errorCode = ErrorCode.OWNDOUBLEKEY;
  }

  table = _getTable(alphabet, keyType, rotation, multiplier, ownKeyList, own2Map);

  if (table == null) return HomophoneOutput('', '', ErrorCode.TABLE);

  input = input.toUpperCase();
  input = input.split("").map((character) => table.containsKey(character) ? character : '').join();

  output = input
      .toUpperCase()
      .split("")
      .map((character) => _charToNumber(character, table).toString().padLeft(2, '0'))
      .join(" ");

  return HomophoneOutput(output, _tableToString(table), errorCode);
}

HomophoneOutput decryptHomophone(
    String input, KeyType keyType, Alphabet alphabet, int rotation, int multiplier, String ownKeys, Map<String, String> own2Map) {
  if (input == null || input == '') return HomophoneOutput('', '', ErrorCode.OK);

  var output = "";
  Map<String, List<int>> table;
  List<int> ownKeyList;

  if (keyType == KeyType.OWN1) {
    ownKeyList = _ownKeyList(ownKeys, checkKeyLength: 100);
    if (ownKeyList == null) return HomophoneOutput('', '', ErrorCode.OWNKEYCOUNT);
  }

  table = _getTable(alphabet, keyType, rotation, multiplier, ownKeyList, own2Map);

  if (table == null) return HomophoneOutput('', '', ErrorCode.TABLE);

  output = input.split(" ").map((number) {
    return _numberToChar(number, table);
  }).join();

  return HomophoneOutput(output, _tableToString(table), ErrorCode.OK);
}

List<int> getMultipliers() {
  var multipliers = <int>[];

  for (int i = 1; i <= 99; i += 2) multipliers.add(i);

  for (int i = 5; i < 99; i += 10) multipliers.remove(i);

  return multipliers;
}

List<int> _ownKeyList(String ownKeys, {int checkKeyLength }) {
  List<int> ownKeysList = <int>[];

  RegExp regExp = new RegExp("[0-9]{1,}");
  regExp.allMatches(ownKeys).forEach((elem) {
    ownKeysList.add(int.tryParse(ownKeys.substring(elem.start, elem.end)));
  });
  if ((checkKeyLength != null) && (ownKeysList.length != checkKeyLength)) return null;

  return ownKeysList;
}
Map<String, int> getAlphabetTable(Alphabet alphabet)  {

  switch (alphabet) {
    case Alphabet.alphabetGerman1:
      return letterFrequencyAlphabetGerman1;
      break;
    case Alphabet.alphabetEnglish1:
      return letterFrequencyAlphabetEnglish1;
      break;
    case Alphabet.alphabetSpanish2:
      return letterFrequencyAlphabetSpanish2;
      break;
    case Alphabet.alphabetPolish1:
      return letterFrequencyAlphabetPolish1;
      break;
    case Alphabet.alphabetGreek1:
      return letterFrequencyAlphabetGreek1;
      break;
    case Alphabet.alphabetGreek2:
      return letterFrequencyAlphabetGreek2;
      break;
    case Alphabet.alphabetRussian1:
      return letterFrequencyAlphabetRussian1;
      break;
  }

  return null;
}

Map<String, List<int>> _getTable(
    Alphabet alphabet, KeyType keyType, int rotation, int multiplier, List<int> ownKeyList, Map<String, String> own2Map) {
  Map<String, int> languageTable = getAlphabetTable(alphabet);

  if (languageTable == null && keyType != KeyType.OWN2) return null;

  return _createTable(languageTable, keyType, rotation, multiplier, ownKeyList, own2Map);
}

int _charToNumber(String character, Map<String, List<int>> table) {
  if (table.containsKey(character)) {
    var list = table[character];
    if (list.length == 0) return -1;
    var rnd = new Random();
    var index = rnd.nextInt(list.length);

    return list[index];
  }
  return -1;
}

String _numberToChar(String numberString, Map<String, List<int>> table) {
  var number = int.tryParse(numberString);
  var output;

  if (number == null) return '';

  table.forEach((key, numbers) {
    if (numbers.contains(number)) {
      output = key;
      return;
    }
  });
  return output;
}

Map<String, List<int>> _createTable(
    Map<String, int> letterFrequency, KeyType keyType, int rotation, int multiplier, List<int> ownKeyList, Map<String, String> own2Map) {
  var table = Map<String, List<int>>();
  var counter = 0;

  if (keyType == KeyType.GENERATED) {
    counter = rotation * multiplier;

    letterFrequency.forEach((key, value) {
      table.addAll({key: <int>[]});
      for (int f = 0; f < value; f++) {
        table[key].add(counter % 100);
        counter += multiplier;
      }
    });
  } else if (keyType == KeyType.OWN1) {
    letterFrequency.forEach((key, value) {
      table.addAll({key: <int>[]});
      for (int f = 0; f < value; f++) {
        table[key].add(ownKeyList[counter]);
        counter += 1;
      }
    });
  } else if (keyType == KeyType.OWN2) {
    if (own2Map != null) {
      own2Map.forEach((key, value) {
        table.addAll({key: _ownKeyList(value)});
      });
    }
  }
  return table;
}

String _tableToString(Map<String, List<int>> table) {
  var output = "";
  table.forEach((key, value) {
    output += key + " = ";
    value.forEach((item) {
      output += item.toString().padLeft(2, '0') + " ";
    });
    output = output.trim();
    output += "\n";
  });

  return output;
}
