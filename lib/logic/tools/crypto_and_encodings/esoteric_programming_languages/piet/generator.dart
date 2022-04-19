//source: https://github.com/sebbeobe/piet_message_generator

import 'dart:math';
import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_blocker_builder.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:tuple/tuple.dart';

final _blockHeight = 12;
final _blockWidth = 12;

final int _white = knownColors.elementAt(18);
final int _black = knownColors.elementAt(19);
_colorStack _currentColor;

Future<Uint8List> generatePiet(String input) async {
  var result = <MapEntry<int, List<int>>>[];

  _currentColor = _colorStack();
  var i = 0;
  input
      .split('')
      .forEach((char) {
    var block = _drawBlock(char.runes.first, i);
    i++;
    result.add(block);
  });
  result.add(_drawEndBlock(i));


  var resultLines =  <List<int>>[];
  var index = 0;
  var rowOffset = 0;
  result.forEach((mapEntry) {
    if (index< 3) {
      mapEntry.value[0].first = mapEntry.key;
      for (var row = 0; row < mapEntry.value.length; row++) {
        if (resultLines.length <= rowOffset + row) resultLines.add(<int>[]);

        resultLines[rowOffset + row].addAll(mapEntry.value[row]);
      }
    } else {
      rowOffset = 12;
      // if (result.last == mapEntry)
      //   mapEntry.value[0].first = mapEntry.key;
      // else
      //   mapEntry.value[0].last = mapEntry.key;

      for (var row = 0; row < mapEntry.value.length; row++) {
        if (resultLines.length <= rowOffset + row) resultLines.add(<int>[]);

        if (result.last == mapEntry)
          resultLines[rowOffset + row].insertAll(0, mapEntry.value[row].reversed);
        else
          resultLines[rowOffset + row].insertAll(0, mapEntry.value[row]);
      }
    }
    index++;
  });



  var lines = <String>[];
  var colorMap = Map<String, Color>();
  var colorMapSwitched = Map<int, String>();
  var mapList = switchMapKeyValue(alphabet_AZ);


  for (var i = 0; i < knownColors.length; i++) {
    colorMap.addAll({mapList[i + 1]: Color(knownColors.elementAt(i) | 0xFF000000)}); // | 0xFF000000
    colorMapSwitched.addAll({knownColors.elementAt(i): mapList[i + 1]});
  };

  resultLines.forEach((line) {
    var row ='';
    line.forEach((color) {
      row += colorMapSwitched[color];
    });
    lines.add(row);
  });

  return input2Image(lines, colors: colorMap, bounds: 0, pointSize: 1);
}

Alignment _getNextBlockDirection(int row, int column, List<List<int>> outputArrangement) {
  var index = outputArrangement[row][column] + 1;

  if ((column+1 < outputArrangement[row].length) && (outputArrangement[row][column+1] == index))
    return Alignment.topRight;
  else if ((row+1 < outputArrangement.length) && (outputArrangement[row+1][column] == index))
    return Alignment.bottomRight;
  else if ((column-1 >= 0) && (outputArrangement[row][column-1] == index))
    return Alignment.bottomLeft;
  else if ((row-1 >= 0) && (outputArrangement[row-1][column] == index))
    return Alignment.topLeft;
}

List<List<int>> _calcOutputArrangement(int blockCount) {
  var sqr = sqrt(blockCount);
  var columnCount = blockCount <= 2 ? 2 : blockCount <= 4 ? 2 : sqr.ceil();
  var rowCount = (blockCount/ columnCount).ceil();
  var lines = <List<int>>[];

  var direction = Alignment.topRight;
  var row = 0;
  var column = 0;
  for (var i=0; i< rowCount * columnCount; i++)
    lines.add(List.filled(columnCount, -1));

  for (var i=0; i< rowCount * columnCount; i++) {
    lines[column][row] = i;

    if (direction == Alignment.topRight) {
      column++;
      if ((column >= columnCount) || (lines[column][row] != -1)) {
        direction = Alignment.bottomRight;
        row++;
        column--;
      }
    } else if (direction == Alignment.bottomRight) {
      row++;
      if ((row >= rowCount) || (lines[column][row] != -1)) {
        direction = Alignment.bottomLeft;
        row--;
        column--;
      }
    } else if (direction == Alignment.bottomLeft) {
      column--;
      if ((column < 0) || (lines[column][row] != -1)) {
        direction = Alignment.topLeft;
        row--;
        column++;
      }
    } else if (direction == Alignment.topLeft) {
      row--;
      if ((row < 0) || (lines[column][row] != -1)) {
        direction = Alignment.topRight;
        row++;
        column++;
      }
    }
  }
}

