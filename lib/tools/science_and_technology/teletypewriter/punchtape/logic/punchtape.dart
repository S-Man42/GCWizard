import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/_common/logic/segment_display.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/_common/logic/teletypewriter.dart';

enum PUNCHTAPE_INTERPRETER_MODE {MODE_54321, MODE_12345, MODE_54123}

List<String> decenary2segments(String decenary, bool order12345, TeletypewriterCodebook language) {
  // 0 ... 31 => 00000 ... 11111
  String? binary = convertBase(decenary, 10, 2).padLeft(BINARY_LENGTH[language]!, '0');
  List<String> result = [];
  if (!order12345) {
    binary = binary.split('').reversed.join('');
  }

  if (REVERSE_CODEBOOK.contains(language)) {
    binary = binary.split('').reversed.join('');
  }
  for (int i = 0; i < binary.length; i++) {
    if (binary[i] == '1') result.add((i + 1).toString());
  }
  return result;
}

List<String> binary2segments(String binary, TeletypewriterCodebook language) {
  // 00000 ... 11111 => [1,2,3,4,5]
  binary = binary.padLeft(BINARY_LENGTH[language]!, '0');

  List<String> result = [];

  for (int i = 0; i < binary.length; i++) {
    if (binary[i] == '1') result.add((i + 1).toString());
  }
  return result;
}

