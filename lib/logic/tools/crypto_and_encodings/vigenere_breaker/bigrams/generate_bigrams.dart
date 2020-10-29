import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/vigenere_breaker.dart';
import 'package:path/path.dart' as path;

 main() {
   generate_bigram();
 }

/// Link for bigram files (for other languages)
/// https://www.guballa.de/implementierung-eines-vigenere-solvers
/// http://practicalcryptography.com/cryptanalysis/letter-frequencies-various-languages/

/// method to generate then bigrams files from a text file
bool generate_bigram() {
  var result = true;

  List<Map<String, dynamic>> _inputsToExpected = [

    // Attention: a file is done during execution

    /// generate English-Bigrams- file ( Source file from http://practicalcryptography.com/media/cryptanalysis/files/english_bigrams.txt)
    {'input' : 'english_bigrams.txt', 'fileOut' : 'english_bigrams.dart', 'className' : 'EnglishBigrams', 'replacementList' : null, 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate German Bigrams file (Source file from http://practicalcryptography.com/media/cryptanalysis/files/german_bigrams.txt)
    {'input' : 'german_bigrams.txt', 'fileOut' : 'german_bigrams.dart', 'className' : 'GermanBigrams', 'replacementList' : {'ä': 'ae', 'ö': 'oe', 'ü': 'ue', 'ß': 'ss'}, 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate France Bigrams file (Source file from https://pcai056.informatik.uni-leipzig.de/downloads/corpora/fra_mixed_2009_1M.tar.gz -> fra_mixed_2009_1M-sentences.txt)
    //{'input' : 'fra_mixed_2009_1M-sentences.txt', 'fileOut' : 'france_bigrams.dart', 'className' : 'FranceBigrams', 'replacementList' : 'fr.json', 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate Russian Bigrams file (Source file from https://pcai056.informatik.uni-leipzig.de/downloads/corpora/rus_newscrawl-public_2018_1M.tar.gz -> rus_newscrawl-public_2018_1M-sentences.txt)
    //{'input' : 'rus_newscrawl-public_2018_1M-sentences.txt', 'fileOut' : 'russian_bigrams.dart', 'className' : 'RussianBigrams', 'replacementList' : 'ru.json', 'alphabet' : "абвгдежзиклмнопрстуфхцчшэюя", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate Polish quadgram file (Source file from https://pcai056.informatik.uni-leipzig.de/downloads/corpora/pol_newscrawl_2018_1M.tar.gz -> pol_newscrawl_2018_1M-sentences.txt)
    //{'input' : 'pol_newscrawl_2018_1M-sentences.txt', 'fileOut' : 'polish_bigrams.dart', 'className' : 'PolishBigrams', 'replacementList' : 'pl.json', 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate Spanish quadgram file (Source file from https://pcai056.informatik.uni-leipzig.de/downloads/corpora/spa_newscrawl_2015_1M.tar.gz -> spa_newscrawl_2015_1M-sentences.txt)
    //{'input' : 'spa_newscrawl_2015_1M-sentences.txt', 'fileOut' : 'spanish_bigrams.dart', 'className' : 'SpanishBigrams', 'replacementList' : 'es.json', 'alphabet' : "abcdefghijklmnopqrstuvwxyz", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
    /// generate Greek quadgram file (Source file from https://pcai056.informatik.uni-leipzig.de/downloads/corpora/ell_newscrawl_2017_1M.tar.gz -> ell_newscrawl_2017_1M-sentences.txt)
    //{'input' : 'ell_newscrawl_2017_1M-sentences.txt', 'fileOut' : 'greek_bigrams.dart', 'className' : 'GreekBigrams', 'replacementList' : 'gr.json', 'alphabet' : "αβγδεζηθικλμνξοπρστυφχψω", 'errorCode' : VigenereBreakerErrorCode.OK, 'expectedOutput' : ''},
  ];

  _inputsToExpected.forEach((elem) async {
    var filePath = path.current + "/lib/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/";
    var fileIn = File(path.normalize(filePath + elem['input']));
    var fileOut = File(path.normalize(filePath + elem['fileOut']));

    var _actual = await generateBigrams(fileIn, fileOut,  elem['className'], elem['alphabet'], elem['replacementList']);

    result = result && (_actual.errorCode == VigenereBreakerErrorCode.OK);
  });

  return result;
}

Future<VigenereBreakerResult> generateBigrams(File source_fh, File bigrams_fh, String className, String alphabet, Map<String, String> replacementList) async {

  alphabet = alphabet.toLowerCase();

  var list = _fillSourceList(source_fh);
  list = _replaceBigramEntrys(list, alphabet, replacementList);
  var bigrams = _fillBigramArray(list, alphabet);
  bigrams = _scaleBigrams(bigrams);

  return _generateFile(bigrams_fh, className, alphabet, replacementList, bigrams);
}

VigenereBreakerResult _generateFile(File bigrams_fh, String className, String alphabet,  Map<String, String> replacementList, List<List<int>> bigrams) {
  var sb = new StringBuffer();
  var replacementListString = "null";
  var first = true;
  if (replacementList != null && replacementList.length >0){
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

  sb.write("import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/bigrams/bigrams.dart';\n");
  sb.write("\n");
  sb.write("class " + className + " extends Bigrams {\n");
  sb.write("\n");
  sb.write("  " + className + "() {\n");
  sb.write("\n");
  sb.write("    alphabet = '" + alphabet + "';\n");
  sb.write("    replacementList = " + replacementListString + ";\n");;
  sb.write("    bigrams = " + bigramsListToString(bigrams, alphabet) + ";\n");
  sb.write("  }\n");
  sb.write("}\n");

  bigrams_fh.writeAsStringSync(sb.toString());

  if (bigrams == null || bigrams.length == 0)
    return VigenereBreakerResult(alphabet: alphabet, errorCode: VigenereBreakerErrorCode.WRONG_GENERATE_TEXT);
  else
    return VigenereBreakerResult(alphabet: alphabet, errorCode: VigenereBreakerErrorCode.OK);
}

String bigramsListToString(List<List<int>> bigrams, String alphabet){
  var sb = new StringBuffer();
  var idx = 0;
  bool first = true;
  String out ='';

  sb.write("[");
  sb.write("\n");

  sb.write('  //');
  alphabet
    .split('')
    .forEach((char) {
      sb.write(char.toUpperCase().padLeft(8));
    });
  sb.write("\n");

  bigrams.forEach((row) {
    sb.write("    [");
    first = true;
    row.forEach((val) {
      if (first) first = false;
      else sb.write(',');
      if (val == null) val = 0;
      out = val.toString().padLeft(7);
      sb.write(out);
    });
    sb.write(" ],");
    sb.write(" //");
    sb.write(alphabet[idx].toUpperCase());
    sb.write("\n");
    idx += 1;
  });
  sb.write("]");

  return sb.toString();
}

Map<String, int> _fillSourceList(File source_fh) {
  var list = Map<String, int>();
  String text = source_fh.readAsStringSync();

  RegExp regExp = new RegExp(r"(\S\S)(\s)([0-9]*)");
  Iterable<Match> matches = regExp.allMatches(text);
  for (Match match in matches) {
    list.addAll({match.group(1).toLowerCase() : int.tryParse(match.group(3))});
  }
  return list;
}

Map<String, int> _replaceBigramEntrys(Map<String, int> bigramsSource, String alphabet, Map<String, String> replacementList) {
  if (replacementList == null || replacementList.length == 0)
    return bigramsSource;

  for (var i = bigramsSource.length -1; i >= 0; i--) {
    if (replacementList.keys.contains(bigramsSource.keys.elementAt(i)[0]) || (replacementList.keys.contains(bigramsSource.keys.elementAt(i)[0]) )) {
      var entry = substitution(bigramsSource.keys.elementAt(i), replacementList);
      for (var x = 0; x < entry.length - 1; x++) {
        var key = entry[x] + entry[x+1];
        if (bigramsSource.containsKey(key))
          bigramsSource[key] += bigramsSource.values.elementAt(i);
      }
      bigramsSource.remove(bigramsSource.keys.elementAt(i));
    }
  }
  return bigramsSource;
}

List<List<int>> _fillBigramArray(Map<String, int> bigramsSource, String alphabet) {
  var bigrams = List<List<int>>(alphabet.length);

  for (var row = 0; row < bigrams.length; row++) {
    bigrams[row] = List<int>(bigrams.length);
    bigrams[row].fillRange(0,  bigrams[row].length, 0);
  };

  bigramsSource.forEach((key, value) {
    var row    = _charIndex(key[0], alphabet);
    var column = _charIndex(key[1], alphabet);
    if ((row >= 0) && (column >= 0))
      bigrams[row][column] += value;
  });
  return bigrams;
}

List<List<int>> _scaleBigrams(List<List<int>> bigrams) {
  const int maximum = 1000000;
  var minValue = maximum;
  var maxValue = 0;
  var sum = 0;

  for (var row = 0; row < bigrams.length; row++) {
    for (var column = 0; column < bigrams[row].length; column++) {
      maxValue = max(maxValue, bigrams[row][column]);
      minValue = min(minValue, bigrams[row][column]);
      sum += bigrams[row][column];
    };
  };

  var minValueD = log(minValue / sum);
  var maxValueD = log(maxValue / sum);
  var scale =  maximum  / (maxValueD - minValueD);

  for (var row = 0; row < bigrams.length; row++) {
    for (var column = 0; column < bigrams.length; column++) {
      bigrams[row][column] = ((log(bigrams[row][column] / sum) - minValueD) * scale).round();
    }
  }
  return bigrams;
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
