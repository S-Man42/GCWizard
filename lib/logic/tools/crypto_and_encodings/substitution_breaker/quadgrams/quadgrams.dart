import 'dart:math';

class Quadgrams {
  static const int maxAlphabetLength = 32;

  final String  alphabet = null;
  final int nbr_quadgrams = 0;
  final String most_frequent_quadgram = null;
  final int max_fitness = 0;
  final double average_fitness = 0;
  final int quadgramsSize = 0;
  final List<int> quadgrams = null;
  final Map<int, List<int>> quadgramsCompressed = null;


  static Map<int, List<int>> compressQuadgrams (List<int> quadgrams) {
    var map = Map<int, List<int>>();
    var blockStart = -1;

    for (int i = 0; i < quadgrams.length; i++) {
      if ((blockStart < 0) && (quadgrams[i] != 0) )
        blockStart = i;

      if (blockStart >= 0) {
        // if 0 follows twice => new list
        if (((i + 2 < quadgrams.length) &&
            (quadgrams[i+1] == 0) | (quadgrams[i+1] == null) &&
            (quadgrams[i+2] == 0) | (quadgrams[i+2] == null)) ||
          (i + 2 >= quadgrams.length)) {
          var quadgramList = List<int>();
          quadgramList.addAll(quadgrams.getRange(blockStart, min(i + 1, quadgrams.length)));
          map.addAll({blockStart : quadgramList});
          blockStart = -1;
        }
      }
    }
    return map;
  }

  static List<int> decompressQuadgrams (Map<int, List<int>> quadgramsCompressed, int size) {
    var list = List<int>(size);

    list.fillRange(0, list.length -1, 0);

    quadgramsCompressed.forEach((idx, values) {
      list.replaceRange(idx, idx + values.length, values);
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