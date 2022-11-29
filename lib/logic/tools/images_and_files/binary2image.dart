import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/utils/common_utils.dart';

Map<String, Color> colorMap = {
  '0': Colors.white,
  '1': Colors.black,
  '2': Colors.redAccent, //light red
  '3': Colors.yellow.shade100, //light yellow
  '4': Colors.lightGreen,
  '5': Colors.cyanAccent, //light cyan,
  '6': Colors.lightBlue,
  '7': Colors.pinkAccent.shade100, //light magenta,
  '8': Colors.red,
  '9': Colors.yellowAccent,
  'A': Colors.green,
  'B': Colors.cyan,
  'C': Colors.blue,
  'D': Colors.purpleAccent, //magenta,
  'E': Colors.red.shade900, //dark red,
  'F': Colors.yellow, //dark yellow,
  'G': Colors.green.shade900, //dark green,
  'H': Colors.cyan.shade900, //dark cyan,
  'I': Colors.blue.shade900, //dark blue,
  'J': Colors.purple, //dark magenta
  'K': Colors.orange,
  'L': Colors.deepOrange,
  'M': Colors.orangeAccent,
  'N': Colors.brown,
  'O': Colors.brown.shade900,
  '#': Colors.grey.shade300,
};

Future<Uint8List> binary2image(String input, bool squareFormat, bool invers) async {
  var filter = _buildFilter(input);
  if (filter.length < 2) return null;

  if (!squareFormat) filter += "\n";
  input = _filterInput(input, filter);

  if (invers)
    input = substitution(input, {filter[0]: '1', filter[1]: '0'});
  else
    input = substitution(input, {filter[0]: '0', filter[1]: '1'});

  if (squareFormat) {
    var size = sqrt(input.length).ceil();
    input = insertSpaceEveryNthCharacter(input, size);
    input = input.replaceAll(RegExp('[ ]'), '\n');
  }

  return await _binary2Image(input);
}

Future<Uint8List> byteColor2image(String input) async {
  return await _binary2Image(input);
}

String _buildFilter(String input) {
  var alphabet = removeDuplicateCharacters(input);
  alphabet = alphabet.replaceAll(RegExp('[\r\n\t]'), '');
  var alphabetTmp = alphabet.split('').toList();
  alphabetTmp.sort();
  alphabet = alphabetTmp.join();

  if (alphabet.length <= 2) {
    return alphabet;
  }

  if (alphabet.length == 3 && alphabet.contains(' ')) return alphabet.replaceAll(' ', '');

  var filter = '';
  var map = Map<String, int>();

  alphabet.split('').forEach((char) {
    map.addAll({char: char.allMatches(input).length});
  });

  var countList = map.values.toList();
  countList.sort();

  for (int i = 0; i < countList.length; i++) {
    map.forEach((key, value) {
      if (value == countList[i]) filter += key;
    });
    map.removeWhere((key, value) => value == countList[i]);
  }
  filter = filter.split('').reversed.join();

  filter = filter.substring(0, 3);
  if (filter.contains(' '))
    return filter.replaceAll(' ', '');
  else
    return filter.substring(0, 2);
}

String _filterInput(String input, String filter) {
  var special = ".\$*+-?";
  special.split('').forEach((char) {
    filter = filter.replaceAll(char, '\\' + char);
  });

  return input.replaceAll(RegExp('[^$filter]'), '');
}

Future<Uint8List> _binary2Image(String input) async {
  if (input == '' || input == null) return null;

  var lines = input.split('\n');

  if (lines.length == 1)
    lines.addAll([lines[0], lines[0], lines[0], lines[0], lines[0], lines[0], lines[0], lines[0], lines[0]]);
  return input2Image(lines);
}

Future<Uint8List> input2Image(List<String> lines,
    {Map<String, Color> colors, int bounds = 10, double pointSize = 5.0}) async {
  var width = 0.0;
  var height = 0.0;

  if (lines == null) return null;

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
  if (colors == null) colors = colorMap;
  for (int row = 0; row < lines.length; row++) {
    for (int column = 0; column < lines[row].length; column++) {
      paint.color = Colors.white;
      if (colors.containsKey(lines[row][column])) paint.color = colors[lines[row][column]];

      if (lines[row][column] != '0')
        canvas.drawRect(
            Rect.fromLTWH(column * pointSize + bounds, row * pointSize + bounds, pointSize, pointSize), paint);
    }
  }

  final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);

  return trimNullBytes(data.buffer.asUint8List());
}
