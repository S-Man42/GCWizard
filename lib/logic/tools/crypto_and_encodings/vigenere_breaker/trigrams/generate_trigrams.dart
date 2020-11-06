import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/trigrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/vigenere_breaker.dart';
import 'package:path/path.dart' as path;

 //main() {
//   generate_trigram();
// }
/// https://www.guballa.de/implementierung-eines-vigenere-solvers
/// Link for trigram files (for other languages)
/// http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/

/// method to generate then trigrams files from a text file
bool generate_trigram() {
  var result = true;

  List<Map<String, dynamic>> _inputsToExpected = [

    // Attention: a file is done during execution

    /// generate English-trigrams- file ( Source file from http://practicalcryptography.com/media/cryptanalysis/files/english_trigrams.txt.zip -> english_trigrams.txt)
    //{'input' : 'english_trigrams.txt', 'fileOut' : 'english_trigrams.dart', 'className' : 'EnglishTrigrams', 'replacementList' : null, 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate German trigrams file (Source file from http://practicalcryptography.com/media/cryptanalysis/files/german_trigrams.txt.zip -> german_trigrams.txt)
    //{'input' : 'german_trigrams.txt', 'fileOut' : 'german_trigrams.dart', 'className' : 'GermanTrigrams', 'replacementList' : {'ä': 'ae', 'ö': 'oe', 'ü': 'ue', 'ß': 'ss'}, 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate France trigrams file (Source file from http://practicalcryptography.com/media/cryptanalysis/files/french_trigrams.txt)
    //{'input' : 'french_trigrams.txt', 'fileOut' : 'french_trigrams.dart', 'className' : 'FrenchTrigrams', 'replacementList' : {'æ': 'ae', 'à': 'a' , 'â': 'a', 'ç': 'c', 'è': 'e', 'é': 'e', 'ë': 'e', 'ê': 'e', 'î': 'i', 'ï': 'i', 'ô': 'o', 'œ': 'oe', 'ü': 'ue', 'û': 'u', 'ù': 'u', 'ÿ': 'ye', 'û': 'u'}, 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate Polish trigrams file (Source file from http://practicalcryptography.com/media/cryptanalysis/files/polish_trigrams.txt)
    //{'input' : 'polish_trigrams.txt', 'fileOut' : 'polish_trigrams.dart', 'className' : 'PolishTrigrams', 'replacementList' : null, 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate Spanish trigrams file (Source file from http://practicalcryptography.com/media/cryptanalysis/files/spanish_trigrams.txt)
    //{'input' : 'spanish_trigrams.txt', 'fileOut' : 'spanish_trigrams.dart', 'className' : 'SpanishTrigrams', 'replacementList' : {'ñ': 'n'}, 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
  ];

  _inputsToExpected.forEach((elem) async {
    var filePath = path.current + "/lib/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/";
    var fileIn = File(path.normalize(filePath + elem['input']));
    var fileOut = File(path.normalize(filePath + elem['fileOut']));

    var _actual = await generateTrigrams(fileIn, fileOut,  elem['className'], elem['alphabet'], elem['replacementList']);

    result = result && (_actual.errorCode == VigenereBreakerErrorCode.OK);
  });

  return result;
}

Future<VigenereBreakerResult> generateTrigrams(File source_fh, File trigrams_fh, String className, String alphabet, Map<String, String> replacementList) async {

  alphabet = alphabet.toLowerCase();

  var list = _fillSourceList(source_fh);
  list = _replaceTrigramEntrys(list, alphabet, replacementList);
  var trigrams = _fillTrigramList(list, alphabet);
  trigrams = _scaleTrigrams(trigrams);

  return _generateFile(trigrams_fh, className, alphabet, replacementList, trigrams);
}

