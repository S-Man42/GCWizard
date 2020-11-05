import 'dart:math';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vigenere_breaker/vigenere_breaker.dart';

class Trigrams {
  static const int maxAlphabetLength = 32;

  String alphabet = null;
  Map<String, String> replacementList = null;

  // The trigram with the lowest probability receives the value 0, the one with the greatest probability receives the value 1000000
  Map<int, List<int>> trigramsCompressed = null;

  List<int> _trigrams = null;

  List<int> trigrams() {
    if (_trigrams != null)
      return _trigrams;

    if (trigramsCompressed == null)
      return null;

    _trigrams = decompressTrigrams(trigramsCompressed,
        pow(Trigrams.maxAlphabetLength, 2) * alphabet.length);
    trigramsCompressed = null;
    return _trigrams;
  }

  static Map<int, List<int>> compressTrigrams(List<int> trigrams) {
    var map = Map<int, List<int>>();
    var blockStart = -1;
    const int zeroCount = 5;

    for (int i = 0; i < trigrams.length; i++) {
      if ((blockStart < 0) && (trigrams[i] != 0))
        blockStart = i;

      if (blockStart >= 0) {
        // if five 0 => new list
        if (((i + zeroCount < trigrams.length) &&
            (trigrams[i + 1] == 0) | (trigrams[i + 1] == null) &&
            (trigrams[i + 2] == 0) | (trigrams[i + 2] == null) &&
            (trigrams[i + 3] == 0) | (trigrams[i + 3] == null) &&
            (trigrams[i + 4] == 0) | (trigrams[i + 4] == null) &&
            (trigrams[i + 5] == 0) | (trigrams[i + 5] == null)) ||
            (i + zeroCount >= trigrams.length)) {
          var quadgramList = List<int>();
          quadgramList.addAll(trigrams.getRange(blockStart,
              (i + zeroCount >= trigrams.length) ? trigrams.length : min(
                  i + 1, trigrams.length)));
          map.addAll({blockStart: quadgramList});
          i += zeroCount;
          blockStart = -1;
        }
      }
    }
    return map;
  }

  static List<int> decompressTrigrams(Map<int, List<int>> trigramsCompressed,
      int size) {
    if (trigramsCompressed == null)
      return null;
    var list = List<int>(size);

    list.fillRange(0, list.length, 0);

    trigramsCompressed.forEach((idx, values) {
      for (int i = idx; i < idx + values.length; i++) {
        list[i] = values[i - idx];
      }
    });
    return list;
  }

  static String trigramsMapToString(Map<int, List<int>> trigramsCompressed) {
    var sb = new StringBuffer();
    bool first = true;
    bool firstEntry = true;
    String out = '';
    var idx = 0;
    sb.write('{');
    trigramsCompressed.forEach((idx, values) {
      if (firstEntry)
        firstEntry = false;
      else
        sb.write(',');
      sb.write(idx.toString());
      sb.write(':');
      sb.write('[');
      first = true;
      values.forEach((val) {
        if (first)
          first = false;
        else
          sb.write(',');
        if (val == null) val = 0;
        out = val.round().toString();
        sb.write(out);
      });
      sb.write(']');
    });
    sb.write('}');

    out = '';
    out = sb.toString()
        .split('')
        .map((char) {
      if (idx > 230 && ((char == ',') | (char == '}'))) {
        idx = 0;
        return char + '\n';
      } else {
        idx += 1;
        return char;
      }
    })
        .join();

    return out;
  }
}