String segments2binary(List<String> segments2convert, TeletypewriterCodebook language, bool order12345) {
  // [1,2,3,4,5] => 00000 ... 11111
  List<String> segments = [];
  if (order12345) {
    segments.addAll(segments2convert);
  } else {
    switch (BINARY_LENGTH[language]) {
      case 5:
        if (segments2convert.contains('1')) segments.add('5');
        if (segments2convert.contains('2')) segments.add('4');
        if (segments2convert.contains('3')) segments.add('3');
        if (segments2convert.contains('4')) segments.add('2');
        if (segments2convert.contains('5')) segments.add('1');
        break;
      case 6:
        if (segments2convert.contains('1')) segments.add('6');
        if (segments2convert.contains('2')) segments.add('5');
        if (segments2convert.contains('3')) segments.add('4');
        if (segments2convert.contains('4')) segments.add('3');
        if (segments2convert.contains('5')) segments.add('2');
        if (segments2convert.contains('6')) segments.add('1');
        break;
      case 7:
        if (segments2convert.contains('1')) segments.add('7');
        if (segments2convert.contains('2')) segments.add('6');
        if (segments2convert.contains('3')) segments.add('5');
        if (segments2convert.contains('4')) segments.add('4');
        if (segments2convert.contains('5')) segments.add('3');
        if (segments2convert.contains('6')) segments.add('2');
        if (segments2convert.contains('7')) segments.add('1');
        break;
      case 8:
        if (segments2convert.contains('1')) segments.add('8');
        if (segments2convert.contains('2')) segments.add('7');
        if (segments2convert.contains('3')) segments.add('6');
        if (segments2convert.contains('4')) segments.add('5');
        if (segments2convert.contains('5')) segments.add('4');
        if (segments2convert.contains('6')) segments.add('3');
        if (segments2convert.contains('7')) segments.add('2');
        if (segments2convert.contains('8')) segments.add('1');
        break;
    }
  }
  String result = '';
  if (segments.contains('1')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (segments.contains('2')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (segments.contains('3')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (segments.contains('4')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (segments.contains('5')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (BINARY_LENGTH[language] == 6) {
    if (segments.contains('6')) {
      result = result + '1';
    } else {
      result = result + '0';
    }
  }

  if (BINARY_LENGTH[language] == 7) {
    if (segments.contains('6')) {
      result = result + '1';
    } else {
      result = result + '0';
    }

    if (segments.contains('7')) {
      result = result + '1';
    } else {
      result = result + '0';
    }
  }

  if (BINARY_LENGTH[language] == 8) {
    if (segments.contains('6')) {
      result = result + '1';
    } else {
      result = result + '0';
    }

    if (segments.contains('7')) {
      result = result + '1';
    } else {
      result = result + '0';
    }

    if (segments.contains('8')) {
      result = result + '1';
    } else {
      result = result + '0';
    }
  }
  return result;
}

String? _segments2decenary(List<String> segments, bool order54321,
 TeletypewriterCodebook language) {
  // [1,2,3,4,5] => 0 ... 31
  String result = '';

  if (segments.contains('1')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (segments.contains('2')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (segments.contains('3')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (segments.contains('4')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (segments.contains('5')) {
    result = result + '1';
  } else {
    result = result + '0';
  }

  if (BINARY_LENGTH[language] == 6) {
    if (segments.contains('6')) {
      result = result + '1';
    } else {
      result = result + '0';
    }
  }

  if (BINARY_LENGTH[language] == 7) {
    if (segments.contains('6')) {
      result = result + '1';
    } else {
      result = result + '0';
    }

    if (segments.contains('7')) {
      result = result + '1';
    } else {
      result = result + '0';
    }
  }

  if (BINARY_LENGTH[language] == 8) {
    if (segments.contains('6')) {
      result = result + '1';
    } else {
      result = result + '0';
    }

    if (segments.contains('7')) {
      result = result + '1';
    } else {
      result = result + '0';
    }

    if (segments.contains('8')) {
      result = result + '1';
    } else {
      result = result + '0';
    }
  }

  if (order54321) result = result.split('').reversed.join('');
  result = result.split('').reversed.join('');
  return convertBase(result, 2, 10);
}

String _build54321FromBaudot(String DecodeInput) {
  List<String> result = [];
  for (var element in DecodeInput.split(' ')) {
    switch (element.length) {
      case 1:
        result.add(element[0]);
        break;
      case 2:
        result.add(element[1] + element[0]);
        break;
      case 3:
        result.add(element[2] + element[1] + element[0]);
        break;
      case 4:
        result.add(element[2] + element[3] + element[1] + element[0]);
        break;
      case 5:
        result.add(element[2] + element[3] + element[4] + element[1] + element[0]);
        break;
      default:
        result.add('');
    }
  }
  return result.join(' ');
}

String mirrorListOfBinary(List<String> binaryList) {
  List<String> result = [];
  for (var element in binaryList) {
    result.add(element.split('').reversed.join(''));
  }
  return result.join(' ');
}

Segments encodePunchtape(String input, TeletypewriterCodebook language, bool order12345) {
  List<List<String>> result = [];
  List<String> code = [];
  code = encodeTeletypewriter(input, language).split(' ');
  for (var element in code) {
    if (int.tryParse(element) != null) result.add(decenary2segments(element, order12345, language));
  }
  return Segments(displays: result);
}

SegmentsText decodeTextPunchtape(String inputs, TeletypewriterCodebook language, bool numbersOnly, PUNCHTAPE_INTERPRETER_MODE interpreterMode) {
  if (inputs.isEmpty) return SegmentsText(displays: [], text: '');

  switch (interpreterMode) {
    case PUNCHTAPE_INTERPRETER_MODE.MODE_54321: break;
    case PUNCHTAPE_INTERPRETER_MODE.MODE_12345:
      if (language == TeletypewriterCodebook.BAUDOT_54123) {
        inputs = _build54321FromBaudot(inputs);
      }
      inputs = mirrorListOfBinary(inputs.split(' '));
      break;
    case PUNCHTAPE_INTERPRETER_MODE.MODE_54123:
      inputs = _build54321FromBaudot(inputs);
      break;
  }

  var displays = <List<String>>[];
  List<int> intList = [];

  inputs.split(' ').forEach((element) {
    var val = int.tryParse(convertBase(element, 2, 10));
    if (val != null) {
      intList.add(val);
    }
  });

  inputs.split(' ').forEach((element) {
    displays.add(binary2segments(element, language));
  });

  return SegmentsText(displays: displays, text: decodeTeletypewriter(intList, language, numbersOnly: numbersOnly));
}

SegmentsText decodeVisualPunchtape(List<String?> inputs, TeletypewriterCodebook language, bool numbersOnly, bool order54321
    ) {
  if (inputs.isEmpty) return SegmentsText(displays: [], text: '');

  var displays = <List<String>>[];

  inputs.where((input) => input != null).forEach((input) {
    var display = <String>[];

    input!.split('').forEach((element) {
      display.add(element);
    });
    displays.add(display);
  });

  // convert list of displays to list of decimal using String segments2decenary(List<String> segments)
  List<int> intList = [];
  for (var element in displays) {
    var value = int.parse(_segments2decenary(element, order54321,
        language) ?? '');
    intList.add(value);
  }

  return SegmentsText(displays: displays, text: decodeTeletypewriter(intList, language, numbersOnly: numbersOnly));
}
