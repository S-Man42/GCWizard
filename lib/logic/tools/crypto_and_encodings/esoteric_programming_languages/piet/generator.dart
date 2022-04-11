//source: https://github.com/sebbeobe/piet_message_generator

import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_blocker_builder.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';


Future<Uint8List> generatePiet(String input) async {
  List<List<int>> result;
  _currentColor = _colorStack();
  var i = 0;
  input
    .split('')
    .forEach((char) {
      var block = _drawBlock(char.runes.first, i);
      i++;
      if (result == null)
        result = block;
      else
        for (var x=0; x < result.length; x++)
          result[x].addAll(block[x]);
    });
  var block = _drawEnd(i);
  if (result == null)
    result = block;
  else
    for (var x=0; x < result.length; x++)
      result[x].addAll(block[x]);

  var lines = <String>[];
  var colorMap = Map<String, Color>();
  var colorMapSwitched = Map<int, String>();
  var mapList = switchMapKeyValue(alphabet_AZ);

  for (var i = 0; i < knownColors.length; i++) {
    colorMap.addAll({mapList[i + 1]: Color(knownColors.elementAt(i) | 0xFF000000)}); // | 0xFF000000
    colorMapSwitched.addAll({knownColors.elementAt(i): mapList[i + 1]});
  };

  result.forEach((line) {
    var row ='';
    line.forEach((color) {
      row += colorMapSwitched[color];
    });
    lines.add(row);
  });

  return input2Image(lines, colors: colorMap, bounds: 0, pointSize: 1);
}

class _colorStack {
  var _color_table = {1 ,0}.toList();

  int RGB() {
    return knownColors.elementAt(_color_table[1] * 3 + _color_table[0]);
  }

  int push_color() {
    _color_table[0] = (_color_table[0] + 1) % 3;
    return RGB();
  }

  int write_color() {
    _color_table[0] = (_color_table[0] + 2) % 3;
    _color_table[1] = (_color_table[1] + 5) % 6;
    return RGB();
  }
}

_colorStack _currentColor;

final _blockHeight = 12;
final int _white = knownColors.elementAt(18);
final int _black = knownColors.elementAt(19);


List<List<int>>  _drawBlock(int size, int num) {
  final blockWidth = 12;
  var block = List.filled(_blockHeight * blockWidth, _white);
  if (num != 0) {
    var old_push_color = _currentColor.push_color();
    _currentColor.write_color();
    block[0] = old_push_color;
    size++;
  } else
    block[0] = _currentColor.RGB();

  var rem = size % blockWidth;
  var rows = (size / blockWidth).ceil();
  if (rows > 0) rows--;
  block.fillRange(1, _calcIndex(rows, blockWidth, blockWidth), _currentColor.RGB());

  if (rem != 0)
    block.fillRange(_calcIndex(rows, 0, blockWidth), _calcIndex(rows, blockWidth - rem, blockWidth), _white);

  var lines = <List<int>>[];
  for (var i = 0; i < _blockHeight; i++)
    lines.add(block.sublist(i * blockWidth, (i + 1) * blockWidth));
  return lines;
}


List<List<int>> _drawEnd(int num) {
  final blockWidth = 5;
  var block = List.filled(_blockHeight * blockWidth, _white);
  var oldPushColor = _currentColor.push_color();

  block[_calcIndex(0, 0, blockWidth)] = oldPushColor;
  block[_calcIndex(0, 1, 5)] = _currentColor.write_color();
  block[_calcIndex(0, 3, blockWidth)] = _black;
  block[_calcIndex(1, 1, blockWidth)] = _black;
  block[_calcIndex(1, 3, blockWidth)] = _black;
  block[_calcIndex(2, 0, blockWidth)] = _black;
  block.fillRange(_calcIndex(2, 1, blockWidth), _calcIndex(2, 4, blockWidth), _currentColor.write_color());
  block[_calcIndex(2, 4, blockWidth)] = knownColors.elementAt(19);
  block.fillRange(_calcIndex(3, 1, blockWidth), _calcIndex(3, 4, blockWidth), _black);

  var lines = <List<int>>[];
  for (var i = 0; i < _blockHeight; i++)
    lines.add(block.sublist(i * blockWidth, (i + 1) * blockWidth));

  return lines;
}

int _calcIndex(int row, int column, int width) {
  return row * width + column;
}