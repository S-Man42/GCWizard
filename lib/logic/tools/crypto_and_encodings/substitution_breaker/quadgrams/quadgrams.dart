import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:archive/archive.dart' as arc;
import 'dart:convert' as conv;




/*
import 'json_objects.dart';
import "package:zipio/zipio.dart" show readZip, ZipEntity, ZipEntry, ZipMethod;
*/


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

  List<int> quadgrams() {
    if (_quadgrams != null)
      return _quadgrams;

    _quadgrams = decompressQuadgrams(quadgramsCompressed, pow(Quadgrams.maxAlphabetLength, 3) * alphabet.length);
    quadgramsCompressed = null;
    return _quadgrams;
  }

  static Map<int, List<int>> compressQuadgrams (List<int> quadgrams) {
    var map = Map<int, List<int>>();
    var blockStart = -1;

    for (int i = 0; i < quadgrams.length; i++) {
      if ((blockStart < 0) && (quadgrams[i] != 0) )
        blockStart = i;

      if (blockStart >= 0) {
        // if five 0 => new list
        if (((i + 2 < quadgrams.length) &&
            (quadgrams[i+1] == 0) | (quadgrams[i+1] == null) &&
            (quadgrams[i+2] == 0) | (quadgrams[i+2] == null) &&
            (quadgrams[i+3] == 0) | (quadgrams[i+3] == null) &&
            (quadgrams[i+4] == 0) | (quadgrams[i+4] == null) &&
            (quadgrams[i+5] == 0) | (quadgrams[i+5] == null)) ||
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

/*
  createZipFile(String path, Quadgrams quadram) async {
    var bytes = utf8.encode(conv.jsonEncode(quadram));
    var encoder = arc.ZipDecoder().decodeBytes(bytes);


    encoder.encode(new arc.Archive());
    encoder.addFile(File(selectedAdharFile));
    encoder.addFile(File(selectedIncomeFile));
    encoder.close();

  }

  Quadgrams readZipFile(String path) {
    final bytes = new File(path).readAsBytesSync();
    final archive = new arc.ZipDecoder().decodeBytes(bytes);


    for (var file in archive) {

      if (file.isFile) {
        file.decompress();


        return  conv.jsonDecode(file);;
      }
    }
  }
  */
}