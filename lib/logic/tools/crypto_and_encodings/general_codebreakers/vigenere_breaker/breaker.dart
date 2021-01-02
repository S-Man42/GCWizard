import 'dart:math';
import 'package:tuple/tuple.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/guballa.de/breaker.dart' as guballa;
import 'package:gc_wizard/logic/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/trigrams/trigrams.dart';

/*
guballa.BreakerResult break_vigenere (List<int> cipher_bin, int keyLength, List<List<int>> vigenereSquare, List<int> Trigrams) {
  var key = List<int>();
  var best_score_0   = 0;
  var best_key_ch1_0 = 0;
  //var best_key_ch2_0 = 0;
  var best_key_ch2 = 0;
   var best_fitness = 0;
  var prev_best_score = 0;
  var prev_best_key_ch2 = 0;

  for (var key_idx = 0; key_idx < keyLength; key_idx++) {
    best_fitness = 0;
    var best_key_ch1 = 0;
    best_key_ch2 = 0;
    for (var key_ch1 = 0; key_ch1 < vigenereSquare.length; key_ch1++) {
      for (var key_ch2 = 0; key_ch2 < vigenereSquare.length; key_ch2++) {
        var fitness = 0;
        for (var text_idx = key_idx; text_idx < (cipher_bin.length - 1); text_idx += keyLength) {
          var clear_ch1 = vigenereSquare[cipher_bin[text_idx  ]][key_ch1];
          var clear_ch2 = vigenereSquare[cipher_bin[text_idx+1]][key_ch2];
          fitness += bigrams[clear_ch1][clear_ch2];
        }
        if (fitness > best_fitness) {
          best_fitness = fitness;
          best_key_ch1 = key_ch1;
          best_key_ch2 = key_ch2;
        }
      }
    }
    if (key_idx == 0) {
      best_score_0   = best_fitness;
      best_key_ch1_0 = best_key_ch1;
      //best_key_ch2_0 = best_key_ch2;
      key.add(0); // just a placeholder
    } else {
      key.add((prev_best_score > best_fitness) ? prev_best_key_ch2 : best_key_ch1);
    }
    prev_best_score = best_fitness;
    prev_best_key_ch2 = best_key_ch2;
  }
  key[0] = (best_fitness > best_score_0) ? best_key_ch2 : best_key_ch1_0;

  return guballa.BreakerResult(
      key: key,
      fitness: best_score_0 / 10000 / (keyLength -1)
  );
}
*/

guballa.BreakerResult break_cipher(List<int> cipher_bin, int keyLength, Trigrams trigrams, {int maxRounds = 10000, int consolidate = 3}) {

  /*
  _initBreaker(quadgrams);

  if ((maxRounds < 1) || (maxRounds > 10000))
    // maximum number of rounds not in the valid range 1..10000"
    return BreakerResult(errorCode: ErrorCode.MAX_ROUNDS_PARAMETER);
  if ((consolidate < 1) || (consolidate > 30))
    // consolidate parameter out of valid range 1..30"
    return BreakerResult(errorCode: ErrorCode.CONSOLIDATE_PARAMETER);
*/
  var start_time = DateTime.now();
  var nbr_keys = 0;
  var _trigrams = trigrams.trigrams();
  var _alphabet = trigrams.alphabet;

  /*
  if (cipher_bin.length < 3)
    // ciphertext is too short
    return BreakerResult(errorCode: ErrorCode.TEXT_TOO_SHORT);
*/

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
  var round_cntr = 0;
  var key = List<int>();
  var best_key = List<int>();

  for (int idx = 0; idx < _alphabet.length; idx++) {
    key.add(idx);
    best_key.add(idx);
  }
  for (round_cntr = 0; round_cntr < maxRounds; round_cntr++) {
    key.shuffle();

    var tuple = _hill_climbing(key, keyLength, cipher_bin, char_positions, trigrams);
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
  var seconds = (DateTime.now().difference(start_time)).inMilliseconds / 1000;
  var key_bin = List<int>();

  _iterateText(key_str, trigrams.alphabet).forEach((char) {key_bin.add(char);});
  return guballa.BreakerResult(
      key: key_bin,
      fitness: local_maximum / 10000 / (keyLength -2)
  );
}

Tuple2<int,int> _hill_climbing(List<int> key, int keyLength, List<int> cipher_bin, List<List<int>> char_positions, Trigrams trigrams){
  var plaintext = List<int>();
  cipher_bin.forEach((idx) => plaintext.add(key.indexOf(idx)));
  var nbr_keys = 0;
  var max_fitness = 0;
  var better_key = true;
  var _trigrams = trigrams.trigrams();

  while (better_key) {
    better_key = false;
    for (var idx1 = 0; idx1 < keyLength - 1; idx1++) {
      for (var idx2 = idx1 + 1; idx2 < keyLength; idx2++) {
        var ch1 = key[idx1];
        var ch2 = key[idx2];
        char_positions[ch1].forEach((idx) {plaintext[idx] = idx2;});
        char_positions[ch2].forEach((idx) {plaintext[idx] = idx1;});
        nbr_keys += 1;
        var tmp_fitness = 0;
        var tri_idx = (plaintext[0] << 5) + plaintext[1];

        for (var char = 3; char < plaintext.length; char++) {
          tri_idx = ((tri_idx & 0x3FF) << 5) + plaintext[char];
          tmp_fitness += _trigrams[tri_idx];
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

Iterable<int> _iterateText(String text, String alphabet) sync* {
  var trans = alphabet.toLowerCase();
  int index = -1;

  text = text.toLowerCase();
  for (int i = 0; i < text.length; i++) {
    index = trans.indexOf(text[i]);
    if (index >= 0)
      yield index;
  }
}