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
  '258': 'LE',
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
  '929' : 'MELDUNG AN ORTSBEHÖRDE',
  '946': 'HAT ZU ERKENNEN GEGEBEN',
  '970': 'ES BRENNT IN',


  // Telegraphenteile
  '5.24.14.1' : 'KLAPPE',
  '5.24.14.2' : 'LAGERPLATTE',
  '5.24.14.3' : 'LAGERRING',
  '5.24.15.1' : 'GESCHMIEDETER RING DAZU',
  '5.24.15.2' : 'LAPPEN',
  '5.24.15.3' : 'LEITER',
  '5.24.24.1' : 'LEITERBÜGEL',
  '5.24.24.2' : 'LEITERHALTER',
  '5.24.24.3' : 'LEITERHALTER-ZAPFEN',
  '5.24.25.1' : 'LEITUNGSBÜGEL',
  '5.24.25.2' : 'MAST',
  '5.24.25.3' : 'MUTTER, MESSINGENE',
  '5.24.34.1' : 'NIETH ZUM DRAHTSEIL',
  '5.25.24.1' : 'SCHRAUBENMUTTER',
  '5.25.24.2' : 'SPIRALFEDER',
  '5.25.24.3' : 'SPLINT',
  '5.25.25.1' : 'SPUR',
  '5.25.25.2' : 'SPURLAGER',
  '5.25.25.3' : 'SPURZAPFEN',
  '5.25.34.1' : 'STANGE ZUM GEGENGEWICHT',
  '5.25.34.2' : 'STELLSTANGE ZUM FERNROHRLAGER',
  '5.25.34.3' : 'STEUERUNG',
  '5.25.35.1' : 'STEUERUNGSBRETT',
  '5.25.35.2' : 'STEUERUNGSROLLE',
  '5.25.35.3' : 'STEUERUNGSSCHEIBE',
  '5.34.14.1' : 'STIFT ZUM HALSEISENZAPFEN',

  // 15. Redesätze für das Telegraphieren Seite 1 - 3
  // A. Ankündigungen und Benachrichtigungen
  '5.205.2' : 'NICHTS NEUES!',
  '005.2' : 'MELDUNG VON STATION ##',
  '04.35.2' : 'VON DER DIRECTION',
  '004.3' : 'CITISSIME VON STATION ##',
  '04.34.3' : 'CITISSIME VON DER DIRECTION',
  '004.2' : 'DIE DEPESCHE VON STATION ##, WELCHE HIER AUFGENOMMEN WORDEN, WIRD JETZT WEITER GEGEBEN.',
  '004.1' : 'CITISSIME VON STATION ##, WELCHE HIER AUFGENOMMEN WORDEN, WIRD JETZT WEITER GEGEBEN.',
  '04.34.1' : 'DAS HIER AUFGENOMMENE CITISSIME VON DER DIRECTION WIRD JETZT WEITER GEGEBEN.',
  '4.35.10' : 'DER BESCHÄDIGTE TELEGRAPH IST WIEDER HERGESTELLT.',
  '04.24.2' : 'DEIN ZEICHEN IST UNDEUTLICH.',
  '4.300' : 'DU HAST EIN FALSCHES ZEICHEN GEMACHT.',
  '005.3' : 'STATION ## HAT EIN FALSCHES ZEICHEN GEMACHT.',
  '4.14.30' : 'ES SIND HIER FEHLER VORGEFALLEN, DIE DEPESCHE WIRD WIEDER ANGEFANGEN.',
  '4.15.10' : 'WIR WIEDERHOLEN ## ZEICHEN.',
  '04.20' : 'DIE DEPESCHE WIRD ABGEBROCHEN.',
  '4.242.0' : 'FORTSETZUNG DER ABGEBROCHENEN DEPESCHE.',
  '5.204.1' : 'DER JETZT BEENDETEN DEPESCHE KOMMT NOCH EINE NACH.',
  '04.30' : 'DIE DEPESCHE IST NICHT VERSTANDEN WORDEN.',
  '5.104.2' : 'DIE DEPESCHE NR. ## IST AN IHREM BESTIMMUNGSORT GELANGT.',
  '5.200' : 'SCHLUSSZEICHEN',
  '5.204.3' : 'HIER IST NICHTS MEHR ZU BERICHTEN.',

  '4.35.1' : 'AN DIE DIRECTION',
  '4.35.34.2' : 'HERZOG',
  '5.34.39' : 'GEHALTEN',
  '5.35.35' : 'HIER',
  '5.24.21' : 'FORST',
  '4.174.3' : 'JAGD',
  '74.35.1' : 'STATION',
  '4.15.18' : 'DEN',
  '5.15.19' : 'GEFALLEN',
  '65.14.3' : 'TELEGRAPHEN',
  '85.34.3' : 'WOHL',
  '5.34.35' : 'GUTE',
  '5.395.2' : 'RICHTUNG',
  '5.265.3' : 'PÜNKTLICHEN',
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
  String decodedElement = '';
  inputs.replaceAll('A', '').replaceAll('a', '')
      .replaceAll('B', '').replaceAll('b', '')
      .replaceAll('C', '').replaceAll('c', '')
      .split(' ').forEach((element) {
    //check for messages with station number: xy(5.2|5.3|4.1|4.3)
    if (element.length == 5) {
      if (int.tryParse(element.substring(0,2)) != null && (element.endsWith('5.2') || element.endsWith('5.3') || element.endsWith('4.1')  || element.endsWith('4.2') || element.endsWith('4.3'))) {
        text = text + CODEBOOK_PRUSSIA['00' + element.substring(2)].replaceAll('##', element.substring(0,2));
      }
    } else if (CODEBOOK_PRUSSIA[element] != null) {
      decodedElement = CODEBOOK_PRUSSIA[element];
      if (decodedElement.contains('##')) {
        decodedElement = _replaceNumber(decodedElement, element);
      }
      text = text + decodedElement;
    } else {
      text = text + UNKNOWN_ELEMENT;
    }
    displays.add(_buildShutters(element));
  });
  return {'displays': displays, 'text': text};
}

