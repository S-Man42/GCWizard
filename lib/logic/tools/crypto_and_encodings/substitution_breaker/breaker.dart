/// Class to represent the breaker implementation based on quadgrams
/// ported from https://gitlab.com/guballa/SubstitutionBreaker

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/Key.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:tuple/tuple.dart';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/english_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/german_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/spanish_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/polish_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/greek_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/france_quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/russian_quadgrams.dart';

enum BreakerAlphabet{English, German, Spanish, Polish, Greek, France, Russian}
enum ErrorCode{OK, MAX_ROUNDS_PARAMETER, CONSOLIDATE_PARAMETER, TEXT_TOO_SHORT, ALPHABET_TOO_LONG, WRONG_GENERATE_TEXT}

/// Class representing the result for breaking a substitution cipher
/// :param str ciphertext: the original ciphertext
/// :param str plaintext: the resulting plaintext using the found key
/// :param str key: the best key found by the breaker
/// :param str alphabet: the alphabet used to break the cipher
/// :param float fitness: the fitness of the resulting plaintext
/// :param int nbr_keys: the number of keys tried by the breaker
/// :param nbr_rounds: the number of hill climbings performed, starting with a random key
/// :param float keys_per_second: the number of keys tried per second
/// :param float seconds: the time in seconds used to break the cipher
class BreakerResult {
  String ciphertext= '';
  String plaintext= '';
  String key = '';
  String alphabet= '';
  double fitness = 0;
  int nbr_keys = 0;
  int nbr_rounds = 0;
  double keys_per_second = 0;
  double seconds = 0;
  ErrorCode errorCode = ErrorCode.OK;

  BreakerResult({
    String ciphertext = '',
    String plaintext = '',
    String key = '',
    String alphabet = '',
    double fitness = 0,
    int nbr_keys = 0,
    int nbr_rounds = 0,
    double keys_per_second = 0,
    double seconds = 0,
    ErrorCode errorCode = ErrorCode.OK
  })
  {
    this.ciphertext = ciphertext;
    this.plaintext = plaintext;
    this.key = key;
    this.alphabet = alphabet;
    this.fitness = fitness;
    this.nbr_keys = nbr_keys;
    this.nbr_rounds = nbr_rounds;
    this.keys_per_second = keys_per_second;
    this.seconds = seconds;
    this.errorCode = errorCode;
  }
}

const DEFAULT_ALPHABET = "abcdefghijklmnopqrstuvwxyz";
String  _alphabet = null;
int _alphabet_len = 0;
List<int> _quadgrams = null;


Future<BreakerResult> break_cipher(String input, Quadgrams quadgrams) async {
  if (input == null || input == '')
    return BreakerResult(errorCode: ErrorCode.OK);

  _initBreaker(quadgrams);

  return  _break_cipher(input);
}

/// Init the instance
_initBreaker(Quadgrams languageQuadgrams) {
  _alphabet = languageQuadgrams.alphabet;
  _alphabet_len = _alphabet.length;
  _quadgrams = languageQuadgrams.quadgrams();
}

Quadgrams getQuadgrams(BreakerAlphabet alphabet){
  switch (alphabet) {
    case BreakerAlphabet.English:
      return  EnglishQuadgrams();
      break;
    case BreakerAlphabet.German:
      return  GermanQuadgrams();
      break;
    case BreakerAlphabet.Spanish:
      return  SpanishQuadgrams();
      break;
    case BreakerAlphabet.Polish:
      return  PolishQuadgrams();
      break;
    case BreakerAlphabet.Greek:
      return  GreekQuadgrams();
      break;
    case BreakerAlphabet.France:
      return  FranceQuadgrams();
      break;
    case BreakerAlphabet.Russian:
      return RussianQuadgrams();
      break;
    default:
      return null;
  }
}

/// Implements an iterator for a given text string
/// :param str txt: the text string to process
/// :param str alphabet: the alphabet to apply with this text string
/// :return: an iterator which iterates over all characters of the text string which are present in the alphabet.
Iterable<int> iterateText(String text, String alphabet) sync* {
  var trans = alphabet.toLowerCase();
  int index = -1;

  text = text.toLowerCase();
  for (int i = 0; i < text.length; i++) {
    index = trans.indexOf(text[i]);
    if (index >= 0)
      yield index;
  }
}

