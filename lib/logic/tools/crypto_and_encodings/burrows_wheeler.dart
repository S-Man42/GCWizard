import 'package:gc_wizard/utils/common_utils.dart';

final Map DEdigitToString = {0 : 'null', 1 : 'eins', 2 : 'zwei', 3 : 'drei', 4 : 'vier', 5 : 'fuenf', 6 : 'sechs', 7 : 'sieben', 8 : 'acht', 9 : 'neun', };
final Map ENdigitToString = {0 : 'zero', 1 : 'one', 2 : 'two', 3 : 'three', 4 : 'four', 5 : 'five', 6 : 'six', 7 : 'seven', 8 : 'eight', 9 : 'nine', };

final Map DEStringToDigit = switchMapKeyValue(DEdigitToString);
final Map ENStringToDigit = switchMapKeyValue(ENdigitToString);

class BWTOutput {
  String text;
  String index;
  String compress;

  BWTOutput(this.text, this.index, this.compress);
}

BWTOutput encryptBurrowsWheeler(String plain, indexChar, bool compress, languageDEU) {
  if (plain == '' || plain == null)
    return BWTOutput('', '', '');

  var language;
  if (languageDEU)
    language = DEdigitToString;
  else
    language = ENdigitToString;

  if (compress){
    plain = plain
        .replaceAll('0', language[0])
        .replaceAll('1', language[1])
        .replaceAll('2', language[2])
        .replaceAll('3', language[3])
        .replaceAll('4', language[4])
        .replaceAll('5', language[5])
        .replaceAll('6', language[6])
        .replaceAll('7', language[7])
        .replaceAll('8', language[8])
        .replaceAll('9', language[9]);
  }
  int len = plain.length;
  List<String> matrix = new List<String>();
  String compressed = '';

  matrix.add(plain);
    for (int i= 0; i < len - 1; i++) {
      matrix.add(plain.substring(len - i - 1) + plain.substring(0, len - i - 1));
  }

  matrix.sort();

  String chiffre = '';
  int index = 0;
  for (int i = 0; i < len; i++){
    chiffre = chiffre + matrix[i].substring(len - 1);
    if (matrix[i] == plain)
      index = i;
  }

  if (int.tryParse(indexChar) == null)
    chiffre = chiffre.substring(0,index) + indexChar + chiffre.substring(index);
  else {
    index = index + 1;
    indexChar = index.toString();
  }

  if (compress) { // compress chiffre
    compressed = '';
    for (int i = 0; i < chiffre.length; i++){
      compressed = compressed + chiffre[i];
      int j = i + 1;
      int count = 1;
      while (j < chiffre.length && chiffre[j] == chiffre[i]) {
        j = j + 1;
        count = count + 1;
      }
      if (count > 1)
        compressed = compressed + (count - 1).toString();
      i = j - 1;
    }
  }
  return BWTOutput(chiffre, indexChar, compressed);
}


BWTOutput decryptBurrowsWheeler(String chiffre, indexChar, bool compress, languageDEU) {
  if (chiffre == '' || chiffre == null)
    return BWTOutput('', '', '');

  var language;
  if (languageDEU)
    language = DEdigitToString;
  else
    language = ENdigitToString;

  int count = 0;
  String decompressed = '';

  if (compress){ // decompress chiffre

    RegExp expr = new RegExp('[0-9]*');
    for (int i = 0; i < chiffre.length; i++){
      decompressed = decompressed + chiffre[i];
      String countString = chiffre.substring(i + 1);
      if (countString != ''){
        if (int.tryParse(countString[0]) != null) {
          count =  int.parse(expr.firstMatch(countString).group(0));
        for (int j = 1; j <= count; j++)
          decompressed = decompressed + chiffre[i];
        i = i + 1;
        }
      }
    }
    chiffre = decompressed;
  }

  int len = chiffre.length;
  int index = 0;
  String input = '';

  if (int.tryParse(indexChar) == null) { // index is encoded with a special symbol within the chiffre
    for (int  i = 0; i < len; i++){
      if (chiffre[i] != indexChar)
        input = input + chiffre[i];
      else
        index = i;
    }
    len = len - 1;
  } else {
    index = int.parse(indexChar) - 1;
    input = chiffre;
  }
  Map<int, List<String>> tabelle = new Map<int, List<String>>();

  for (int i = 0; i < len; i++){
    tabelle[i] = ([i.toString(), input[i]]);
  }

  for (int i = 0; i < len; i++) {
    for (int j = 0; j < len - 1; j++) {
      if (tabelle[j][1].compareTo(tabelle[j+1][1]) == 1) {
        var h = tabelle[j];
        tabelle[j] = tabelle[j + 1];
        tabelle[j + 1] = h;
      }
    }
  }

  String decodiert = '';
  for (int i = 0; i < len; i++){
    if (tabelle[index] != null) {
      decodiert = decodiert + tabelle[index][1];
      index = int.parse(tabelle[index][0]);
    }
  }

  if (compress)
    decodiert = decodiert
      .replaceAll(language[0], '0')
      .replaceAll(language[1], '1')
      .replaceAll(language[2], '2')
      .replaceAll(language[3], '3')
      .replaceAll(language[4], '4')
      .replaceAll(language[5], '5')
      .replaceAll(language[6], '6')
      .replaceAll(language[7], '7')
      .replaceAll(language[8], '8')
      .replaceAll(language[9], '9');

return BWTOutput(decodiert, indexChar, decompressed);
}
