import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/utils/common_utils.dart';

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

  for (int row = 0; row < lines.length; row++) {
    for (int column = 0; column < lines[row].length; column++) {
      if (lines[row][column] != '0')
        canvas.drawRect(
            Rect.fromLTWH(column * pointSize + bounds, row * pointSize + bounds, pointSize, pointSize), paint);
    }
  }
  ;

  final img = await canvasRecorder.endRecording().toImage(width.floor(), height.floor());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);

  return data.buffer.asUint8List();
}