/// Basic hill climbing function
/// :param key: the key to start with. The key is represented as a list where each
///             character is represented by an integer 0..25 (for the default alphabet).
///             0 corresponds to the first character of the alphabet, 1 to the second,
///             etc.
/// :param cipher_bin: the ciphertext in binary representation, i.e. each
///             character present in the alphabet is represented as an integer.
/// :param char_positions: a list for each character of the alphabet indicating
///             at which positions it is occurring. The positions are stored in a list.
///             Used to quickly update the plaintext when two characters of the key are
///             swapped.
/// :return: tuple of the max_fitness and the number of keys evaluated
Tuple2<int,int> _hill_climbing(List<int> key, List<int> cipher_bin, List<List<int>> char_positions){
  var plaintext = List<int>();
  cipher_bin.forEach((idx) => plaintext.add(key.indexOf(idx)));
  var key_len = _alphabet_len;
  var nbr_keys = 0;
  var max_fitness = 0;
  var better_key = true;

  while (better_key) {
    better_key = false;
    for (var idx1 = 0; idx1 < key_len - 1; idx1++) {
      for (var idx2 = idx1 + 1; idx2 < key_len; idx2++) {
        var ch1 = key[idx1];
        var ch2 = key[idx2];
        char_positions[ch1].forEach((idx) {plaintext[idx] = idx2;});
        char_positions[ch2].forEach((idx) {plaintext[idx] = idx1;});
        nbr_keys += 1;
        var tmp_fitness = 0;
        var quad_idx = (plaintext[0] << 10) + (plaintext[1] << 5) + plaintext[2];

        for (var char = 3; char < plaintext.length; char++) {
          quad_idx = ((quad_idx & 0x7FFF) << 5) + plaintext[char];
          tmp_fitness += _quadgrams[quad_idx];
        }
        if (tmp_fitness > max_fitness) {
          max_fitness = tmp_fitness;
          better_key = true;
          key[idx1] = ch2;
          key[idx2] = ch1;
        } else {
          char_positions[ch1].forEach((idx) {plaintext[idx] = idx1;});
          char_positions[ch2].forEach((idx) {plaintext[idx] = idx2;});
        }
      }
    }
  }
  return Tuple2<int,int>(max_fitness, nbr_keys);
}

/// Breaks a given cipher text
/// :param ciphertext: the ciphertext to break
/// :param max_rounds: the maximum of hill climbing rounds to execute
/// :param consolidate: the number of times the best local maximum must be reached before it is considers the overall best solution
/// :return: an BreakerResult object
BreakerResult _break_cipher(String ciphertext, {int maxRounds = 10000, int consolidate = 3}) {

  if (( maxRounds < 1) || (maxRounds > 10000))
      // maximum number of rounds not in the valid range 1..10000"
    return BreakerResult(errorCode: ErrorCode.MAX_ROUNDS_PARAMETER);
  if ((consolidate < 1) || (consolidate > 30))
      // consolidate parameter out of valid range 1..30"
      return BreakerResult(errorCode: ErrorCode.CONSOLIDATE_PARAMETER);

  var start_time = DateTime.now();
  var nbr_keys = 0;
  var cipher_bin = List<int>();
  iterateText(ciphertext, _alphabet).forEach((char) {cipher_bin.add(char);});

  if (cipher_bin.length < 4)
      //raise ValueError("ciphertext is too short")
    return BreakerResult(errorCode: ErrorCode.TEXT_TOO_SHORT);

  var char_positions = List<List<int>>();
  for (int idx = 0; idx < _alphabet.length; idx++) {
    var posList = List<int>();
      var i = 0;
      cipher_bin
        .forEach((x) {
          if (x == idx) posList.add(i);
          i += 1;
        });
      char_positions.add(posList);
    };

  var local_maximum = 0;
  var local_maximum_hit = 1;
  var round_cntr =0;
  var key = List<int>();
  var best_key = List<int>();

  for (int idx = 0; idx < _alphabet.length; idx++) {
    key.add(idx);
    best_key.add(idx);
  }
  for (round_cntr = 0; round_cntr < maxRounds; round_cntr++) {
    key.shuffle();

    var tuple = _hill_climbing(key, cipher_bin, char_positions);
    var fitness = tuple.item1;
    nbr_keys += tuple.item2;

    if (fitness > local_maximum) {
      local_maximum = fitness;
      local_maximum_hit = 1;
      best_key.clear();
      best_key.addAll(key);
    } else if (fitness == local_maximum) {
      local_maximum_hit += 1;
      if (local_maximum_hit == consolidate) break;
    }
  }
  var key_str = best_key.map((x) => _alphabet[x]).join();
  var _key = KeyS(key_str, alphabet: _alphabet);
  var seconds = (DateTime.now().difference(start_time)).inMilliseconds / 1000;

  return BreakerResult(
    ciphertext: ciphertext,
    plaintext: _key.decode(ciphertext),
    key: key_str,
    alphabet: _alphabet,
    fitness: local_maximum / ((cipher_bin.length) - 3) / 10,
    nbr_keys: nbr_keys,
    nbr_rounds: round_cntr,
    keys_per_second: (nbr_keys / seconds),
    seconds: seconds,
    errorCode: ErrorCode.OK
  );
}

