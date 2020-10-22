import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/breaker.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/key.dart';

String  _alphabet = null;
List<int> _quadgrams = null;

/// method to generate quadgrams from a text file
/// :param corpus_fh: the file handle of the text corpus file to process
/// :param quadgram_fh: the file handle where the quadgrams will be saaved
/// :param className: name of the generated class.
/// :param alphabet: the alphabet to apply with this text file.
Future<BreakerResult> generate_quadgrams(File corpus_fh, File quadgram_fh, String className, String alphabet) async {

  _alphabet = Key.check_alphabet(alphabet);
  if (_alphabet.length > Quadgrams.maxAlphabetLength){
    //raise AlphabetInvalid("Alphabet must have less or equal than 32 characters")
    return BreakerResult(alphabet: _alphabet, errorCode: ErrorCode.ALPHABET_TOO_LONG);;
  }

  var iterator = _file_iterator(corpus_fh, _alphabet);
  var quadgram_val = 0;
  var quadgrams = List<double>(pow(Quadgrams.maxAlphabetLength, 3)*Quadgrams.maxAlphabetLength); //_alphabet.length
  quadgrams.fillRange(0, quadgrams.length , 0);

  var idx = 0;
  try {
    iterator.forEach((numerical_char) {
      switch (idx) {
        case 0:
          quadgram_val = numerical_char;
          break;
        case 1:
        case 2:
          quadgram_val = (quadgram_val << 5) + numerical_char;
          break;
        default:
          quadgram_val = ((quadgram_val & 0x7FFF) << 5) + numerical_char;
          quadgrams[quadgram_val] += 1;
      }
      idx += 1;
    });
  } on Exception {
    //"More than three characters from the given alphabet are required"
    return BreakerResult(errorCode: ErrorCode.WRONG_GENERATE_TEXT);
  }

  double quadgram_sum = 0;
  double quadgram_min = 10000000; //??
  quadgrams.forEach((val){
    if (val != 0) {
      quadgram_sum += val;
      quadgram_min = min(quadgram_min, val);
    }
  });
  var offset = log(quadgram_min / 10 / quadgram_sum);

  double prop = 0;
  double new_val = 0;
  double norm = 0;
  idx = 0;
  quadgrams.forEach((val) {
    if (val != 0) {
      prop = val / quadgram_sum;
      new_val = log(prop) - offset;
      quadgrams[idx] = new_val; //??
      norm += prop * new_val;
    }
    idx += 1;
  });

  idx = 0;
  quadgrams.forEach((quadgram) {
    if (quadgram != 0)
      quadgrams[idx] = (quadgram / norm * 1000);
    idx += 1;
  });

  //// Just for curiosity: determine the most frequent quadgram
  idx = 0;
  var max_idx = 0;
  var max_val = 0.0; //??
  quadgrams
    .forEach((val) {
      if (val > max_val){
        max_val = val;
        max_idx = idx;
      };
      idx += 1;
    });

  //// now construct the ASCII representation from the index
  var max_chars = List<String>();
  idx = max_idx;

  for (int i = 0; i < 4; i++) {
    max_chars.insert(0, alphabet[idx & 0x1F]);
    idx >>= 5;
  }

  return _generateFile(quadgram_fh, className, alphabet, quadgram_sum, max_chars.join(), max_val, quadgrams);
}

