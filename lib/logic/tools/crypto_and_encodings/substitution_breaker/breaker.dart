/* # -*- coding: utf-8 -*-
"""This module provides support for breaking substitution ciphers.

This includes generating quadgrams from a text corpus, scoring a plaintext and
breaking substitution ciphers.
"""

import math
import json
import sys
import random
import time

from subbreaker.key import Key, AlphabetInvalid
*/

import 'dart:io';
import 'package:tuple/tuple.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/key.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/quadgrams.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution_breaker/quadgrams/EN.dart';

enum BreakerAlphabet{English, German}
enum ErrorCode{OK, MAX_ROUNDS_PARAMETER, CONSOLIDATE_PARAMETER, TEXT_TOO_SHORT, ALPHABET_TOO_LONG, WRONG_GENERATE_TEXT}

class BreakerResult{
/*
    """Class representing the result for breaking a substitution cipher

    :ivar str ciphertext: the original ciphertext
    :ivar str plaintext: the resulting plaintext using the found key
    :ivar str key: the best key found by the breaker
    :ivar str alphabet: the alphabet used to break the cipher
    :ivar float fitness: the fitness of the resulting plaintext
    :ivar int nbr_keys: the number of keys tried by the breaker
    :ivar nbr_rounds: the number of hill climbings performed, starting with a random
        key
    :ivar float keys_per_second: the number of keys tried per second
    :ivar float seconds: the time in seconds used to break the cipher
    """
*/

        String ciphertext=null;
        String  plaintext=null;
        String  key=null;
        String  alphabet=null;
        double fitness=0;
        int nbr_keys=0;
        int nbr_rounds=0;
        double keys_per_second=0;
        double seconds=0;
        ErrorCode erroroCode;

        BreakerResult(
          String ciphertext,
          String  plaintext,
          String  key,
          String  alphabet,
          double fitness,
          int nbr_keys,
          int nbr_rounds,
          double keys_per_second,
          double seconds,
          ErrorCode erroroCode
    ){
        //"""Instantiation method
        //"""
        this.ciphertext = ciphertext;
        this.plaintext = plaintext;
        this.key = key;
        this.alphabet = alphabet;
        this.fitness = fitness;
        this.nbr_keys = nbr_keys;
        this.nbr_rounds = nbr_rounds;
        this.keys_per_second = keys_per_second;
        this.seconds = seconds;
        this.erroroCode =erroroCode;
}
     toString(){
        return "key = {}"; //.format(_key)
        }

}

class BreakerInfo{
/*
    """Class representing various information of the quadgrams for a given language

    :ivar str alphabet: text representation of the alphabet
    :ivar int nbr_quadgrams: the number of quadgrams considered for the generated
        quadgram file. This value may be lower than the corpus size as only characters
        from the alphabet are considered for this value
    :ivar str most_frequent_quadgram: the most occurring same sequence of four
        characters within the corpus used to generate the quadgram file. For English,
        the expected value here is "tion".
    :ivar float average_fitness: the expected fitness of a text if all characters are
        generated randomly with the same probability.
    :ivar float max_fitness: the fitness for the most frequent quadgram
    """
*/

  String alphabet = null;
  int nbr_quadgrams = 0;
  String most_frequent_quadgram = null;
  double average_fitness = 0;
  double max_fitness = 0;

  BreakerInfo(
      String alphabet,
      int nbr_quadgrams,
      String most_frequent_quadgram,
      double average_fitness,
      double max_fitness
      ){
    this.alphabet = alphabet;
    this.nbr_quadgrams = nbr_quadgrams;
    this.most_frequent_quadgram = most_frequent_quadgram;
    this.average_fitness = average_fitness;
    this.max_fitness = max_fitness;
  }
}

/*
"""Class to represent the breaker implementation based on quadgrams

:ivar info: a :class:`BreakerInfo` object
:type info: :class:`BreakerInfo` object
:ivar key: a :class:`Key` object with the key found when breaking a cipher
:type key: :class:`Key`
:param quadgram_fh: file handle (i.e., a read()-supporting file like object)
    to read the quadgrams from.
:type quadgram_fh: file handle
"""
*/
const DEFAULT_ALPHABET = "abcdefghijklmnopqrstuvwxyz";
String  _alphabet=null;
int _alphabet_len = 0;
List<int> _quadgrams = null;
BreakerInfo _info = null;
Key _key = null;


BreakerResult break_cipher(String input, BreakerAlphabet alphabet) {
  switch (alphabet){
    case BreakerAlphabet.English:
      _initBreaker(EN());
      break;
    case BreakerAlphabet.German:
      return null;
      break;
  }
  return  _break_cipher(input);
}

_initBreaker(Quadgrams languageQuadgrams) {
  /*"""Init the instance
    """
    */
  _alphabet = languageQuadgrams.alphabet;
  _alphabet_len = _alphabet.length;
  _quadgrams = languageQuadgrams.quadgrams;
  _info = BreakerInfo(
      languageQuadgrams.alphabet,
      languageQuadgrams.nbr_quadgrams,
      languageQuadgrams.most_frequent_quadgram,
      languageQuadgrams.average_fitness / 10,
      languageQuadgrams.max_fitness / 10
  );
  _key = null;
}

