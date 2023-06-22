// https://practice.nationalcybercup.org/cryptography/avemaria
// https://en.wikipedia.org/wiki/Polygraphia_(book)
// https://books.google.de/books?id=fQdCAAAAcAAJ&pg=PP1&redir_esc=y#v=onepage&q&f=false
// http://www.esotericarchives.com/tritheim/stegano.htm
// https://www.dcode.fr/trithemius-ave-maria

import 'dart:math';

Map<String, List<String>> _AVE_MARIA_ENCODE = {
  'A': ['deus', 'clemens'],
  'B': ['creator', 'clementissimus'],
  'C': ['conditor', 'pius'],
  'D': ['opifex', 'piissimus'],
  'E': ['dominus', 'magnus'],
  'F': ['dominator', 'excelsus'],
  'G': ['consolator', 'maximus'],
  'H': ['arbiter', 'optimus'],
  'I': ['iudex', 'sapientissimus'],
  'J': ['iudex', 'sapientissimus'],
  'K': ['illuminator', 'inuisibilis'],
  'L': ['illustrator', 'immortalis'],
  'M': ['rector', 'aeternus'],
  'N': ['rex', 'sempiternus'],
  'O': ['imperator', 'gloriosus'],
  'P': ['gubernator', 'fortissimus'],
  'Q': ['factor', 'sanctissimus'],
  'R': ['fabricator', 'incompraehensibilis'],
  'S': ['conseruator', 'omnipotens'],
  'T': ['redemptor', 'pacificus'],
  'U': ['auctor', 'misericors'],
  'V': ['auctor', 'misericors'],
  'W': ['auctor', 'misericors'],
  'X': ['princeps', 'misericordissimus'],
  'Y': ['pastor', 'conctipotens'],
  'Z': ['moderator', 'magnificus'],
};
Map<String, String> _AVE_MARIA_DECODE = {
  'deus': 'A',
  'clemens': 'A',
  'creator': 'B',
  'clementissimus': 'B',
  'conditor': 'C',
  'pius': 'C',
  'piissimus': 'D',
  'opifex': 'D',
  'magnus': 'E',
  'dominus': 'E',
  'excelsus': 'F',
  'dominator': 'F',
  'maximus': 'G',
  'consolator': 'G',
  'arbiter': 'H',
  'optimus': 'H',
  'iudex': 'I',
  'sapientissimus': 'I',
  'illuminator': 'K',
  'inuisibilis': 'K',
  'illustrator': 'L',
  'immortalis': 'L',
  'rector': 'M',
  'aeternus': 'M',
  'rex': 'N',
  'sempiternus': 'N',
  'imperator': 'O',
  'gloriosus': 'O',
  'gubernator': 'P',
  'fortissimus': 'P',
  'factor': 'Q',
  'sanctissimus': 'Q',
  'fabricator': 'R',
  'incompraehensibilis': 'R',
  'conseruator': 'S',
  'omnipotens': 'S',
  'redemptor': 'T',
  'pacificus': 'T',
  'auctor': 'U',
  'misericors': 'U',
  'princeps': 'X',
  'misericordissimus': 'X',
  'pastor': 'Y',
  'conctipotens': 'Y',
  'moderator': 'Z',
  'magnificus': 'Z',
};

String decodeAveMaria(String chiffre) {
  List<String> result = [];
  List<String> code = chiffre.toLowerCase().split('  ');

  code.forEach((word) {
    word.split(' ').forEach((letter) {
      if (_AVE_MARIA_DECODE[letter] == null) {
        result.add(' ');
      } else {
        result.add(_AVE_MARIA_DECODE[letter]!);
      }
    });
  });
  return result.join('');
}

String encodeAveMaria(String plain) {
  List<String> result = [];
  plain.toUpperCase().split('').forEach((element) {
    if (element == ' ') {
      result.add(' ');
    } else {
      result.add(_AVE_MARIA_ENCODE[element]![Random().nextInt(2)]);
    }
  });
  return result.join(' ');
}