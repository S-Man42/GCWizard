import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';


Future<Uint8List> binary2image(String input, bool squareFormat, bool invers) async {
  var filter = _buildFilter(input);
  if (filter.length < 2)
    return null;

  if (!squareFormat) filter += "\n";
  input = _filterInput(input, filter);

  if (squareFormat) {
    var size = sqrt(input.length) .ceil();
    input = insertSpaceEveryNthCharacter(input, size);
    input = input.replaceAll(RegExp('[ ]'), '\n');
  }

  if (invers)
    input = substitution(input,  {filter[0]: '1', filter[1]: '0'});
  else
    input = substitution(input,  {filter[0]: '0', filter[1]: '1'});

  return await binary2Image(input);
}

String _buildFilter(String input) {
  var alphabet = removeDuplicateCharacters(input);
  alphabet = alphabet.replaceAll(RegExp('[/r/n/t]'), '');
  var alphabetTmp = alphabet.split('').toList();
  alphabetTmp.sort();
  alphabet = alphabetTmp.join();

  if (alphabet.length <= 2) {
    return alphabet;
  }

  if (alphabet.length == 3 && alphabet.contains(' '))
    return alphabet.replaceAll(' ', '');

  var filter = '';
  var map = Map<String, int>();

  alphabet
    .split('')
    .forEach((char) {
      map.addAll({char: char.allMatches(input).length});
    });
  print(map);
  map = new SplayTreeMap.from(map, (key1, key2) => map[key2].compareTo(map[key1]));
  print(map);

  filter = map.keys.elementAt(0) + map.keys.elementAt(1) + map.keys.elementAt(2);
  if (filter.contains(' '))
    return filter.replaceAll(' ', '');
  else
    return map.keys.elementAt(0) + map.keys.elementAt(1);
}

String _filterInput(String input, String filter) {
  return input.replaceAll(RegExp('[^$filter]'), '');
}

Future<Uint8List> binary2Image(String input) async {
  var bounds = 10;
  var pointSize = 5.0;
  var lines = input.split('\n');

  var width = 0.0;
  var height = 0.0;

  lines.forEach((line) {
    width = max(width, line.length.toDouble());
    height++;
  });
  width = width * pointSize + 2 * bounds;
  height = height * pointSize + 2 * bounds;

  final canvasRecorder = ui.PictureRecorder();
  final canvas = ui.Canvas(canvasRecorder, ui.Rect.fromLTWH(0, 0, width, height));

  final paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

  paint.color = Colors.black;

  for (int row=0; row<lines.length; row++) {
    for (int column=0; column<lines[row].length; column++) {
      if (lines[row][column] != '0')
        canvas.drawRect(Rect.fromLTWH(column*pointSize + bounds, row*pointSize + bounds, pointSize, pointSize), paint);
    }
  };

  final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);

  return data.buffer.asUint8List();
}



Uint8List _hexString2bytes(String input) {
  if (input == null || input == "")
    return null;

  var data = <int>[];

  input = input.replaceAll("0x", "");
  String hex = input.toUpperCase().replaceAll(RegExp("[^0-9A-F]"), "");
  if (hex == "")
    return null;

  for (var i=0; i<hex.length; i=i+2) {
    var valueString = hex.substring(i, min(i+2, hex.length-1));
    if (valueString.length  > 0) {
      int value = int.tryParse(convertBase(valueString, 16, 10));
      data.add(value);
    }
  }

  return Uint8List.fromList(data);
}

bool _isBinary(String input) {
  if (input == null)
    return false;
  String binary = input.replaceAll(RegExp("[01\\s]"), "");
  return binary.length == 0;
}

Uint8List _binaryString2bytes(String input) {
  if (input == null || input == "")
    return null;

  var data = <int>[];

  String binary = input.replaceAll(RegExp("[^01]"), "");
  if (binary == "")
    return null;

  for (var i=0; i<binary.length; i=i+8) {
    var valueString = binary.substring(i, min(i+8, binary.length-1));
    if (valueString.length  > 0) {
      int value = int.tryParse(convertBase(valueString, 2, 10));
      data.add(value);
    }
  }

  return Uint8List.fromList(data);
}