int _searchLastWhitePixelIndex(List<int> block, Alignment alignment) {
  int index;
  int index1;
  if (alignment == Alignment.topRight) {
    for (var i = _blockWidth-2; i >= 0; i--) {
      index = _calcIndex(0, i, _blockWidth);
      index1 = _calcIndex(0, i+1, _blockWidth);
      if ((block[index] != _white) && (block[index1] == _white)) {
        return index1;
      } else if ((block[index] != _white) && (block[index1] != _white))
        return -1;
    }
    return _calcIndex(0, 0, _blockWidth);
  } else if (alignment == Alignment.bottomRight) {
    for (var i = _blockHeight-2; i >= 0; i--) {
      index = _calcIndex(i, _blockWidth-1, _blockWidth);
      index1 = _calcIndex(i+1, _blockWidth-1, _blockWidth);
      if ((block[index] != _white) && (block[index+1] == _white)) {
        return index1;
      } else if ((block[index] != _white) && (block[index1] != _white))
        return -1;
    }
    return _calcIndex(0, _blockWidth - 1, _blockWidth);
  } else if (alignment == Alignment.bottomLeft) {
    for (var i = 1; i < _blockWidth-1; i--) {
      index = _calcIndex(_blockHeight-1, i, _blockWidth);
      index1 = _calcIndex(_blockHeight-1, i-1, _blockWidth);
      if ((block[index] != _white) && (block[index1] == _white)) {
        return index1;
      } else if ((block[index] != _white) && (block[index1] != _white))
        return -1;
    }
    return _calcIndex(0, _blockWidth-1, _blockWidth);
  } else if (alignment == Alignment.topLeft) {
    for (var i = 1; i < _blockHeight-1; i--) {
      index = _calcIndex(i, 0, _blockWidth);
      index1 = _calcIndex(i-1, 0, _blockWidth);
      if ((block[index] != _white) && (block[index1] == _white)) {
        return index1;
      } else if ((block[index] != _white) && (block[index1] != _white))
        return -1;
    }
    return _calcIndex(_blockHeight-1, 0, _blockWidth);
  }
}

void _removeLastPixel(List<int> block) {
  var index = block.indexWhere((pixel) => pixel == _white);
  if (index >= 0) {
    var index1 = block.indexWhere((pixel) => (pixel != _white), index);
    if (index1 >= 0) block[index1] = _white;
  } else
    block.last = _white;
}

class _colorStack {
  var _colorTable = [1 ,0];

  int RGB() {
    return knownColors.elementAt(_colorTable[1] * 3 + _colorTable[0]);
  }

  int pushColor() {
    _colorTable[0] = (_colorTable[0] + 1) % 3;
    return RGB();
  }

  int pullColor() {
    _colorTable[0] = (_colorTable[0] + 2) % 3;
    _colorTable[1] = (_colorTable[1] + 5) % 6;
    return RGB();
  }
}


MapEntry<int, List<int>> _drawBlock(int size, int num) {
  var block = List.filled(_blockHeight * _blockWidth, _white);
  int oldPushColor;
  if (num != 0) {
    oldPushColor = _currentColor.pushColor();
    _currentColor.pullColor();
    size++;
  } else
    oldPushColor = _currentColor.RGB();

  var rem = size % _blockWidth;
  var rows = (size / _blockWidth).ceil();
  if (rows > 0) rows--;
  block.fillRange(0, _calcIndex(rows, _blockWidth, _blockWidth), _currentColor.RGB());

  if (rem != 0)
    block.fillRange(_calcIndex(rows, 0, _blockWidth), _calcIndex(rows, _blockWidth - rem, _blockWidth), _white);

  return MapEntry<int, List<int>>(oldPushColor, block);
}

MapEntry<int, List<int>> _drawEndBlock(int num) {
  var block = List.filled(_blockHeight * _blockWidth, _white);
  var oldPushColor = _currentColor.pushColor();

  block[_calcIndex(0, 1, 5)] = _currentColor.pullColor();
  block[_calcIndex(0, 3, _blockWidth)] = _black;
  block[_calcIndex(1, 1, _blockWidth)] = _black;
  block[_calcIndex(1, 3, _blockWidth)] = _black;
  block[_calcIndex(2, 0, _blockWidth)] = _black;
  block.fillRange(_calcIndex(2, 1, _blockWidth), _calcIndex(2, 4, _blockWidth), _currentColor.pullColor());
  block[_calcIndex(2, 4, _blockWidth)] = _black;
  block.fillRange(_calcIndex(3, 1, _blockWidth), _calcIndex(3, 4, _blockWidth), _black);

  return MapEntry<int, List<int>>(oldPushColor, block);
}

MapEntry<int, List<int>> _drawWhiteBlock(int num) {
  var block = List.filled(_blockHeight * _blockWidth, _white);

  return MapEntry<int, List<int>>(_white, block);
}

List<List<int>> _splitToLines(List<int> block, int width) {
  var lines = <List<int>>[];
  for (var i = 0; i < _blockHeight; i++)
    lines.add(block.sublist(i * _blockWidth, (i + 1) * _blockWidth));

  return lines;
}

int _calcIndex(int row, int column, int width) {
  return row * width + column;
}






