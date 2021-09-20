// https://archive.org/details/earlyhistoryofda0000holz/page/180/mode/2up
// https://trepo.tuni.fi/bitstream/handle/10024/102557/1513599679.pdf?sequence=1&isAllowed=y
// https://en.wikipedia.org/wiki/Telegraph_code#Edelcrantz_code

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final CODEBOOK_PRUSSIA = {
  '000': '0',
  '701': '1',
  '702': '2',
  '703': '3',
  '704': '4',
  '705': '5',
  '706': '6',
  '707': '7',
  '708': '8',
  '709': '9',
  '710': '10',
  '010': 'A',
  '050': 'B',
  '072': 'C',
  '100': 'D',
  '116': 'E',
  '140': 'F',
  '160': 'G',
  '186': 'H',
  '195': 'I',
  '225': 'K',
  '249': 'L',
  '290': 'M',
  '328': 'N',
  '356': 'O',
  '385': 'P',
  '412': 'Q',
  '418': 'R',
  '439': 'S',
  '498': 'T',
  '550': 'U',
  '575': 'V',
  '608': 'W',
  '015': 'Ä',
  '382': 'Ö',
  '573': 'Ü',
  // codebook classe 5.2

  // page 32
  '610' : 'we',
  '611' : 'wi',
  '612' : 'wl',
  '613' : 'wla',
  '614' : 'wle',
  '615' : 'wli',
  '616' : 'wlo',
  '617' : 'wlu',
  '618' : 'wo',
  '619' : 'wr',
  '620' : 'wra',
  '621' : 'wre',
  '622' : 'wri',
  '623' : 'wro',
  '624' : 'wru',
  '625' : 'wu',
  '626' : 'x',
  '627' : 'xa',
  '628' : 'xe',
  '629' : 'xi',
  '630' : 'xo',
  '631' : 'xu',
  '632' : 'y',
  '633' : 'z',
  '634' : 'za',
  '635' : 'ze',
  '636' : 'zen',
  '637' : 'zer',
  '638' : 'zes',
  '639' : 'zet',
  '640' : 'zev',
  '641' : 'zi',
  '642' : 'zie',
  '643' : 'zien',
  '644' : 'zin',
  '645' : 'zip',
  '646' : 'zir',
  '647' : 'zis',
  '648' : 'zit',
  '649' : 'ziv',
  '650' : 'zo',
  '651' : 'zor',
  '652' : 'zos',
  '653' : 'zot',
  '654' : 'zov',
  '655' : 'zu',
  '656' : 'zw',
  '657' : 'zwa',
  '658' : 'zwe',
  '659' : 'zwi',
  '660' : 'zwo',
  '661' : 'zwu',
  '662': ',',
  '663': '.',
  '664': '?',
  '665': ':',
  '666' : 'Das buchstabierte Wort ist zu Ende',
  '667' : 'Sonntag',
  '668' : 'Montag',
  '669' : 'Dienstag',
  '670' : 'Mittwoch',
  '671' : 'Donnerstag',
  '672' : 'Freitag',
  '673' : 'Samstag',
  '674' : 'Feiertag',
  '675' : 'Januar',
  '676' : 'Februar',
  '677' : 'März',
  '678' : 'April',
  '679' : 'Mai',
  '680' : 'Juni',
  '681' : 'Juli',
  '682' : 'August',
  '683' : 'September',
  '684' : 'Oktober',
  '685' : 'November',
  '686' : 'Dezember',
  '687' : 'ein Uhr',
  '688' : 'zwei Uhr',
  '689' : 'drei Uhr',
  '690' : 'vier Uhr',
  '691' : 'fünf Uhr',
  '692' : 'sechs Uhr',
  '693' : 'sieben Uhr',
  '694' : 'acht Uhr',
  '695' : 'neun Uhr',
  '696' : 'zehn Uhr',
  '697' : 'elf Uhr',
  '698' : 'zwölf Uhr',
  '699' : 'halb',
  '700' : 'viertel',
};

List<List<String>> encodePrussianTelegraph(String input) {
  if (input == null || input == '') return <List<String>>[];

  return input.split('').map((letter) {
    if (switchMapKeyValue(CODEBOOK_PRUSSIA)[letter] != null)
      return switchMapKeyValue(CODEBOOK_PRUSSIA)[letter].split('');
  }).toList();
}


