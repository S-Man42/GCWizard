import 'dart:typed_data';

import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_blocker_builder.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/common_utils.dart';

// https://github.com/sebbeobe/piet_message_generator


Uint8List generatePiet(String input) {
  List<List<int>> result;
  var i = 0;
  input
      .split('')
  .forEach((char) {
    var block = draw_block(char.runes.first, i);
      i++;
      if (result == null)
        result = block;
      else
        for (var x=0; x < result.length; x++)
          result[x].addAll(block[x]);
  });
  var block = draw_end(i);
  if (result == null)
    result = block;
  else
    for (var x=0; x < result.length; x++)
      result[x].addAll(block[x]);

  var lines = <String>[];
  var colorMap = Map<String, int>();
  var mapList = switchMapKeyValue(alphabet_AZ);

  for (var i = 0; i < knownColours.length; i++)
    knownColours.forEach((color) {

    colorMap.addAll([mapList[i]: new Colour(knownColours[i]]));
  });

  result.forEach((line) {
    var row ='';
    line.forEach((pixel) {
      row += Alphabet. knownColours.indexOf(pixel);
    });
  });

  input2Image(result, colors: knowcolors, )
  for (var x = 0; x < result.length; x++)
    result[x].addAll(block[x]);
}

class ColorStack {
  var color_table = <int>[];
  // public Color() {
  //   if (color_table == null) {
  //     color_table = new List<object> {
  //       1,
  //   0
  //   };
  //   } else {
  //   color_table = color_table;
  //   }
  // }

  int RGB() {
    if (color_table[1] == 0) {
      //Red
      if (color_table[0] == 0)
        //Light
        return knownColours[0];
      else if (color_table[0] == 1)
        //Normal
        return knownColours[1];
      else if (color_table[0] == 2)
        //Dark
        return knownColours[2];
    } else if (color_table[1] == 1) {
      //Yellow
      if (color_table[0] == 0)
        //Light
        return knownColours[3];
      else if (color_table[0] == 1)
        //Normal
        return knownColours[4];
      else if (color_table[0] == 2)
        //Dark
        return knownColours[5];
    } else if (color_table[1] == 2) {
      //Green
      if (color_table[0] == 0)
        //Light
        return knownColours[6];
      else if (color_table[0] == 1)
        //Normal
        return knownColours[7];
      else if (color_table[0] == 2)
        //Dark
        return knownColours[8];
    } else if (color_table[1] == 3) {
      //Cyan
      if (color_table[0] == 0)
        //Light
        return knownColours[9];
      else if (color_table[0] == 1)
        //Normal
        return knownColours[10];
      else if (color_table[0] == 2)
        //Dark
        return knownColours[11];
    } else if (color_table[1] == 4) {
      //Blue
      if (color_table[0] == 0)
        //Light
        return knownColours[12];
      else if (color_table[0] == 1)
        //Normal
        return knownColours[13];
      else if (color_table[0] == 2)
        //Dark
        return knownColours[14];
    } else if (color_table[1] == 5) {
      //Magenta
      if (color_table[0] == 0)
        //Light
        return knownColours[15];
      else if (color_table[0] == 1)
        //Normal
        return knownColours[16];
      else if (color_table[0] == 2)
        //Dark
        return knownColours[17];
    }
  }

  int push_color() {
    color_table[0] = (color_table[0] + 1) % 3;
    return RGB();
  }

  int write_color() {
    color_table[0] = (color_table[0] + 2) % 3;
    color_table[1] = (color_table[1] + 5) % 6;
    return RGB();
  }
}

var current_color = ColorStack();

var piet_painting = <dynamic>[];
final blockSize = 12;

List<List<int>>  draw_block(int size, int num) {
  final blockWidth = 12;
  var block = List.filled(blockSize * blockWidth, knownColours[19]); // black
  if (num != 0) {
    var old_push_color = current_color.push_color();
    current_color.write_color();
    block.first = old_push_color;
    //block.fillRange(1, block.length, current_color.RGB());
    size = size + 1;
  } else {
    block.first = current_color.RGB();
  }
  block.fillRange(0, (size / blockSize).ceil() * blockSize, current_color.RGB());
  var pix_lft = 144 - size;
  var div = (pix_lft / 12).toInt();
  var rem = pix_lft % 12;
  if (rem != 0)
    block.fillRange(div * blockSize, div * blockSize + rem, knownColours[19]);

  var lines = <List<int>>[];
  for (var i = 0; i < blockSize; i++)
    lines.add(block.sublist(i * blockWidth, (i + 1) * blockWidth));
  return lines;
  var pos_y = blockSize * num;
  var pos_x = 0;
  //piet_painting[pos_x::(pos_x  +  12),pos_y::(pos_y  +  12)] = block;
}


List<List<int>> draw_end(int num) {
  final blockWidth = 5;
  var block = List.filled(blockSize * blockWidth, knownColours[18]); // white
  var old_push_color = current_color.push_color();


  block[_calcIndex(0, 0, blockWidth)] = old_push_color;
  block[_calcIndex(0, 1, 5)] = current_color.write_color();
  block[_calcIndex(0, 3, blockWidth)] = knownColours[19];
  block[_calcIndex(1, 1, blockWidth)] = knownColours[19];
  block[_calcIndex(1, 3, blockWidth)] = knownColours[19];
  block[_calcIndex(2, 0, blockWidth)] = knownColours[19];
  block.fillRange(_calcIndex(2, 1, blockWidth), _calcIndex(2, 4, blockWidth), current_color.write_color());
  block[_calcIndex(2, 4, blockWidth)] = knownColours[19];
  block.fillRange(_calcIndex(3, 1, blockWidth), _calcIndex(3, 4, blockWidth), knownColours[19]);

  var lines = <List<int>>[];
  for (var i = 0; i < blockSize; i++)
    lines.add(block.sublist(i * blockWidth, (i + 1) * blockWidth));

  return lines;
  var pos_y = 12 * num;
  var pos_x = 0;
  //piet_painting[pos_x::(pos_x  +  12),pos_y::(pos_y  +  5)] = block;
}

int _calcIndex(int row, int column, int width) {
  return row * width + column;
}