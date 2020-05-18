import 'package:gc_wizard/utils/common_utils.dart';

const alphabet_09 = {'0' : 0, '1' : 1, '2' : 2, '3' : 3, '4' : 4, '5' : 5, '6' : 6, '7' : 7, '8' : 8, '9' : 9};
final alphabet_09Indexes = switchMapKeyValue(alphabet_09);

const alphabet_AZ = {
  'A' : 1, 'B' : 2, 'C' : 3, 'D' : 4, 'E' : 5, 'F' : 6, 'G' : 7, 'H' : 8, 'I' : 9, 'J' : 10, 'K' : 11, 'L' : 12, 'M' : 13,
  'N' : 14, 'O' : 15, 'P' : 16, 'Q' : 17, 'R' : 18, 'S' : 19, 'T' : 20, 'U' : 21, 'V' : 22, 'W' : 23, 'X' : 24, 'Y' : 25, 'Z' : 26,
};
final alphabet_AZIndexes = switchMapKeyValue(alphabet_AZ);
final alphabet_AZString = alphabet_AZ.keys.join();

final superscriptCharacters = {
    '0' : '\u2070',
    '1' : '\u00B9',
    '2' : '\u00B2',
    '3' : '\u00B3',
    '4' : '\u2074',
    '5' : '\u2075',
    '6' : '\u2076',
    '7' : '\u2077',
    '8' : '\u2078',
    '9' : '\u2079',
    'a' : '\u1d43',
    'b' : '\u1d47',
    'c' : '\u1d9c',
    'd' : '\u1d48',
    'e' : '\u1d49',
    'f' : '\u1da0',
    'g' : '\u1d4d',
    'h' : '\u02b0',
    'i' : '\u2071',
    'j' : '\u02b2',
    'k' : '\u1d4f',
    'l' : '\u02e1',
    'm' : '\u1d50',
    'n' : '\u207f',
    'o' : '\u1d52',
    'p' : '\u1d56',
    //    'q' : missing in Unicode
    'r' : '\u02b3',
    's' : '\u02e2',
    't' : '\u1d57',
    'u' : '\u1d58',
    'v' : '\u1d5b',
    'w' : '\u02b7',
    'x' : '\u02e3',
    'y' : '\u02b8',
    'z' : '\u1dbb',
    'A' : '\u1d2c',
    'B' : '\u1d2e',
    //    'C' : missing in Unicode
    'D' : '\u1d30',
    'E' : '\u1d31',
    //    'F' : missing in Unicode
    'G' : '\u1d33',
    'H' : '\u1d34',
    'I' : '\u1d35',
    'J' : '\u1d36',
    'K' : '\u1d37',
    'L' : '\u1d38',
    'M' : '\u1d39',
    'N' : '\u1d3a',
    'O' : '\u1d3c',
    'P' : '\u1d3e',
    //    'Q' : missing in Unicode
    'R' : '\u1d3f',
    //    'S' : missing in Unicode
    'T' : '\u1d40',
    'U' : '\u1d41',
    'V' : '\u2c7d',
    'W' : '\u1d42',
    //    'X' : missing in Unicode
    //    'Y' : missing in Unicode
    //    'Z' : missing in Unicode
    '+' : '\u207A',
    '-' : '\u207B',
    '=' : '\u207C',
    '(' : '\u207D',
    ')' : '\u207E',
};

final subscriptCharacters = {
    '0' : '\u2080',
    '1' : '\u2081',
    '2' : '\u2082',
    '3' : '\u2083',
    '4' : '\u2084',
    '5' : '\u2085',
    '6' : '\u2086',
    '7' : '\u2087',
    '8' : '\u2088',
    '9' : '\u2089',
    'a' : '\u2090',
//    'b' : missing in Unicode,
//    'c' : missing in Unicode,
//    'd' : missing in Unicode,
    'e' : '\u2091',
//    'f' : missing in Unicode,
//    'g' : missing in Unicode,
    'h' : '\u2095',
    'i' : '\u1d62',
    'j' : '\u2c7c',
    'k' : '\u2096',
    'l' : '\u2097',
    'm' : '\u2098',
    'n' : '\u2099',
    'o' : '\u2092',
    'p' : '\u209a',
//    'q' : missing in Unicode,
    'r' : '\u1d63',
    's' : '\u209b',
    't' : '\u209c',
    'u' : '\u1d64',
    'v' : '\u1d65',
//    'w' : missing in Unicode,
    'x' : '\u2093',
//    'y' : missing in Unicode,
//    'z' : missing in Unicode,
//    'A' : missing in Unicode,
//    'B' : missing in Unicode,
//    'C' : missing in Unicode,
//    'D' : missing in Unicode,
//    'E' : missing in Unicode,
//    'F' : missing in Unicode,
//    'G' : missing in Unicode,
//    'H' : missing in Unicode,
//    'I' : missing in Unicode,
//    'J' : missing in Unicode,
//    'K' : missing in Unicode,
//    'L' : missing in Unicode,
//    'M' : missing in Unicode,
//    'N' : missing in Unicode,
//    'O' : missing in Unicode,
//    'P' : missing in Unicode,
//    'Q' : missing in Unicode,
//    'R' : missing in Unicode,
//    'S' : missing in Unicode,
//    'T' : missing in Unicode,
//    'U' : missing in Unicode,
//    'V' : missing in Unicode,
//    'W' : missing in Unicode,
//    'X' : missing in Unicode,
//    'Y' : missing in Unicode,
//    'Z' : missing in Unicode,
    '+' : '\u208A',
    '-' : '\u208B',
    '=' : '\u208C',
    '(' : '\u208D',
    ')' : '\u208E',
};

