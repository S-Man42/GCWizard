import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';

List<String> decenary2segments(String decenary, bool original, CCITTCodebook language) {
  // 0 ... 31 => 00000 ... 11111
  String binary = convertBase(decenary, 10, 2);
  switch (language) {
    case CCITTCodebook.BAUDOT:
    case CCITTCodebook.MURRAY:
    case CCITTCodebook.SIEMENS:
    case CCITTCodebook.WESTERNUNION:
    case CCITTCodebook.BAUDOT_54123:
    case CCITTCodebook.CCITT_ITA1_1926:
    case CCITTCodebook.CCITT_ITA1_1929:
    case CCITTCodebook.CCITT_ITA1_EU:
    case CCITTCodebook.CCITT_ITA1_UK:
    case CCITTCodebook.CCITT_ITA2_1929:
    case CCITTCodebook.CCITT_ITA2_1931:
    case CCITTCodebook.CCITT_ITA2_MTK2:
    case CCITTCodebook.CCITT_ITA2_USTTY:
      binary = binary.padLeft(5, '0');
      break;
    case CCITTCodebook.CCITT_ITA4:
      binary = binary.padLeft(6, '0');
      break;
    case CCITTCodebook.CCITT_ITA3:
    case CCITTCodebook.CCITT_IA5:
      binary = binary.padLeft(7, '0');
      break;
  }

  if (original)
    binary = binary.split('').reversed.join('');
  List<String> result = [];
  for (int i = 0; i < binary.length; i++) if (binary[i] == '1') result.add((i + 1).toString());
  return result;
}

List<String> binary2segments(String binary, bool original, CCITTCodebook language) {
  // 00000 ... 11111 => [1,2,3,4,5]
  switch (language) {
    case CCITTCodebook.BAUDOT:
    case CCITTCodebook.MURRAY:
    case CCITTCodebook.SIEMENS:
    case CCITTCodebook.WESTERNUNION:
    case CCITTCodebook.BAUDOT_54123:
    case CCITTCodebook.CCITT_ITA1_1926:
    case CCITTCodebook.CCITT_ITA1_1929:
    case CCITTCodebook.CCITT_ITA1_EU:
    case CCITTCodebook.CCITT_ITA1_UK:
    case CCITTCodebook.CCITT_ITA2_1929:
    case CCITTCodebook.CCITT_ITA2_1931:
    case CCITTCodebook.CCITT_ITA2_MTK2:
    case CCITTCodebook.CCITT_ITA2_USTTY:
      binary = binary.padLeft(5, '0');
      break;
    case CCITTCodebook.CCITT_ITA4:
      binary = binary.padLeft(6, '0');
      break;
    case CCITTCodebook.CCITT_ITA3:
    case CCITTCodebook.CCITT_IA5:
      binary = binary.padLeft(7, '0');
      break;
  }
  List<String> result = [];
  if (original)
    binary = binary.split('').reversed.join('');
  for (int i = 0; i < binary.length; i++) if (binary[i] == '1') result.add((i + 1).toString());
  return result;
}

String segments2binary(List<String> segments, CCITTCodebook language) {
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

  if (language == CCITTCodebook.CCITT_ITA3 || language == CCITTCodebook.CCITT_IA5) {
    if (segments.contains('6'))
      result = result + '1';
    else
      result = result + '0';

    if (segments.contains('7'))
      result = result + '1';
    else
      result = result + '0';
  }

  if (language == CCITTCodebook.CCITT_ITA4) {
    if (segments.contains('6'))
      result = result + '1';
    else
      result = result + '0';
  }

  return result;
}

String segments2decenary(List<String> segments, bool original, CCITTCodebook language) {
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

  if (language == CCITTCodebook.CCITT_ITA3 || language == CCITTCodebook.CCITT_IA5) {
    if (segments.contains('6'))
      result = result + '1';
    else
      result = result + '0';

    if (segments.contains('7'))
      result = result + '1';
    else
      result = result + '0';
  }

  if (language == CCITTCodebook.CCITT_ITA4) {
    if (segments.contains('6'))
      result = result + '1';
    else
      result = result + '0';
  }

  if (original)
    result = result.split('').reversed.join('');
  return convertBase(result, 2, 10);
}

List<List<String>> encodePunchtape(String input, CCITTCodebook language, bool original) {
  if (input == null) return [];

  List<List<String>> result = [];
  List<String> code = [];

  code = encodeCCITT(input, language).split(' ');

  code.forEach((element) {
    if (int.tryParse(element) != null)
    result.add(decenary2segments(element, original, language));
  });
  return result;
}

Map<String, dynamic> decodeTextPunchtape(String inputs, CCITTCodebook language, bool original) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };
  var displays = <List<String>>[];
  List<String> text = [];
  List<int> intList = List<int>(1);

  inputs.split(' ').forEach((element) {
    displays.add(binary2segments(element, original, language));
    if (int.tryParse(convertBase(element, 2, 10)) != null) {
      intList[0] = int.parse(convertBase(element, 2, 10));
      text.add(decodeCCITT(intList, language));
    }
  });
  return {'displays': displays, 'text': text.join('')};
}

Map<String, dynamic> decodeVisualPunchtape(List<String> inputs, CCITTCodebook language, bool original) {
  if (inputs == null || inputs.length == 0) return {'displays': <List<String>>[], 'text': ''};

  var displays = <List<String>>[];

  List<String> text = inputs.where((input) => input != null).map((input) {
    var display = <String>[];

    input.split('').forEach((element) {
      display.add(element);
    });
    displays.add(display);

  }).toList();

  // convert list of displays to list of decimal using String segments2decenary(List<String> segments)
  List<int> intList = [];
  displays.forEach((element) {
    intList.add(int.parse(segments2decenary(element, original, language)));
  });

  // convert list of decimal to character using String decodeCCITT(List<int> values, CCITTCodebook language)
  return {'displays': displays, 'text': decodeCCITT(intList, language)};
}
