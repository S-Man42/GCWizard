
import 'dart:developer';

import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';

final CODEBOOK_OHLSEN = {
  '000' : 'Seilere sees, som kommme vestlig fra.',
  '001' : 'Seilere sees, som kommer nord fra.',
  '002' : 'Seilere sees, som kommer sydlig fra.',
  '003' : 'Det er Krigsskibe, som sees.',
  '004' : 'Skibene, som sees, ere fiend tlige.',
  '005' : 'Skibene, som sees, ere danske.',
  '006' : 'De Skibe, som sees, bestaae af Orlogsskibe, Fregatter og andre Krigsfartøier og ere i Antal.',
  '007' : 'De Skibe, som sees, ere Orlogsskibe.',
  '008' : 'De Skibe, som sees, ere Fregatter',
  '009' : 'De Skibe, som sees , ere smaa Krigsskibe og bestaae af Brigger og mindre Fartøier.',
  '010' : 'De Skibe, som sees, ere Stevnbevæpnede Roe Fartøier.',
  '011' : 'Med Skibene følge en Transportflaade',
  '012' : 'De signalerede Skibe seile ind efter',
  '013' : 'De signalerede Skibe seile nord efter.',
  '014' : 'De signalerede Skibe styre mod Landet.',
  '015' : 'De signalerede Skibe styre fra Landet.',
  '016' : 'De signalerede Skibe løbe ind i en havn sønden for mig.',
  '017' : 'De signalerede Skibe løbe ind i en havn norden for mig.',
  '018' : 'De fiendtlige Skibe slaaes med vore.',
  '019' : 'Vore Skibe behøve Undsætning og Hielp.',
  '020' : 'Vore Skibe have fordeel før Fienden.',
  '021' : 'Fienden giør Landgang sønden for mig.',
  '022' : 'Fienden giør Landgang norden for mig.',
  '023' : 'Den fiendtlige Landgang skeer med mindre end end 100 Mand. ',
  '024' : 'Den fiendtlige Landgang skeer med over 100 Mand.',
  '025' : 'Den fiendtlige Landgang skeer med nogle Hundrede Mand.',
  '026' : 'Den fiendtlige Landgang skeer med 1000 Mand og derover.',
  '027' : 'Fartøier ere ankomne fra Danmark.',
  '028' : 'Fartøier ere ankomne fra Archangel.',
  '029' : 'Fienden har jaget og taget et af vore Krigsfartøier.',
  '030' : 'Vore Krigsfartøier have bemæstret dem et fiendtligt Fartøi.',
  '031' : 'Fienden jager et -dansk Fartøi, som trænger til Undsæ tning.',
  '032' : 'De signalerede Skibe ere ud af Sigte.',
  '033' : 'De signalerede Skibe holde det krydsende ved Kysten.',
  '034' : 'Den fiendtlige Landgang er bevirket.',
  '035' : 'Den fiendtlige Landgang ere afslaaet.',
  '036' : 'Meer Hielp maa tilsendes Kystbevogterne.',
  '037' : 'Skydning høres sønder fra.',
  '038' : 'Skydning høres nord fra.',
  '039' : 'Signalet kommer fra Hovedstation	A.',
  '040' : 'Signalet kommer fra Hovedstation	B.',
  '041' : 'Signalet kommer fra Hovedstation	C.',
  '042' : 'Signalet kommer fra Hovedstation	D.',
  '043' : 'Signalet kommer fra Hovedstation	E.',
  '044' : 'Signalet kommer fra Hovedstation	F.',
  '045' : 'Signalet kommer fra Hovedstation	G.',
  '046' : 'Signalet kommer fra Hovedstation	H.',
  '047' : 'Signalet kommer fra Hovedstation	I.',
  '048' : 'Signalet kommer fra Hovedstation	K.',
  '049' : '',
  '050' : '',
  '051' : '',
  '052' : '',
  '053' : '',
  '054' : '',
  '055' : '',
  '056' : '',
  '057' : '',
  '058' : '',
  '059' : '',
  '060' : 'Skydning høres vester fra.',
  '061' : 'Nordlandsfarere ere komne nord fra.',
  '062' : 'Nordlandsfarere er kom e syd fra.',
  '063' : 'Det er sandsynlig at Fienden vil giøre an Attaque paa Christiansund.',
  '064' : 'Det er sandsynlig at Fienden vil trænge ind at Fiordene norden for Christiansund.',
  '065' : 'De signalerede Skibe ere Handelsskibe, som seile eller krydse langs Kysten.',
  '066' : 'Fienden begynder Anfaldet.',
  '067' : 'Fienden er tilbagedrevet. ',
  '068' : 'Vi have lidt meget.',
  '069' : 'Vort tab er ubetydeligt.',
  '070' : 'Efterretninger haves, at Fienden har giort et Anfald i Bergens Stift.',
  '071' : 'Efterretninger haves, at Fienden har giort et Anfald i Christiansands Stift.',
  '072' : 'Efterretninger haves, at Fienden har giort et Anfald i Aggershuus Stift.',
  '073' : 'Fienden har seiret.',
  '074' : 'Fienden er afslaaet.',
  '075' : 'Et dansk eller norsk Skib er strandet og gives Hielp.',
  '076' : 'Et fiendtlig Skib er strandet paa Kysten; man beimægtiger sig Vraget og Folkene .',
  '077' : 'Det strandede Skib er betydeligt.',
  '078' : 'Det strandede Skib er ubetydeljgt.',
  '079' : 'En Konvoi ligger færdig, til at omgaae Stat sønder efter.',
  '080' : 'I dette Øieblik afgaar Konvoien sønder efter.',
  '081' : 'I Dag, indtil Øieblikket; have ingen Seilere viist sig paa Kysten.',
  '082' : '',
  '083' : '',
  '084' : '',
  '085' : '',
  '086' : '',
  '087' : '',
  '088' : '',
  '089' : '',
  '090' : '',
  '091' : '',
  '092' : '',
  '093' : '',
  '094' : '',
  '095' : '',
  '096' : '',
  '097' : '',
  '098' : '',
  '099' : '',
  '100' : '',
  '101' : '',
  '102' : '',
  '103' : '',
  '104' : '',
  '105' : '',
  '106' : '',
  '107' : '',
  '108' : '',
  '109' : '',
  '110' : '',
  '111' : '',
  '112' : '',
  '113' : '',
  '114' : '',
  '115' : '',
  '116' : '',
  '117' : '',
  '118' : '',
  '119' : '',
  '120' : '',
  '121' : '',
  '122' : '',
  '123' : '',
  '124' : '',
  '125' : '',
  '126' : '',
  '127' : '',
  '128' : '',
  '129' : '',
  '130' : '',
  '131' : '',
  '132' : '',
  '133' : '',
  '134' : '',
  '135' : '',
  '136' : '',
  '137' : '',
  '138' : '',
  '139' : '',
  '140' : '',
  '141' : '',
  '142' : '',
  '143' : '',
  '144' : '',
  '145' : '',
  '146' : '',
  '147' : '',
  '148' : '',
  '149' : '',
  '150' : '',
  '151' : '',
  '152' : '',
  '153' : '',
  '154' : '',
  '155' : '',
  '156' : '',
  '157' : '',
  '158' : '',
  '159' : '',
  '160' : '',
  '161' : '',
  '162' : '',
  '163' : '',
  '164' : '',
  '165' : '',
  '166' : '',
  '167' : '',
  '168' : '',
  '169' : '',
  '170' : '',
  '171' : '',
  '172' : '',
  '173' : '',
  '174' : '',
  '175' : '',
  '176' : '',
  '177' : '',
  '178' : '',
  '179' : '',
  '180' : '',
  '181' : '',
  '182' : '',
  '183' : '',
  '184' : '',
  '185' : '',
  '186' : '',
  '187' : '',
  '188' : '',
  '189' : '',
  '190' : '',
  '191' : '',
  '192' : '',
  '193' : '',
  '194' : '',
  '195' : '',
  '196' : '',
  '197' : '',
  '198' : '',
  '199' : '',
  '200' : '',
  '201' : '',
  '202' : '',
  '203' : '',
  '204' : '',
  '205' : '',
  '206' : '',
  '207' : '',
  '208' : '',
  '209' : '',
  '210' : '',
  '211' : '',
  '212' : '',
  '213' : '',
  '214' : '',
  '215' : '',
  '216' : '',
  '217' : '',
  '218' : '',
  '219' : '',
  '220' : '',
  '221' : '',
  '222' : '',
  '223' : '',
  '224' : '',
  '225' : '',
  '226' : '',
  '227' : '',
  '228' : '',
  '229' : '',
  '230' : '',
  '231' : '',
  '232' : '',
  '233' : '',
  '234' : '',
  '235' : '',
  '236' : '',
  '237' : '',
  '238' : '',
  '239' : '',
  '240' : '',
  '241' : '',
  '242' : '',
  '243' : '',
  '244' : '',
  '245' : '',
  '246' : '',
  '247' : '',
  '248' : '',
  '249' : '',
  '250' : '',
  '251' : '',
  '252' : '',
  '253' : '',
  '254' : '',
  '255' : '',
  '256' : '',
  '257' : '',
  '258' : '',
  '259' : '',
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
      'codepoints' : '',
    };

  var displays = <List<String>>[];
  List<String> codepoints = [];
  var segment = <String>[];
  String text = '';

  inputs.forEach((element) {
    segment = _stringToSegment(element);
    displays.add(segment);
    codepoints.add(segmentToCode(segment));
    if (CODEBOOK_OHLSEN[segmentToCode(segment)] != null)
        text = text + CODEBOOK_OHLSEN[segmentToCode(segment)];
    else
      text = text + UNKNOWN_ELEMENT;
  });

  return {'displays': displays, 'text': text, 'codepoints': codepoints.join(' ')};
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
  int codepoint = 0;
