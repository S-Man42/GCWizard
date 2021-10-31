
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt1.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt2.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

enum CCITTCodebook { CCITT1, CCITT2 }

Map<CCITTCodebook, Map<String, String>> CCITT_CODEBOOK = {
  CCITTCodebook.CCITT1: {'title': 'telegraph_ccitt_ccitt1_title', 'subtitle': 'telegraph_ccitt_ccitt1_description'},
  CCITTCodebook.CCITT2: {'title': 'telegraph_ccitt_ccitt2_title', 'subtitle': 'telegraph_ccitt_ccitt2_description'},
};

List<String> decenary2segments(String decenary) {
  String binary = convertBase(decenary, 10, 2);
  for (int i = 0; i < 6 - binary.length; i++)
    binary = '0' + binary;
  List<String> result = [];
  for (int i = 0; i < binary.length; i++)
    if (binary[i] == '1')
      result.add((i + 1).toString());
    print('dec2seg '+decenary+' '+binary+' '+result.toString());
  return result;
}

String segments2binary(List<String> segments){
  String result = '';
  if (segments.contains('1')) result = result + '1'; else result = result + '0';
  if (segments.contains('2')) result = result + '1'; else result = result + '0';
  if (segments.contains('3')) result = result + '1'; else result = result + '0';
  if (segments.contains('4')) result = result + '1'; else result = result + '0';
  if (segments.contains('5')) result = result + '1'; else result = result + '0';
  return result;
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
print(input);
  print(code);
  code.forEach((element) {
    print(decenary2segments(element));
    result.add(decenary2segments(element));
  });

  return result;
}

Map<String, dynamic> decodeCCITT(List<String> inputs, CCITTCodebook language) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'chars': [0]
    };

  var displays = <List<String>>[];

  Map<List<String>, String> CODEBOOK = new Map<List<String>, String>();
  switch (language) {
    case CCITTCodebook.CCITT1:

      break;
    case CCITTCodebook.CCITT2:

      break;
  }

  List<String> text = inputs.where((input) => input != null).map((input) {
    var char = '';
    var charH = '';
    var display = <String>[];

    input.split('').forEach((element) {
      display.add(element);
    });

    if (CODEBOOK.map((key, value) =>
        MapEntry(key.join(), value.toString()))[input.split('').join()] ==
        null) {
      char = char + UNKNOWN_ELEMENT;
    } else {
      charH = CODEBOOK.map((key, value) =>
          MapEntry(key.join(), value.toString()))[input.split('').join()];
      char = char + charH;
    }

    displays.add(display);

    return char;
  }).toList();

  return {'displays': displays, 'chars': text};


}