class Alphabet {
  final String key;
  final Map<String, String> alphabet;

  const Alphabet([this.key, this.alphabet]);
}

final Alphabet alphabetAZ = Alphabet(
  'alphabet_name_az',
  alphabet_AZ.map((key, value) => MapEntry(key, value.toString()))
);

final Alphabet alphabetGerman1 = Alphabet(
  'alphabet_name_german1',
  {
    'A' : '1', 'B' : '2', 'C' : '3', 'D' : '4', 'E' : '5', 'F' : '6', 'G' : '7', 'H' : '8', 'I' : '9', 'J' : '10', 'K' : '11', 'L' : '12', 'M' : '13',
    'N' : '14', 'O' : '15', 'P' : '16', 'Q' : '17', 'R' : '18', 'S' : '19', 'T' : '20', 'U' : '21', 'V' : '22', 'W' : '23', 'X' : '24', 'Y' : '25', 'Z' : '26',
    String.fromCharCode(196) : '27', // Ä,
    String.fromCharCode(214) : '28', // Ö,
    String.fromCharCode(220) : '29', // Ü,
    String.fromCharCode(223) : '30', // ß,
    String.fromCharCode(7838) : '30', // ẞ
  }
);

final Alphabet alphabetGerman2 = Alphabet(
  'alphabet_name_german2',
  {
    'A' : '1', 'B' : '2', 'C' : '3', 'D' : '4', 'E' : '5', 'F' : '6', 'G' : '7', 'H' : '8', 'I' : '9', 'J' : '10', 'K' : '11', 'L' : '12', 'M' : '13',
    'N' : '14', 'O' : '15', 'P' : '16', 'Q' : '17', 'R' : '18', 'S' : '19', 'T' : '20', 'U' : '21', 'V' : '22', 'W' : '23', 'X' : '24', 'Y' : '25', 'Z' : '26',
    String.fromCharCode(196) : '1,5', // Ä,
    String.fromCharCode(214) : '15,5', // Ö,
    String.fromCharCode(220) : '21,5', // Ü,
    String.fromCharCode(223) : '19,19', // ß,
    String.fromCharCode(7838) : '19,19', // ẞ
  }
);

final Alphabet alphabetGerman3 = Alphabet(
  'alphabet_name_german3',
  {
      'A' : '1', 'B' : '2', 'C' : '3', 'D' : '4', 'E' : '5', 'F' : '6', 'G' : '7', 'H' : '8', 'I' : '9', 'J' : '10', 'K' : '11', 'L' : '12', 'M' : '13',
      'N' : '14', 'O' : '15', 'P' : '16', 'Q' : '17', 'R' : '18', 'S' : '19', 'T' : '20', 'U' : '21', 'V' : '22', 'W' : '23', 'X' : '24', 'Y' : '25', 'Z' : '26',
      String.fromCharCode(196) : '6', // Ä,
      String.fromCharCode(214) : '20', // Ö,
      String.fromCharCode(220) : '26', // Ü,
      String.fromCharCode(223) : '38', // ß,
      String.fromCharCode(7838) : '38', // ẞ
  }
);

final Alphabet alphabetSpanish1 = Alphabet(
  'alphabet_name_spanish1',
  {
    'A' : '1', 'B' : '2', 'C' : '3', 'CH' : '4', 'D' : '5', 'E' : '6', 'F' : '7', 'G' : '8', 'H' : '9', 'I' : '10', 'J' : '11', 'K' : '12', 'L' : '13',
    'LL' : '14', 'M' : '15', 'N' : '16',
    String.fromCharCode(209) : '17', // Ñ,
    'O' : '18', 'P' : '19', 'Q' : '20', 'R' : '21', 'S' : '22', 'T' : '23', 'U' : '24', 'V' : '25', 'W' : '26', 'X' : '27', 'Y' : '28', 'Z' : '29'
  }
);