Map<String, dynamic> decodeVisualPrussianTelegraph(List<String> inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };

  var displays = <List<String>>[];
  var segment = <String>[];
  String text = '';

  inputs.forEach((element) {
    segment = _stringToSegment(element);
    displays.add(segment);
    if (CODEBOOK_PRUSSIA[segmentToCode(segment)] != null)
      text = text + CODEBOOK_PRUSSIA[segmentToCode(segment)];
    else
      text = text + UNKNOWN_ELEMENT;
  });

  return {'displays': displays, 'text': text};
}


Map<String, dynamic> decodeTextPrussianTelegraph(String inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };

  var displays = <List<String>>[];
  String text = '';

  inputs.split(' ').forEach((element) {
    if (CODEBOOK_PRUSSIA[element] != null) {
      text = text + CODEBOOK_PRUSSIA[element];
    } else {
      text = text + UNKNOWN_ELEMENT;
    }
    displays.add(_buildShutters(element));
  });
  return {'displays': displays, 'text': text};
}


List<String> _stringToSegment(String input){
  List<String> result = [];
  int j = 0;
  for (int i = 0; i < input.length /2; i++) {
    result.add(input[j] + input[j + 1]);
    j = j + 2;
  }
  return result;
}

String segmentToCode(List<String> segment){
  String a = '0';
  String b = '0';
  String c = '0';

  if (segment.contains('a1') && segment.contains('a6'))         a = '7';
  else if (segment.contains('a2') && segment.contains('a6'))    a = '8';
  else if (segment.contains('a3') && segment.contains('a6'))    a = '9';
  else if (segment.contains('a6')) a = '6';
  else if (segment.contains('a5')) a = '5';
  else if (segment.contains('a4')) a = '4';
  else if (segment.contains('a3')) a = '3';
  else if (segment.contains('a2')) a = '2';
  else if (segment.contains('a1')) a = '1';

  if (segment.contains('b1') && segment.contains('b6'))         b = '7';
  else if (segment.contains('b2') && segment.contains('b6'))    b = '8';
  else if (segment.contains('b3') && segment.contains('b6'))    b = '9';
  else if (segment.contains('b6')) b = '6';
  else if (segment.contains('b5')) b = '5';
  else if (segment.contains('b4')) b = '4';
  else if (segment.contains('b3')) b = '3';
  else if (segment.contains('b2')) b = '2';
  else if (segment.contains('b1')) b = '1';

  if (segment.contains('c1') && segment.contains('c6'))         c = '7';
  else if (segment.contains('c2') && segment.contains('c6'))    c = '8';
  else if (segment.contains('c3') && segment.contains('c6'))    c = '9';
  else if (segment.contains('c6')) c = '6';
  else if (segment.contains('c5')) c = '5';
  else if (segment.contains('c4')) c = '4';
  else if (segment.contains('c3')) c = '3';
  else if (segment.contains('c2')) c = '2';
  else if (segment.contains('c1')) c = '1';

  return a + b + c;
}


List<String> _buildShutters(String segments){
  List<String> resultElement = [];
  if (segments.length == 3) {
    switch (segments[0]) {
      case '1' :
      case '2' :
      case '3' :
      case '4' :
      case '5' :
      case '6' : resultElement.addAll(['a' + segments[0]]);  break;
      case '7' : resultElement.addAll(['a1', 'a6']); break;
      case '8' : resultElement.addAll(['a2', 'a6']); break;
      case '9' : resultElement.addAll(['a3', 'a6']); break;
    }
    switch (segments[1]) {
      case '1' :
      case '2' :
      case '3' :
      case '4' :
      case '5' :
      case '6' : resultElement.addAll(['b' + segments[1]]); break;
      case '7' : resultElement.addAll(['b1', 'b6']); break;
      case '8' : resultElement.addAll(['b2', 'b6']); break;
      case '9' : resultElement.addAll(['b3', 'b6']); break;
    }
    switch (segments[2]) {
      case '1' :
      case '2' :
      case '3' :
      case '4' :
      case '5' :
      case '6' : resultElement.addAll(['c' + segments[2]]); break;
      case '7' : resultElement.addAll(['c1', 'c6']); break;
      case '8' : resultElement.addAll(['c2', 'c6']); break;
      case '9' : resultElement.addAll(['c3', 'c6']); break;
    }
  }
  return resultElement;
}