BreakerResult _generateFile(File quadgram_fh, String className, String alphabet, double quadgram_sum, String max_chars, double max_val, List<double> quadgrams){
  var sb = new StringBuffer();
  var quadgrams_sum = 0;
  var quadgramsInt = List<int>(quadgrams.length);
  for (int i = 0; i < quadgrams.length; i++) {
    quadgramsInt[i] = quadgrams[i].round();
    quadgrams_sum += quadgramsInt[i];
  }
  sb.write("import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';\n");
  sb.write("\n");
  sb.write("class " + className + " extends Quadgrams {\n");
  sb.write("\n");
  sb.write(className + "() {\n");
  sb.write("\n");
  sb.write("alphabet = '" + alphabet + "';\n");
  sb.write("nbr_quadgrams = " + quadgram_sum.round().toString() +";\n");
  sb.write("most_frequent_quadgram = '" + max_chars + "';\n");
  sb.write("max_fitness = " + max_val.round().toString() + ";\n");
  sb.write("average_fitness = " + (quadgrams_sum.toDouble() / pow(alphabet.length, 4 )).toString() + ";\n");
  sb.write("final double quadgrams_sum = " + quadgrams_sum.toString() + ";\n");
  sb.write("Map<int, List<int>> _quadgramsCompressed = ");
  sb.write("\n");
  sb.write(Quadgrams.quadgramsMapToString(Quadgrams.compressQuadgrams(quadgramsInt)));
  sb.write(";\n");
  sb.write("}\n");
  sb.write("}\n");

  quadgram_fh.writeAsStringSync(sb.toString());

  if (quadgrams_sum == 0 || max_val == 0)
    return BreakerResult(alphabet: alphabet, fitness: max_val, errorCode: ErrorCode.WRONG_GENERATE_TEXT);
  else
    return BreakerResult(alphabet: alphabet, fitness: max_val, errorCode: ErrorCode.OK);
}

/// Calculate the fitness from the characters provided by the iterator
/// :param iterator: iterator which provides the characters relevant for calculating the fitness
/// :return: the fitness of the text. A value close to 100 means, the
///          text is probably in the same language than the language used to generate
///          the quadgrams. The more the value differs from 100, the lesser the
///          probability that the examined text corresponds to the quadgram language.
///          Lower values indicate more random text, while values significantly
///          greater than 100 indicate (nonsense) text with too much frequently used
///          quadgrams (e.g., ``tionioningatheling``).
double _calc_fitness(Iterable<int> iterator){
  var quadgrams = _quadgrams;
  var fitness = 0;
  var nbr_quadgrams = 0;
  var quadgram_val=0;
  var idx = 0;
  try {
    iterator.forEach((numerical_char) {
      switch (idx) {
        case 0:
          quadgram_val = numerical_char;
          break;
        case 1:
        case 2:
          quadgram_val = (quadgram_val << 5) + numerical_char;
          break;
        default:
          quadgram_val = ((quadgram_val & 0x7FFF) << 5) + numerical_char;
          fitness += quadgrams[quadgram_val];
          nbr_quadgrams += 1;
      }
      idx += 1;
    });
  } on Exception {
    //// More than three characters from the given alphabet are required"
    return null;
  }

  if (nbr_quadgrams == 0){
    //// More than three characters from the given alphabet are required")
    return null;
  }
  return fitness / nbr_quadgrams / 10;
}

//// Method to calculate the fitness for the given text string
/// :param txt: the text string for which the fitness shall be determined
/// :return: the fitness of the text. A value close to 100 means, the
///          text is probably in the same language than the language used to generate
///          the quadgrams. The more the value differs from 100, the lesser the
///          probability that the examined text corresponds to the quadgram language.
///          Lower values indicate more random text, while values significantly
///          greater than 100 indicate (nonsense) text with too much frequently used
///          quadgrams (e.g., ``tionioningatheling``).
double calc_fitness(String txt) {
  return _calc_fitness(iterateText(txt, _alphabet));
}

/// Implements an iterator for a given file based text file
/// :param file_fh: the file handle of the text file
/// :param alphabet: the alphabet to apply with this text file.
/// :return: an iterator which iterates over all characters of the text file which are present in the alphabet.
Iterable<int> _file_iterator(File file_fh, String alphabet) sync* {
  String text = file_fh.readAsStringSync();

  var trans = alphabet.toLowerCase();
  int index = -1;

  text = text.toLowerCase();
  for (int i = 0; i < text.length; i++) {
    index = trans.indexOf(text[i]);
    if (index >= 0)
      yield index;
  }
}

/// Method to calculate the fitness of the given file contents
/// :param cleartext_fh: the file handle from which the fitness will be calculated
/// :return: the fitness of the text. A value close to 100 means, the
///          text is probably in the same language than the language used to generate
///          the quadgrams. The more the value differs from 100, the lesser the
///          probability that the examined text corresponds to the quadgram language.
///          Lower values indicate more random text, while values significantly
///          greater than 100 indicate (nonsense) text with too much frequently used
///          quadgrams (e.g., ``tionioningatheling``).
double calc_fitness_file(File cleartext_fh){
  return _calc_fitness(_file_iterator(cleartext_fh, _alphabet));
}
