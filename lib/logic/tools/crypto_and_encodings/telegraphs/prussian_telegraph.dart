// https://archive.org/details/earlyhistoryofda0000holz/page/180/mode/2up
// https://trepo.tuni.fi/bitstream/handle/10024/102557/1513599679.pdf?sequence=1&isAllowed=y
// https://en.wikipedia.org/wiki/Telegraph_code#Edelcrantz_code

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final CODEBOOK_PRUSSIA = {   // codebook classe 5.2
  '000': '0',
  '010': 'A',
  '015': 'Ä',
  '025': 'AM',
  '026': 'AN',
  '050': 'B',
  '067': 'BRI',
  '072': 'C',
  '100': 'D',
  '116': 'E',
  '124': 'EIN',
  '140': 'F',
  '160': 'G',
  '162': 'GE',
  '186': 'H',
  '195': 'I',
  '212': 'IM',
  '213': 'IN',
  '225': 'K',
  '249': 'L',
  '290': 'M',
  '328': 'N',
  '356': 'O',
  '382': 'Ö',
  '385': 'P',
  '412': 'Q',
  '418': 'R',
  '439': 'S',
  '498': 'T',
  '550': 'U',
  '562': 'UND',
  '573': 'Ü',
  '575': 'V',
  '608': 'W',

  // page 32
  '610' : 'WE',
  '611' : 'WI',
  '612' : 'WL',
  '613' : 'WLA',
  '614' : 'WLE',
  '615' : 'WLI',
  '616' : 'WLO',
  '617' : 'WLU',
  '618' : 'WO',
  '619' : 'WR',
  '620' : 'WRA',
  '621' : 'WRE',
  '622' : 'WRI',
  '623' : 'WRO',
  '624' : 'WRU',
  '625' : 'WU',
  '626' : 'X',
  '627' : 'XA',
  '628' : 'XE',
  '629' : 'XI',
  '630' : 'XO',
  '631' : 'XU',
  '632' : 'Y',
  '633' : 'Z',
  '634' : 'ZA',
  '635' : 'ZE',
  '636' : 'ZEN',
  '637' : 'ZER',
  '638' : 'ZES',
  '639' : 'ZET',
  '640' : 'ZEV',
  '641' : 'ZI',
  '642' : 'ZIE',
  '643' : 'ZIEN',
  '644' : 'ZIN',
  '645' : 'ZIP',
  '646' : 'ZIR',
  '647' : 'ZIS',
  '648' : 'ZIT',
  '649' : 'ZIV',
  '650' : 'ZO',
  '651' : 'ZOR',
  '652' : 'ZOS',
  '653' : 'ZOT',
  '654' : 'ZOV',
  '655' : 'ZU',
  '656' : 'ZW',
  '657' : 'ZWA',
  '658' : 'ZWE',
  '659' : 'ZWI',
  '660' : 'ZWO',
  '661' : 'ZWU',
  '662': ',',
  '663': '.',
  '664': '?',
  '665': ':',
  '666' : 'DAS BUCHSTABIERTE WORT IST ZU ENDE',
  '667' : 'SONNTAG',
  '668' : 'MONTAG',
  '669' : 'DIENSTAG',
  '670' : 'MITTWOCH',
  '671' : 'DONNERSTAG',
  '672' : 'FREITAG',
  '673' : 'SAMSTAG',
  '674' : 'FEIERTAG',
  '675' : 'JANUAR',
  '676' : 'FEBRUAR',
  '677' : 'MÄRZ',
  '678' : 'APRIL',
  '679' : 'MAI',
  '680' : 'JUNI',
  '681' : 'JULI',
  '682' : 'AUGUST',
  '683' : 'SEPTEMBER',
  '684' : 'OKTOBER',
  '685' : 'NOVEMBER',
  '686' : 'DEZEMBER',
  '687' : 'EIN UHR',
  '688' : 'ZWEI UHR',
  '689' : 'DREI UHR',
  '690' : 'VIER UHR',
  '691' : 'FÜNF UHR',
  '692' : 'SECHS UHR',
  '693' : 'SIEBEN UHR',
  '694' : 'ACHT UHR',
  '695' : 'NEUN UHR',
  '696' : 'ZEHN UHR',
  '697' : 'ELF UHR',
  '698' : 'ZWÖLF UHR',
  '699' : 'HALB',
  '700' : 'VIERTEL',
  // page 33
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
  '946': 'HAT ZU ERKENNEN GEGEBEN',

  '4.35.1' : 'AN DIE DIRECTION',  '3.41.5' : 'AN DIE DIRECTION',
  '4.35.34.2' : 'HERZOG',         '3.43.52.4' : 'HERZOG',
  '5.34.39' : 'GEHALTEN',         '3.53.49' : 'GEHALTEN',
  '5.35.35' : 'HIER',             '3.53.55' : 'HIER',
  '5.24.21' : 'FORST',            '2.52.41' : 'FORST',
  '4.174.3' : 'JAGD',             '1.473.4' : 'JAGD',
  '74.35.1' : 'STATION',          '73.41.5' : 'STATION',
  '4.15.18' : 'DEN',              '1.41.58' : 'DEN',
  '5.15.19' : 'GEFALLEN',         '1.51.59' : 'GEFALLEN',
  '65.14.3' : 'TELEGRAPHEN',      '61.53.4' : 'TELEGRAPHEN',
  '85.34.3' : 'WOHL',             '83.53.4' : 'WOHL',
  '5.34.35' : 'GUTE',             '3.53.45' : 'GUTE',
  '5.395.2' : 'RICHTUNG',         '3.592.5' : 'RICHTUNG',
  '5.265.3' : 'PÜNKTLICHEN',      '2.563.5' : 'PÜNKTLICHEN',
  '5.200' : 'SCHLUSSZEICHEN',     '2.500' : 'SCHLUSSZEICHEN',
  };