//@staticmethod
Iterable<int>  _text_iterator(String text, String alphabet) sync*  {
    /*
        """Implements an iterator for a given text string

        The iterator will yield all characters of the text string which are present in
        the alphabet, all other characters will be skipped.

        :param str txt: the text string to process
        :param str alphabet: the alphabet to apply with this text string
        :return: an iterator which iterates over all characters of the text string
            which are present in the alphabet.
        """
*/
  var trans = alphabet.toLowerCase();
  int index = -1;

  text = text.toLowerCase();
  for (int i = 0; i < text.length; i++) {
    index = trans.indexOf(text[i]);
    if (index >= 0)
      yield index;
  }

      //iterateText (txt, alphabet);
}

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


Tuple2<int,int> _hill_climbing(List<int> key, List<int> cipher_bin, List<List<int>>  char_positions){
 /*       """Basic hill climbing function

        Starting from the given key two charters are swapped, hoping the mutated key
        provides a better result than the original key. This is done for all possible
        pairs of characters. If a better key is found, the mutation process starts
        over again. If no better key is found, we reached a (local) maximum and the
        fitness and the number of keys is returned.

        :param key: the key to start with. The key is represented as a list where each
            character is represented by an integer 0..25 (for the default alphabet).
            0 corresponds to the first character of the alphabet, 1 to the second,
            etc.
        :type key: list(int)
        :param cipher_bin: the ciphertext in binary representation, i.e. each
            character present in the alphabet is represented as an integer.
        :type cipher_bin: list(int)
        :param char_positions: a list for each character of the alphabet indicating
            at which positions it is occurring. The positions are stored in a list.
            Used to quickly update the plaintext when two characters of the key are
            swapped.
        :type char_positions: list(list(int))
        which for each character holds a list where in
            the ciphertext it occurs.
        :return: tuple of the max_fitness and the number of keys evaluated
        :rtype: tuple
        """
   */
        var plaintext = List<int>();
        cipher_bin.forEach((idx) => plaintext.add(key.indexOf(cipher_bin[idx])));
        var quadgram = _quadgrams;
        var key_len = _alphabet_len;
        var nbr_keys = 0;
        var quad_idx = 0;
        var max_fitness = 0;
        var tmp_fitness = 0;
        var better_key = true;
        var ch1 = 0;
        var ch2 = 0;
        while (better_key) {
            better_key = false;
            for (var idx1 = 0; idx1 < key_len - 1; idx1++){
                for (var idx2 = idx1 + 1; idx2 < key_len; idx2++) {
                  ch1 = key[idx1];
                  ch2 = key[idx2];
                  char_positions[ch1].forEach((idx) { plaintext[idx] = idx2;});
                  char_positions[ch2].forEach((idx) {plaintext[idx] = idx1;});
                  nbr_keys += 1;
                  tmp_fitness = 0;
                  quad_idx = (plaintext[0] << 10) + (plaintext[1] << 5) + plaintext[2];

                  for (var char = 3; char < plaintext.length; char++) {
                    quad_idx = ((quad_idx & 0x7FFF) << 5) + char;
                    tmp_fitness += quadgram[quad_idx];
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

BreakerResult _break_cipher(String ciphertext, {int maxRounds = 10000, int consolidate = 3}){
     /*   """Breaks a given cipher text

        :param str ciphertext: the ciphertext to break
        :param int max_rounds: the maximum of hill climbing rounds to execute
        :param int consolidate: the number of times the best local maximum must be
            reached before it is considers the overall best solution
        :return: an BreakerResult object
        :rtype: :class:`BreakerResult`
        """
        */

        if (!((1 < maxRounds) | (maxRounds > 10000)))
            //raise ValueError("maximum number of rounds not in the valid range 1..10000")
          return BreakerResult('','','','',0,0,0,0,0,ErrorCode.MAX_ROUNDS_PARAMETER);
        if (!((1 < consolidate) | (consolidate > 30)))
            //raise ValueError("consolidate parameter out of valid range 1..30")
            return BreakerResult('','','','',0,0,0,0,0,ErrorCode.CONSOLIDATE_PARAMETER);
        var start_time = DateTime.now();
        var nbr_keys = 0;
        var cipher_bin = List<int>();
        _text_iterator(ciphertext, _alphabet).forEach((char) { cipher_bin.add(char);});

        if (cipher_bin.length < 4)
            //raise ValueError("ciphertext is too short")
          return BreakerResult('','','','',0,0,0,0,0,ErrorCode.TEXT_TOO_SHORT);

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
        _key = Key(key_str, alphabet: _alphabet);
        var seconds = (DateTime.now().difference(start_time)).inMilliseconds / 1000;

        return BreakerResult(
          ciphertext,
          _key.decode(ciphertext),
          key_str,
          _alphabet,
          local_maximum / ((cipher_bin.length) - 3) / 10,
          nbr_keys,
          round_cntr,
          (nbr_keys / seconds),
          seconds,
          ErrorCode.OK
        );

    }
