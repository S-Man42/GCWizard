
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final CODEBOOK_OHLSEN = {
  '000' : 'Matrosen kommen aus dem Westen.',
  '001' : 'Matrosen kommen aus dem Norden.',
  '002' : 'Matrosen kommen aus dem Süden.',
  '003' : 'Es sind Kriegsschiffe, die gesehen werden.',
  '004' : 'Die Schiffe. die gesehen werden, sind feindlich.',
  '005' : 'Die Schiffe. die gesehen werden, sind dänisch.',
  '006' : 'ad',
  '007' : 'ordflut',
  '010' : '4',
  '011' : 'af',
  '012' : 'ak',
  '013' : 'al',
  '014' : 'alt',
  '015' : 'am',
  '016' : 'an',
  '017' : 'and',
  '020' : '5',
  '021' : 'ap',
  '022' : 'ar',
  '023' : 'arm',
  '024' : 'as',
  '025' : 'at',
  '026' : 'b',
  '027' : 'ba',
  '030' : 'bak',
  '031' : 'bar',
  '032' : 'be',
  '033' : 'beg',
  '034' : 'berg',
  '035' : 'bi',
  '036' : 'bl',
  '037' : 'bland',
  '040' : '6',
  '041' : 'bo',
  '042' : 'bon',
  '043' : 'bor',
  '044' : 'br',
  '045' : 'bref',
  '046' : 'bu',
  '047' : 'by',
  '050' : 'bå',
  '051' : 'bart',
  '052' : 'bä',
  '053' : 'bö',
  '054' : 'bör',
  '055' : 'd',
  '056' : 'da',
  '057' : 'dag',
  '060' : 'dan',
  '061' : 'danfk',
  '062' : 'de',
  '063' : 'del',
  '064' : 'dem',
  '065' : 'den',
  '066' : 'der',
  '067' : 'det',
  '070' : '.',
  '071' : 'di',
  '072' : 'dig',
  '073' : 'din',
  '074' : 'dit',
  '075' : 'do',
  '076' : 'dom',
  '077' : 'fort',
  '100' : '7',
  '101' : 'dr',
  '102' : 'dt',
  '103' : 'du',
  '104' : 'dy',
  '105' : 'då',
  '106' : 'dä',
  '107' : 'där',
  '110' : 'dö',
  '111' : 'död',
  '112' : 'e',
  '113' : 'ed',
  '114' : 'efter',
  '115' : 'el',
  '116' : 'eller',
  '117' : 'eld',
  '120' : 'em',
  '121' : 'en',
  '122' : 'er',
  '123' : 'es',
  '124' : 'et',
  '125' : 'f',
  '126' : 'fn',
  '127' : 'fal',
  '130' : 'faller',
  '131' : 'fan',
  '132' : 'far',
  '133' : 'fat',
  '134' : 'fe',
  '135' : 'fel',
  '136' : 'fi',
  '137' : 'fienden',
  '140' : 'fin',
  '141' : 'fi',
  '142' : 'flagg',
  '143' : 'fo',
  '144' : 'folk',
  '145' : 'for',
  '146' : 'fr',
  '147' : 'fram',
  '150' : 'frå',
  '151' : 'ft',
  '152' : 'full',
  '153' : 'fy',
  '154' : 'få',
  '155' : 'får',
  '156' : 'fä',
  '157' : 'fält',
  '160' : 'fö',
  '161' : 'för',
  '162' : 'g',
  '163' : 'ga',
  '164' : 'gar',
  '165' : 'ge',
  '166' : 'gen',
  '167' : 'ger',
  '170' : 'gi',
  '171' : 'gl',
  '172' : 'gn',
  '173' : 'go',
  '174' : 'god',
  '175' : 'gr',
  '176' : 'gra',
  '177' : 'gt',
  '200' : '8',
  '201' : 'gu',
  '202' : 'gul',
  '203' : 'gå',
  '204' : 'går',
  '205' : 'gä',
  '206' : 'gö',
  '207' : 'gör',
  '210' : 'h',
  '211' : 'ha',
  '212' : 'haf',
  '213' : 'hal',
  '214' : 'hamm',
  '215' : 'han',
  '216' : 'hand',
  '217' : 'har',
  '220' : 'he',
  '221' : 'hel',
  '222' : 'hjelp',
  '223' : 'hem',
  '224' : 'her',
  '225' : 'het',
  '226' : 'hi',
  '227' : 'tal up',
  '228' : 'hin',
  '229' : 'hit',
};


List<List<String>> encodeOhlsenTelegraph(String input) {
  if (input == null || input == '') return <List<String>>[];

  List<List<String>> encodedText = [];
  var CODEBOOK = switchMapKeyValue(CODEBOOK_OHLSEN);

  input.split('').forEach((element) {
    if (CODEBOOK[element] != null)
        encodedText.add(CODEBOOK[element].split(''));
  });
  return encodedText;
}


Map<String, dynamic> decodeVisualOhlsenTelegraph(List<String> inputs) {
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
    if (CODEBOOK_OHLSEN[segmentToCode(segment)] != null)
        text = text + CODEBOOK_OHLSEN[segmentToCode(segment)];
    else
      text = text + UNKNOWN_ELEMENT;
  });

  return {'displays': displays, 'text': text};
}


Map<String, dynamic> decodeTextOhlsenTelegraph(String inputs) {
  if (inputs == null || inputs.length == 0)
    return {
      'displays': <List<String>>[],
      'text': '',
    };

  var displays = <List<String>>[];
  String text = '';

  inputs.split(' ').forEach((element) {
    if (CODEBOOK_OHLSEN[element] != null) {
        text = text + CODEBOOK_OHLSEN[element];
    } else {
      text = text + UNKNOWN_ELEMENT;
    }
    displays.add(_buildShutters(element));
  });
  return {'displays': displays, 'text': text};
}


List<String> _stringToSegment(String input){
  List<String> result = [];
  for (int i = 0; i < input.length / 3; i++) {
    result.add(input.substring(i * 3, i * 3 + 3));
  }
  return result;
}

String segmentToCode(List<String> segment){
  int a = 0;

  if (segment.contains('a1o')) a = a + 100;
  if (segment.contains('a1u')) a = a + 3;
  if (segment.contains('a2o')) a = a + 10;
  if (segment.contains('a2u')) a = a + 40;
  if (segment.contains('b1o')) a = a + 1;
  if (segment.contains('b1u')) a = a + 4;
  if (segment.contains('b2o')) a = a + 20;
  if (segment.contains('b2u')) a = a + 50;
  if (segment.contains('c1o')) a = a + 2;
  if (segment.contains('c1u')) a = a + 5;
  if (segment.contains('c2o')) a = a + 30;
  if (segment.contains('c2u')) a = a + 60;

  if (a < 10)  return '00' + a.toString();
  if (a < 100)  return '0' + a.toString();
  return a.toString();
}


List<String> _buildShutters(String segments){
  List<String> resultElement = [];

  return resultElement;
}
