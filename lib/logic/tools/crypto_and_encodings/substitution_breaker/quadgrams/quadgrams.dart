import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';

class Quadgrams {
  static const int maxAlphabetLength = 32;

  String  alphabet = null;
  int nbr_quadgrams = 0;
  String most_frequent_quadgram = null;
  int max_fitness = 0;
  double average_fitness ;
  int quadgramsSize = 0;
  List<int> _quadgrams = null;
  Map<int, List<int>> quadgramsCompressed = null;
  String assetLocation;

  Future<List<int>> quadgrams() async {
    if (_quadgrams != null)
      return _quadgrams;

    // add this, and it should be the first line in main method
    // WidgetsFlutterBinding.ensureInitialized();

    String data = await rootBundle.loadString(assetLocation);
    Map<String, dynamic> jsonData = jsonDecode(data);
    quadgramsCompressed = Map<int, List<int>>();
    jsonData.entries.forEach((entry) {
      quadgramsCompressed.putIfAbsent(
          int.tryParse(entry.key),
              () => List<int>.from(entry.value)
      );
    });

    if (quadgramsCompressed == null)
      return null;

    _quadgrams = decompressQuadgrams(quadgramsCompressed, pow(Quadgrams.maxAlphabetLength, 3) * alphabet.length);
    quadgramsCompressed = null;
    return _quadgrams;
  }

  static Map<int, List<int>> compressQuadgrams (List<int> quadgrams) {
    var map = Map<int, List<int>>();
    var blockStart = -1;
    const int zeroCount = 5;

    for (int i = 0; i < quadgrams.length; i++) {
      if ((blockStart < 0) && (quadgrams[i] != 0) )
        blockStart = i;

      if (blockStart >= 0) {
        // if five 0 => new list
        if (((i + zeroCount < quadgrams.length) &&
          (quadgrams[i+1] == 0) | (quadgrams[i+1] == null) &&
          (quadgrams[i+2] == 0) | (quadgrams[i+2] == null) &&
          (quadgrams[i+3] == 0) | (quadgrams[i+3] == null) &&
          (quadgrams[i+4] == 0) | (quadgrams[i+4] == null) &&
          (quadgrams[i+5] == 0) | (quadgrams[i+5] == null)) ||
          (i + zeroCount >= quadgrams.length)) {
          var quadgramList = List<int>();
          quadgramList.addAll(quadgrams.getRange(blockStart, (i + zeroCount >= quadgrams.length) ? quadgrams.length : min(i + 1, quadgrams.length)));
          map.addAll({blockStart : quadgramList});
          i += zeroCount;
          blockStart = -1;
        }
      }
    }
    return map;
  }

  static List<int> decompressQuadgrams (Map<int, List<int>> quadgramsCompressed, int size) {
    if (quadgramsCompressed == null)
      return null;
    var list = List<int>(size);

    list.fillRange(0, list.length , 0);

    quadgramsCompressed.forEach((idx, values) {
      for (int i = idx; i < idx + values.length; i++) {
        list[i] = values[i - idx];
      }
    });
    return list;
  }

  static String quadgramsMapToString(Map<int, List<int>> quadgramsCompressed) {
    var sb = new StringBuffer();
    bool first = true;
    bool firstEntry = true;
    String out = '';
    var idx = 0;
    sb.write('{');
    quadgramsCompressed.forEach((idx, values) {
      if (firstEntry)
        firstEntry = false;
      else
        sb.write(',');
      sb.write(idx.toString());
      sb.write(':');
      sb.write('[');
      first = true;
      values.forEach((val) {
        if (first) first = false;
        else sb.write(',');
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

  static String quadgramsListToString(List<int> quadgrams){
    var sb = new StringBuffer();
    bool first = true;
    var idx  = 0;
    String out ='';
    quadgrams.forEach((val) {
      if (first) first = false;
      else sb.write(',');
      if (val == null) val = 0;
      out = val.round().toString();
      sb.write(out);
      idx += out.length + 1;
      if (idx > 230) {
        sb.write("\n");
        idx = 0;
      }
    });
    return sb.toString();
  }

}