import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt1.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt2.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';

enum CCITTCodebook { CCITT1, CCITT2 }

Map<CCITTCodebook, Map<String, String>> CCITT_CODEBOOK = {
  CCITTCodebook.CCITT1: {'title': 'telegraph_ccitt_ccitt1_title', 'subtitle': 'telegraph_ccitt_ccitt1_description'},
  CCITTCodebook.CCITT2: {'title': 'telegraph_ccitt_ccitt2_title', 'subtitle': 'telegraph_ccitt_ccitt2_description'},
};

List<String> decenary2segments(String decenary) {
  // 0 ... 31 => 00000 ... 11111
  String binary = convertBase(decenary, 10, 2);
  while (binary.length < 5){
    binary = '0' + binary;
  }
  List<String> result = [];
  for (int i = 0; i < binary.length; i++) if (binary[i] == '1') result.add((i + 1).toString());
  return result;
}

List<String> binary2segments(String binary) {
  // 00000 ... 11111 => [1,2,3,4,5]
  for (int i = 0; i < 5 - binary.length; i++) binary = '0' + binary;
  List<String> result = [];
  for (int i = 0; i < binary.length; i++) if (binary[i] == '1') result.add((i + 1).toString());
  return result;
}

String segments2binary(List<String> segments) {
  // [1,2,3,4,5] => 00000 ... 11111
  String result = '';
  if (segments.contains('1'))
    result = result + '1';
  else
    result = result + '0';
  if (segments.contains('2'))
    result = result + '1';
  else
    result = result + '0';
  if (segments.contains('3'))
    result = result + '1';
  else
    result = result + '0';
  if (segments.contains('4'))
    result = result + '1';
  else
    result = result + '0';
  if (segments.contains('5'))
    result = result + '1';
  else
    result = result + '0';
  return result;
}

String segments2decenary(List<String> segments) {
  // [1,2,3,4,5] => 0 ... 31
  String result = '';
  if (segments.contains('1'))
    result = result + '1';
  else
    result = result + '0';
  if (segments.contains('2'))
    result = result + '1';
  else
    result = result + '0';
  if (segments.contains('3'))
    result = result + '1';
  else
    result = result + '0';
  if (segments.contains('4'))
    result = result + '1';
  else
    result = result + '0';
  if (segments.contains('5'))
    result = result + '1';
  else
    result = result + '0';
  return convertBase(result, 2, 10);
}

List<List<String>> encodeCCITT(String input, CCITTCodebook language) {
  if (input == null) return [];

  List<List<String>> result = [];
  List<String> code = [];

  switch (language) {
    case CCITTCodebook.CCITT1:
      code = encodeCCITT1(input).split(' ');
      break;
    case CCITTCodebook.CCITT2:
      code = encodeCCITT2(input).split(' ');
      break;
  }

  code.forEach((element) {
    if (int.tryParse(element) != null)
    result.add(decenary2segments(element));
  });

  return result;
}

Map<String, dynamic> decodeTextCCITTTelegraph(String inputs, CCITTCodebook language) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };
  var displays = <List<String>>[];
  List<String> text = [];
  List<int> intList = List<int>(1);

  inputs.split(' ').forEach((element) {
    displays.add(binary2segments(element));
    if (int.tryParse(convertBase(element, 2, 10)) != null) {
      intList[0] = int.parse(convertBase(element, 2, 10));
      switch (language) {
        case CCITTCodebook.CCITT1:
          text.add(decodeCCITT1(intList));
          break;
        case CCITTCodebook.CCITT2:
          text.add(decodeCCITT2(intList));
          break;
      }
    }
  });
  return {'displays': displays, 'text': text.join(' ')};
}

Map<String, dynamic> decodeVisualCCITT(List<String> inputs, CCITTCodebook language) {
  if (inputs == null || inputs.length == 0) return {'displays': <List<String>>[], 'text': ''};

  var displays = <List<String>>[];

  List<String> text = inputs.where((input) => input != null).map((input) {
    var display = <String>[];

    input.split('').forEach((element) {
      display.add(element);
    });
    displays.add(display);

    switch (language) {
      case CCITTCodebook.CCITT1:
        return decodeCCITT1([int.parse(segments2decenary(input.split('')))]);
        break;
      case CCITTCodebook.CCITT2:
        return decodeCCITT2([int.parse(segments2decenary(input.split('')))]);
        break;
    }
  }).toList();

  return {'displays': displays, 'text': text.join(' ')};
}