final A = ['a1', 'a2', 'a3', 'a4', 'a5', 'a6'];
final B = ['b1', 'b2', 'b3', 'b4', 'b5', 'b6'];
final C = ['c1', 'c2', 'c3', 'c4', 'c5', 'c6'];

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
  String code = '';

  inputs.forEach((element) {
    segment = _stringToSegment(element);
    displays.add(segment);
    code = segmentToCode(segment);
    if (CODEBOOK_PRUSSIA[code] != null)
      text = text + CODEBOOK_PRUSSIA[code];
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
print(inputs);
  inputs.split(' ').forEach((element) {
print(element);
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

String segmentToCode(List<String> input){
  var segment = [];
  segment.addAll(input);
  String a = '0';
  String b = '0';
  String c = '0';

  if (segment.contains('a1') && segment.contains('a6')) {
    a = '7';
    segment.remove('a1');
    segment.remove('a6');
  }
  if (segment.contains('a2') && segment.contains('a6')){
    a = '8';
    segment.remove('a2');
    segment.remove('a6');
  }
  if (segment.contains('a3') && segment.contains('a6')) {
    a = '9';
    segment.remove('a3');
    segment.remove('a6');
  }
  if (segment.contains('b1') && segment.contains('b6')) {
    b = '7';
    segment.remove('b1');
    segment.remove('b6');
  }
  if (segment.contains('b2') && segment.contains('b6')){
    b = '8';
    segment.remove('b2');
    segment.remove('b6');
  }
  if (segment.contains('b3') && segment.contains('b6')) {
    b = '9';
    segment.remove('b3');
    segment.remove('b6');
  }
  if (segment.contains('c1') && segment.contains('c6')) {
    c = '7';
    segment.remove('c1');
    segment.remove('c6');
  }
  if (segment.contains('c2') && segment.contains('c6')){
    c = '8';
    segment.remove('c2');
    segment.remove('c6');
  }
  if (segment.contains('c3') && segment.contains('c6')) {
    c = '9';
    segment.remove('c3');
    segment.remove('c6');
  }
  bool firstA = true;
  bool firstB = true;
  bool firstC = true;
  for (int i  = 0; i < segment.length; i++){
    switch (segment[i]) {
      case 'a1' : if (firstA) {
          a = '1';
          firstA = false;
        } else a = a + '.1'; break;
      case 'a2' : if (firstA) {
          a = '2';
          firstA = false;
        } else a = a + '.2'; break;
      case 'a3' : if (firstA) {
          a = '3';
          firstA = false;
        } else a = a + '.3'; break;
      case 'a4' : if (firstA) {
          a = '4';
          firstA = false;
        } else a = a + '.4'; break;
      case 'a5' : if (firstA) {
          a = '5';
          firstA = false;
        } else a = a + '.5'; break;
      case 'a6' : if (firstA) {
          a = '6';
          firstA = false;
        } else a = a + '.6'; break;
      case 'b1' : if (firstB) {
        b = '1';
        firstB = false;
      } else b = b + '.1'; break;
      case 'b2' : if (firstB) {
        b = '2';
        firstB = false;
      } else b = b + '.2'; break;
      case 'b3' : if (firstB) {
          b = '3';
          firstB = false;
        } else b = b + '.3'; break;
      case 'b4' : if (firstB) {
          b = '4';
          firstB = false;
        } else b = b + '.4'; break;
      case 'b5' : if (firstB) {
          b = '5';
          firstB = false;
        } else b = b + '.5'; break;
      case 'b6' : if (firstB) {
          b = '6';
          firstB = false;
        } else b = b + '.6'; break;
      case 'c1' : if (firstC) {
          c = '1';
          firstC = false;
        } else c = c + '.1'; break;
      case 'c2' : if (firstC) {
          c = '2';
          firstC = false;
        } else c = c + '.2'; break;
      case 'c3' : if (firstC) {
          c = '3';
          firstC = false;
        } else c = c + '.3'; break;
      case 'c4' : if (firstC) {
          c = '4';
          firstC = false;
        } else c = c + '.4'; break;
      case 'c5' : if (firstC) {
          c = '5';
          firstC = false;
        } else c = c + '.5'; break;
      case 'c6' : if (firstC) {
          c = '6';
          firstC = false;
        } else c = c + '.6'; break;
    }
  }

  return a + b + c;
}


List<String> _buildShutters(String segments){
  List<String> resultElement = [];
  print('buildshutters '+segments);

  String level = 'A1';
  for (int i = 0; i < segments.length; i++){

    if (level == 'A2' && segments[2] != '.')
      level = 'B1';

    if (level == 'B1' && segments[i] != '.')
      level = 'B2';

    switch (level) {
      case 'A1' :
        switch (segments[i]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['a' + segments[i]]);
            level = 'A2';
            break;
          case '7' :
            resultElement.addAll(['a1', 'a6']);
            level = 'A2';
            break;
          case '8' :
            resultElement.addAll(['a2', 'a6']);
            level = 'A2';
            break;
          case '9' :
            resultElement.addAll(['a3', 'a6']);
            level = 'A2';
            break;
          case '.' :
            break;
        }
        break;
      case 'A2' :
        switch (segments[i]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['a' + segments[i]]);
            level = 'B1';
            break;
          case '7' :
            resultElement.addAll(['a1', 'a6']);
            level = 'B1';
            break;
          case '8' :
            resultElement.addAll(['a2', 'a6']);
            level = 'B1';
            break;
          case '9' :
            resultElement.addAll(['a3', 'a6']);
            level = 'B1';
            break;
          case '.' :
            break;
        }
        break;
      case 'B1' :
        switch (segments[i]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['b' + segments[i]]);
            level = 'B2';
            break;
          case '7' :
            resultElement.addAll(['b1', 'b6']);
            level = 'B2';
            break;
          case '8' :
            resultElement.addAll(['b2', 'b6']);
            level = 'B2';
            break;
          case '9' :
            resultElement.addAll(['b3', 'b6']);
            level = 'B2';
            break;
          case '.' :
            break;
        }
        break;
      case 'B2' :
        switch (segments[i]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['b' + segments[i]]);
            level = 'C1';
            break;
          case '7' :
            resultElement.addAll(['b1', 'b6']);
            level = 'C1';
            break;
          case '8' :
            resultElement.addAll(['b2', 'b6']);
            level = 'C1';
            break;
          case '9' :
            resultElement.addAll(['b3', 'b6']);
            level = 'C1';
            break;
          case '.' :
            break;
        }
        break;
      case 'C1' :
      case 'C2' :
        switch (segments[i]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['c' + segments[i]]);
            level = 'C2';
            break;
          case '7' :
            resultElement.addAll(['c1', 'c6']);
            level = 'C2';
            break;
          case '8' :
            resultElement.addAll(['c2', 'c6']);
            level = 'C2';
            break;
          case '9' :
            resultElement.addAll(['c3', 'c6']);
            level = 'C2';
            break;
          case '.' :
            break;
        }
        break;
      case 'C2' :
        switch (segments[i]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['c' + segments[i]]);
            break;
          case '7' :
            resultElement.addAll(['c1', 'c6']);
            break;
          case '8' :
            resultElement.addAll(['c2', 'c6']);
            ;
            break;
          case '9' :
            resultElement.addAll(['c3', 'c6']);
            break;
          case '.' :
            break;
        }
        break;
    }
  }

/*

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
*/

  return resultElement;
}