VigenereBreakerResult _generateFile(File trigrams_fh, String className, String alphabet,  Map<String, String> replacementList, List<int> trigrams) {
  var sb = new StringBuffer();
  var replacementListString = "null";
  var first = true;
  if (replacementList != null && replacementList.length > 0){
    var sb = new StringBuffer();
    sb.write("{");
    replacementList.forEach((key, value) {
      if (first) first = false;
      else sb.write(',');
      sb.write("'" + key + "': '" + value +"'");
    });
    sb.write("}");
    replacementListString = sb.toString();
  }

  sb.write("import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/trigrams/trigrams.dart';\n");
  sb.write("\n");
  sb.write("class " + className + " extends Trigrams {\n");
  sb.write("\n");
  sb.write("  " + className + "() {\n");
  sb.write("\n");
  sb.write("    alphabet = '" + alphabet + "';\n");
  sb.write("    replacementList = " + replacementListString + ";\n");;
  sb.write("    trigramsCompressed = " + Trigrams.trigramsMapToString(Quadgrams.compressQuadgrams(trigrams)) + ";\n");
  sb.write("  }\n");
  sb.write("}\n");

  trigrams_fh.writeAsStringSync(sb.toString());

  if (trigrams == null || trigrams.length == 0)
    return VigenereBreakerResult(alphabet: alphabet, errorCode: VigenereBreakerErrorCode.WRONG_GENERATE_TEXT);
  else
    return VigenereBreakerResult(alphabet: alphabet, errorCode: VigenereBreakerErrorCode.OK);
}


Map<String, int> _fillSourceList(File source_fh) {
  var list = Map<String, int>();
  String text = source_fh.readAsStringSync();

  RegExp regExp = new RegExp(r"(\S\S\S)(\s)([0-9]*)");
  Iterable<Match> matches = regExp.allMatches(text);
  for (Match match in matches) {
    list.addAll({match.group(1).toLowerCase() : int.tryParse(match.group(3))});
  }
  return list;
}

Map<String, int> _replaceTrigramEntrys(Map<String, int> trigramsSource, String alphabet, Map<String, String> replacementList) {
  if (replacementList == null || replacementList.length == 0)
    return trigramsSource;

  for (var i = trigramsSource.length -1; i >= 0; i--) {
    if (replacementList.keys.contains(trigramsSource.keys.elementAt(i)[0]) || replacementList.keys.contains(trigramsSource.keys.elementAt(i)[1]) || replacementList.keys.contains(trigramsSource.keys.elementAt(i)[2])) {
      var entry = substitution(trigramsSource.keys.elementAt(i), replacementList);
      var lastKey = '';
      for (var x = 0; x < entry.length - 2; x++) {
        var key = entry[x] + entry[x+1] + entry[x+2];
        if (trigramsSource.containsKey(key)) {
          if (lastKey != key)
            trigramsSource[key] += trigramsSource.values.elementAt(i);
          lastKey = key;
        }
        else
          print("Error generate trigram: " + entry + " ->" + key +' (missing key)');
      }
      trigramsSource.remove(trigramsSource.keys.elementAt(i));
    }
  }
  return trigramsSource;
}

List<int> _fillTrigramList(Map<String, int> trigramsSource, String alphabet) {
  var trigram_val = 0;
  var trigrams = List<int>(pow(Trigrams.maxAlphabetLength, 3)*Trigrams.maxAlphabetLength);
  trigrams.fillRange(0, trigrams.length , 0);

  trigramsSource.forEach((key, value) {
    trigram_val    = _charIndex(key[0], alphabet);
    trigram_val = (trigram_val << 5) + _charIndex(key[1], alphabet);
    trigram_val = ((trigram_val & 0x3FF) << 5) + _charIndex(key[2], alphabet);

    trigrams[trigram_val] += value;
  });
  return trigrams;
}

List<int> _scaleTrigrams(List<int> trigrams) {
  const int maximum = 1000000;
  var minValue = maximum;
  var maxValue = 0;
  var sum = 0;

  for (var row = 0; row < trigrams.length; row++) {
    if (trigrams[row] == 0)
      trigrams[row] = 1;

    maxValue = max(maxValue, trigrams[row]);
    minValue = min(minValue, trigrams[row]);
    sum += trigrams[row];
  };

  var minValueD = log(minValue / sum);
  var maxValueD = log(maxValue / sum);
  var scale =  maximum  / (maxValueD - minValueD);

  for (var row = 0; row < trigrams.length; row++) {
    trigrams[row] = ((log(trigrams[row] / sum) - minValueD) * scale).floor();
  }
  return trigrams;
}

int _charIndex(String char, String alphabet) {
  int index = -1;

  char = char[0].toLowerCase();
  index = alphabet.indexOf(char);
  if (index >= 0)
    return index;
  else
    return -1;
}