print('_buildShutters from '+segments);
  if (int.tryParse(segments) != null) {
    codepoint = int.parse(segments);

    switch (codepoint % 10) {
      case 1:
        resultElement.add('b1o');
        codepoint = codepoint - 1;
        break;
      case 2:
        resultElement.add('c1o');
        codepoint = codepoint - 2;
        break;
      case 3:
        resultElement.add('a1u');
        codepoint = codepoint - 3;
        break;
      case 4:
        resultElement.add('b1u');
        codepoint = codepoint - 4;
        break;
      case 5:
        resultElement.add('c1u');
        codepoint = codepoint - 5;
        break;
      case 6:
        resultElement.add('b1o');
        resultElement.add('c1u');
        codepoint = codepoint - 6;
        break;
      case 7:
        resultElement.add('c1o');
        resultElement.add('c1u');
        codepoint = codepoint - 7;
        break;
      case 8:
        resultElement.add('a1u');
        resultElement.add('c1u');
        codepoint = codepoint - 8;
        break;
      case 9:
        resultElement.add('b1u');
        resultElement.add('c1u');
        codepoint = codepoint - 9;
        break;
    }

    if (codepoint >= 200) {
      resultElement.add('a1o');
      codepoint = codepoint - 100;
    }
    if (codepoint == 150) {
      resultElement.add('c2u');
      resultElement.add('b2u');
      resultElement.add('a2u');
      codepoint = codepoint - 1500;
    }
    if (codepoint == 110) {
      if (resultElement.contains('a1o')) {
        resultElement.add('c2u');
        resultElement.add('b2u');
      } else {
        resultElement.add('a1o');
        resultElement.add('a2o');
      }
      codepoint = codepoint - 110;
    }
    if (codepoint == 100) {
      if (resultElement.contains('a1o')) {
        resultElement.add('c2u');
        resultElement.add('a2u');
      } else {
        resultElement.add('a1o');
      }
      codepoint = codepoint - 100;
    }

    switch (codepoint % 100) {
      case 10:
        resultElement.add('a2o');
        codepoint = codepoint - 10;
        break;
      case 20:
        resultElement.add('b2o');
        codepoint = codepoint - 20;
        break;
      case 30:
        resultElement.add('c2o');
        codepoint = codepoint - 30;
        break;
      case 40:
        resultElement.add('a2u');
        codepoint = codepoint - 40;
        break;
      case 50:
        resultElement.add('b2u');
        codepoint = codepoint - 50;
        break;
      case 60:
        resultElement.add('c2u');
        codepoint = codepoint - 60;
        break;
      case 70:
        resultElement.add('b2o');
        resultElement.add('b2u');
        codepoint = codepoint - 70;
        break;
      case 80:
        resultElement.add('b2u');
        resultElement.add('c2o');
        codepoint = codepoint - 80;
        break;
      case 90:
        resultElement.add('c2o');
        resultElement.add('c2u');
        codepoint = codepoint - 90;
        break;
    }
  }
  return resultElement;
}
