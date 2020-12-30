import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/number_sequence.dart';

void main() {
  group("numbersequence.getNumberAt:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'sequence' : NumberSequencesMode.CATALAN,          'position' : 30, 'expectedOutput' : '3814986502092304'},
      {'sequence' : NumberSequencesMode.RECAMAN,          'position' : 30, 'expectedOutput' : '45'},
      {'sequence' : NumberSequencesMode.LUCAS,            'position' : 30, 'expectedOutput' : '1860498'},
      {'sequence' : NumberSequencesMode.FIBONACCI,        'position' : 30, 'expectedOutput' : '832040'},
      {'sequence' : NumberSequencesMode.JACOBSTAHL,       'position' : 30, 'expectedOutput' : '357913941'},
      {'sequence' : NumberSequencesMode.JACOBSTHALLUCAS,  'position' : 30, 'expectedOutput' : '1073741825'},
      {'sequence' : NumberSequencesMode.PELL,             'position' : 30, 'expectedOutput' : '107578520350'},
      {'sequence' : NumberSequencesMode.FERMAT,           'position' : 30, 'expectedOutput' : '1073741825'},
      {'sequence' : NumberSequencesMode.MERSENNE,         'position' : 30, 'expectedOutput' : '1073741823'},
      {'sequence' : NumberSequencesMode.PELLLUCAS,        'position' : 30, 'expectedOutput' : '304278004998'},
    ];

    _inputsToExpected.forEach((elem) {
      test('sequence: ${elem['sequence']}, position: ${elem['position']}', () {
        var _actual = getNumberAt(elem['sequence'], elem['position']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
  group("numbersequence.checkNumber:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'sequence' : NumberSequencesMode.CATALAN,          'expectedOutput' : '30', 'number' : 3814986502092304},
      {'sequence' : NumberSequencesMode.RECAMAN,          'expectedOutput' : '30', 'number' : 45},
      {'sequence' : NumberSequencesMode.LUCAS,            'expectedOutput' : '30', 'number' : 1860498},
      {'sequence' : NumberSequencesMode.FIBONACCI,        'expectedOutput' : '30', 'number' : 832040},
      {'sequence' : NumberSequencesMode.JACOBSTAHL,       'expectedOutput' : '30', 'number' : 357913941},
      {'sequence' : NumberSequencesMode.JACOBSTHALLUCAS,  'expectedOutput' : '30', 'number' : 1073741825},
      {'sequence' : NumberSequencesMode.PELL,             'expectedOutput' : '30', 'number' : 107578520350},
      {'sequence' : NumberSequencesMode.FERMAT,           'expectedOutput' : '30', 'number' : 1073741825},
      {'sequence' : NumberSequencesMode.MERSENNE,         'expectedOutput' : '30', 'number' : 1073741823},
      {'sequence' : NumberSequencesMode.PELLLUCAS,        'expectedOutput' : '30', 'number' : 304278004998},
    ];

    _inputsToExpected.forEach((elem) {
      test('sequence: ${elem['sequence']}, number: ${elem['number']}', () {
        var _actual = checkNumber(elem['sequence'], elem['number']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
  group("numbersequence.getNumbersInRange:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'sequence' : NumberSequencesMode.CATALAN,          'start' : 10, 'stop' : 15, 'expectedOutput' : ['16796','58786','208012','742900','2674440','9694845']},
      {'sequence' : NumberSequencesMode.RECAMAN,          'start' : 10, 'stop' : 15, 'expectedOutput' : ['11','22','10','23','9','24']},
      {'sequence' : NumberSequencesMode.LUCAS,            'start' : 10, 'stop' : 15, 'expectedOutput' : ['123','199','322','521','843','1364']},
      {'sequence' : NumberSequencesMode.FIBONACCI,        'start' : 10, 'stop' : 15, 'expectedOutput' : ['55','89','144','233','377','610']},
      {'sequence' : NumberSequencesMode.JACOBSTAHL,       'start' : 10, 'stop' : 15, 'expectedOutput' : ['341','683','1365','2731','5461','10923']},
      {'sequence' : NumberSequencesMode.JACOBSTHALLUCAS,  'start' : 10, 'stop' : 15, 'expectedOutput' : ['1025','2047','4097','8191','16385','32767']},
      {'sequence' : NumberSequencesMode.PELL,             'start' : 10, 'stop' : 15, 'expectedOutput' : ['2378','5741','13860','33461','80782','195025']},
      {'sequence' : NumberSequencesMode.FERMAT,           'start' : 10, 'stop' : 15, 'expectedOutput' : ['1025','2049','4097','8193','16385','32769']},
      {'sequence' : NumberSequencesMode.MERSENNE,         'start' : 10, 'stop' : 15, 'expectedOutput' : ['1023','2047','4095','8191','16383','32767']},
      {'sequence' : NumberSequencesMode.PELLLUCAS,        'start' : 10, 'stop' : 15, 'expectedOutput' : ['6726','16238','39202','94642','228486','551614']},
    ];

    _inputsToExpected.forEach((elem) {
      test('sequence: ${elem['sequence']}, start: ${elem['start']}, stop: ${elem['stop']}', () {
        var _actual = getNumbersInRange(elem['sequence'], elem['start'], elem['stop']);
        var length = elem['expectedOutput'].length;
        for (int i = 0; i < length; i++) {
          expect(_actual[i], elem['expectedOutput'][i]);
          expect(_actual[i], elem['expectedOutput'][i]);
          expect(_actual[i], elem['expectedOutput'][i]);
        }
      });
    });
  });
  group("numbersequence.getNumbersWithNDigits:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'sequence' : NumberSequencesMode.CATALAN,          'digits' : 4, 'expectedOutput' : ['1430','4862']},
      {'sequence' : NumberSequencesMode.RECAMAN,          'digits' : 2, 'expectedOutput' : ['13','20','12','21','11','22','10','23','24','25','43','62','42','63','41','18','42','17','43','16','44','15','45','14','46','79','78','77','39','78','38','79','37','80','36','81','35','82','34','83','33','84','32','85','31','86','30','87','29','88','28','89','27','90','26']},
      {'sequence' : NumberSequencesMode.LUCAS,            'digits' : 4, 'expectedOutput' : ['1364','2207','3571','5778','9349']},
      {'sequence' : NumberSequencesMode.FIBONACCI,        'digits' : 4, 'expectedOutput' : ['1597','2584','4181','6765']},
      {'sequence' : NumberSequencesMode.JACOBSTAHL,       'digits' : 4, 'expectedOutput' : ['1365','2731','5461']},
      {'sequence' : NumberSequencesMode.JACOBSTHALLUCAS,  'digits' : 4, 'expectedOutput' : ['1025','2047','4097','8191']},
      {'sequence' : NumberSequencesMode.PELL,             'digits' : 4, 'expectedOutput' : ['2378','5741']},
      {'sequence' : NumberSequencesMode.FERMAT,           'digits' : 4, 'expectedOutput' : ['1025','2049','4097','8193']},
      {'sequence' : NumberSequencesMode.MERSENNE,         'digits' : 4, 'expectedOutput' : ['1023','2047','4095','8191']},
      {'sequence' : NumberSequencesMode.PELLLUCAS,        'digits' : 4, 'expectedOutput' : ['1154','2786','6726']},
    ];

    _inputsToExpected.forEach((elem) {
      test('sequence: ${elem['sequence']}, digits: ${elem['digits']}', () {
        var _actual = getNumbersWithNDigits(elem['sequence'], elem['digits']);
        var length = elem['expectedOutput'].length;
        for (int i = 0; i < length; i++) {
          expect(_actual[i], elem['expectedOutput'][i]);
          expect(_actual[i], elem['expectedOutput'][i]);
          expect(_actual[i], elem['expectedOutput'][i]);
        }
      });
    });
  });
  group("numbersequence.getFirstPositionOfSequence:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'sequence' : NumberSequencesMode.CATALAN,          'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('7107690250413013761896628105173181658589772625392889208165477368352734802736195805963143770815133859332929972050727625767936724822523808745285247568658130484108957872094022098605943811100613700',
          '327','73')},
      {'sequence' : NumberSequencesMode.RECAMAN,          'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('273610',
          '83075','1')},
      {'sequence' : NumberSequencesMode.LUCAS,            'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('18748771816031882432361279585437379027793299399977527519157412464660965640249644313681249312162162629997750374920749068562512008441470175698571763320577336460472736199197895450368969873315889049038863774234995048085554243',
          '1054','161')},
      {'sequence' : NumberSequencesMode.FIBONACCI,        'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('192825882676106134378869728155374187660112414871811939193829103432318224700718717483263710524617634117161273616072137461357355627213312950037507329891012147460930383989353659980559007148865250358951233784907640314179868106583934968628863665186',
          '1161','106')},
      {'sequence' : NumberSequencesMode.JACOBSTAHL,       'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('2590225189634305427892615875764691875523209118736186028335749879651872380273611330901',
          '282','74')},
      {'sequence' : NumberSequencesMode.JACOBSTHALLUCAS,  'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('6546781215792283740026379393655198304433284092086129578966582736192267592809349109766540184651808314301773368255120142018434513091770786106657055178751',
          '501','61')},
      {'sequence' : NumberSequencesMode.PELL,             'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('20384220119784227273612728531358390881151829634178',
          '130','18')},
      {'sequence' : NumberSequencesMode.FERMAT,           'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('6546781215792283740026379393655198304433284092086129578966582736192267592809349109766540184651808314301773368255120142018434513091770786106657055178753',
          '501','61')},
      {'sequence' : NumberSequencesMode.MERSENNE,         'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('6546781215792283740026379393655198304433284092086129578966582736192267592809349109766540184651808314301773368255120142018434513091770786106657055178751',
          '501','61')},
      {'sequence' : NumberSequencesMode.PELLLUCAS,        'number' : '27361', 'expectedOutput' : getPositionOfSequenceOutput('29774604858329219664456332466656921673276471399199273612561389350268513626587176095809188915836887219380276486',
          '286','51')},
    ];

    _inputsToExpected.forEach((elem) {
      test('sequence: ${elem['sequence']}, number: ${elem['start']}', () {
        getPositionOfSequenceOutput _actual = getFirstPositionOfSequence(elem['sequence'], elem['number']);
        expect(_actual.number, elem['expectedOutput'].number);
        expect(_actual.PositionSequence, elem['expectedOutput'].PositionSequence);
        expect(_actual.PositionDigits, elem['expectedOutput'].PositionDigits);
      });
    });
  });


}