final Alphabet alphabetSpanish2 = Alphabet(
  'alphabet_name_spanish2',
  {
    'A' : '1', 'B' : '2', 'C' : '3', 'D' : '4', 'E' : '5', 'F' : '6', 'G' : '7', 'H' : '8', 'I' : '9', 'J' : '10', 'K' : '11', 'L' : '12', 'M' : '13', 'N' : '14',
    String.fromCharCode(209) : '15', // Ñ,
    'O' : '16', 'P' : '17', 'Q' : '18', 'R' : '19', 'S' : '20', 'T' : '21', 'U' : '22', 'V' : '23', 'W' : '24', 'X' : '25', 'Y' : '26', 'Z' : '27'
  }
);

final Alphabet alphabetPolish1 = Alphabet(
  'alphabet_name_polish1',
  {
    'A' : '1',
    String.fromCharCode(260) : '2', // Ą
    'B' : '3', 'C' : '4',
    String.fromCharCode(262) : '5', // Ć
    'D' : '6', 'E' : '7',
    String.fromCharCode(280) : '8', // Ę
    'F' : '9', 'G' : '10', 'H' : '11', 'I' : '12', 'J' : '13', 'K' : '14', 'L' : '15',
    String.fromCharCode(321) : '16', // Ł
    'M' : '17', 'N' : '18',
    String.fromCharCode(323) : '19', // Ń
    'O' : '20',
    String.fromCharCode(211) : '21', // Ó
    'P' : '22', 'R' : '23', 'S' : '24',
    String.fromCharCode(346) : '25', // Ś
    'T' : '26', 'U' : '27', 'W' : '28', 'Y' : '29', 'Z' : '30',
    String.fromCharCode(377) : '31', // Ź
    String.fromCharCode(379) : '32', // Ż
  }
);

final Alphabet alphabetGreek1 = Alphabet(
  'alphabet_name_greek1',
  {
    String.fromCharCode(913) : '1', // Α
    String.fromCharCode(914) : '2', // Β
    String.fromCharCode(915) : '3', // Γ
    String.fromCharCode(916) : '4', // Δ
    String.fromCharCode(917) : '5', // Ε
    String.fromCharCode(918) : '6', // Ζ
    String.fromCharCode(919) : '7', // Η
    String.fromCharCode(920) : '8', // Θ
    String.fromCharCode(921) : '9', // Ι
    String.fromCharCode(922) : '10', // Κ
    String.fromCharCode(923) : '11', // Λ
    String.fromCharCode(924) : '12', // Μ
    String.fromCharCode(925) : '13', // Ν
    String.fromCharCode(926) : '14', // Ξ
    String.fromCharCode(927) : '15', // Ο
    String.fromCharCode(928) : '16', // Π
    String.fromCharCode(929) : '17', // Ρ
    String.fromCharCode(931) : '18', // Σ
    String.fromCharCode(932) : '19', // Τ
    String.fromCharCode(933) : '20', // Υ
    String.fromCharCode(934) : '21', // Φ
    String.fromCharCode(935) : '22', // Χ
    String.fromCharCode(936) : '23', // Ψ
    String.fromCharCode(937) : '24', // Ω
  }
);

final Alphabet alphabetRussian1 = Alphabet(
  'alphabet_name_russian1',
  {
    String.fromCharCode(1040) : '1', // А
    String.fromCharCode(1041) : '2', // Б
    String.fromCharCode(1042) : '3', // В
    String.fromCharCode(1043) : '4', // Г
    String.fromCharCode(1044) : '5', // Д
    String.fromCharCode(1045) : '6', // Е
    String.fromCharCode(1025) : '7', // Ё
    String.fromCharCode(1046) : '8', // Ж
    String.fromCharCode(1047) : '9', // З
    String.fromCharCode(1048) : '10', // И
    String.fromCharCode(1049) : '11', // Й
    String.fromCharCode(1050) : '12', // К
    String.fromCharCode(1051) : '13', // Л
    String.fromCharCode(1052) : '14', // М
    String.fromCharCode(1053) : '15', // Н
    String.fromCharCode(1054) : '16', // О
    String.fromCharCode(1055) : '17', // П
    String.fromCharCode(1056) : '18', // Р
    String.fromCharCode(1057) : '19', // С
    String.fromCharCode(1058) : '20', // Т
    String.fromCharCode(1059) : '21', // У
    String.fromCharCode(1060) : '22', // Ф
    String.fromCharCode(1061) : '23', // Х
    String.fromCharCode(1062) : '24', // Ц
    String.fromCharCode(1063) : '25', // Ч
    String.fromCharCode(1064) : '26', // Ш
    String.fromCharCode(1065) : '27', // Щ
    String.fromCharCode(1066) : '28', // Ъ
    String.fromCharCode(1067) : '29', // Ы
    String.fromCharCode(1068) : '30', // Ь
    String.fromCharCode(1069) : '31', // Э
    String.fromCharCode(1070) : '32', // Ю
    String.fromCharCode(1071) : '33', // Я
  }
);