String _replaceNumber(String plainText, code){
  String number = '++';
  print(code);
  return plainText.replaceAll('##', number);
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
        } else a = '1.' + a; break;
      case 'a2' : if (firstA) {
          a = '2';
          firstA = false;
        } else a = '2.' + a; break;
      case 'a3' : if (firstA) {
          a = '3';
          firstA = false;
        } else a = '3.' + a; break;
      case 'a4' : if (firstA) {
          a = '4';
          firstA = false;
        } else a = '4.' + a; break;
      case 'a5' : if (firstA) {
          a = '5';
          firstA = false;
        } else a = '5.' + a; break;
      case 'a6' : if (firstA) {
          a = '6';
          firstA = false;
        } else a = '6.' + a; break;
      case 'b1' : if (firstB) {
        b = '1';
        firstB = false;
      } else b = '1.' + b; break;
      case 'b2' : if (firstB) {
        b = '2';
        firstB = false;
      } else b = '2.' + b; break;
      case 'b3' : if (firstB) {
          b = '3';
          firstB = false;
        } else b = '3.' + b; break;
      case 'b4' : if (firstB) {
          b = '4';
          firstB = false;
        } else b = '4.' + b; break;
      case 'b5' : if (firstB) {
          b = '5';
          firstB = false;
        } else b = '5.' + b; break;
      case 'b6' : if (firstB) {
          b = '6';
          firstB = false;
        } else b = '6.' + b; break;
      case 'c1' : if (firstC) {
          c = '1';
          firstC = false;
        } else c = '1.' + c; break;
      case 'c2' : if (firstC) {
          c = '2';
          firstC = false;
        } else c = '2.' + c; break;
      case 'c3' : if (firstC) {
          c = '3';
          firstC = false;
        } else c = '3.' + c; break;
      case 'c4' : if (firstC) {
          c = '4';
          firstC = false;
        } else c = '4.' + c; break;
      case 'c5' : if (firstC) {
          c = '5';
          firstC = false;
        } else c = '5.' + c; break;
      case 'c6' : if (firstC) {
          c = '6';
          firstC = false;
        } else c = '6.' + c; break;
    }
  }

  return a + b + c;
}


List<String> _buildShutters(String input){
  List<String> resultElement = [];

  String segments = input;
  String level = 'A1';

  while (segments.length > 0) {
    if (level == 'A2' && segments[0] != '.')
      level = 'B1';
    if (segments[0] == '.' && level == 'A2') {
      if (segments.length > 1)
        segments = segments.substring(1);
    }
    if (level == 'B2' && segments[0] != '.')
      level = 'C1';
    if (segments[0] == '.' && level == 'B2') {
      if (segments.length > 1)
        segments = segments.substring(1);
    }

    switch (level) {
      case 'A1' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['a' + segments[0]]);
            break;
          case '7' :
            resultElement.addAll(['a1', 'a6']);
            break;
          case '8' :
            resultElement.addAll(['a2', 'a6']);
            break;
          case '9' :
            resultElement.addAll(['a3', 'a6']);
            break;
          case '0' :
          case '.' :
            break;
        }
        segments = segments.substring(1);
        level = 'A2';
        break;

      case 'A2' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['a' + segments[0]]);
            break;
          case '7' :
            resultElement.addAll(['a1', 'a6']);
            break;
          case '8' :
            resultElement.addAll(['a2', 'a6']);
            break;
          case '9' :
            resultElement.addAll(['a3', 'a6']);
            break;
          case '.' :
            break;
        }
        segments = segments.substring(1);
        level = 'B1';
        break;
      case 'B1' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['b' + segments[0]]);
            break;
          case '7' :
            resultElement.addAll(['b1', 'b6']);
            break;
          case '8' :
            resultElement.addAll(['b2', 'b6']);
            break;
          case '9' :
            resultElement.addAll(['b3', 'b6']);
            break;
          case '.' :
            break;
        }
        segments = segments.substring(1);
        level = 'B2';
        break;
      case 'B2' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['b' + segments[0]]);
            break;
          case '7' :
            resultElement.addAll(['b1', 'b6']);
            break;
          case '8' :
            resultElement.addAll(['b2', 'b6']);
            break;
          case '9' :
            resultElement.addAll(['b3', 'b6']);
            break;
          case '.' :
            break;
        }
        segments = segments.substring(1);
        level = 'C1';
        break;
      case 'C1' :
      case 'C2' :
        switch (segments[0]) {
          case '1' :
          case '2' :
          case '3' :
          case '4' :
          case '5' :
          case '6' :
            resultElement.addAll(['c' + segments[0]]);
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
        segments = segments.substring(1);
        break;
    }
  }
  return resultElement;
}
