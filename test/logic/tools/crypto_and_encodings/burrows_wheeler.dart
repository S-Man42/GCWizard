import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/burrows_wheeler.dart';


// https://www.cs.cmu.edu/~ckingsf/bioinfo-lectures/bwt.pdf

void main() {

  group("bioinfo-lectures.encrypt", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : 'banana#', 'index': '0',  'compress': false, 'deu': true,
        'expectedOutput' : BWTOutput('annb#aa','5')},
      {'input' : 'appellee#', 'index': '0',  'compress': false, 'deu': true,
        'expectedOutput' : BWTOutput('e#elplepa','2')},
      {'input' : 'dogwood#', 'index': '0',  'compress': false, 'deu': true,
        'expectedOutput' : BWTOutput('do#oodwg','3')},
    ];

    _inputsToExpected.forEach((elem) {
        test('input: ${elem['input']}, index: ${elem['index']}', () {
          BWTOutput _actual = encryptBurrowsWheeler(elem['input'], elem['index']);
          expect(_actual.text, elem['expectedOutput'].text);
          expect(_actual.index, elem['expectedOutput'].index);
        });
    });
  });

  group("BurrowsWheeler.encrypt", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'index': '0',  'compress': false, 'deu': true,
        'expectedOutput' : BWTOutput('','')},

      {'input' : 'helene', 'index': '0',    'expectedOutput' : BWTOutput('nhleee','4')},
      {'input' : 'helene', 'index': '',     'expectedOutput' : BWTOutput('burrowswheeler_error_no_index','')},
      {'input' : 'helene', 'index': 'h',    'expectedOutput' : BWTOutput('burrowswheeler_error_char_index','')},
      {'input' : 'helene', 'index': '#',    'expectedOutput' : BWTOutput('nhl#eee','#')},

      {'input' : 'helene', 'index': '0',    'expectedOutput' : BWTOutput('nhleee','4')},
      {'input' : 'helene', 'index': '',     'expectedOutput' : BWTOutput('burrowswheeler_error_no_index','')},
      {'input' : 'helene', 'index': 'h',    'expectedOutput' : BWTOutput('burrowswheeler_error_char_index','')},
      {'input' : 'helene', 'index': '#',    'expectedOutput' : BWTOutput('nhl#eee','#')},

      {'input' : 'Koordinaten N52.27.456 E13.08.123', 'index': '0',
        'expectedOutput' : BWTOutput('6n3827..E51.12.N4520 3 nrtdeiKooa','22')},
      {'input' : 'Koordinaten N52.27.456 E13.08.123', 'index': '#',
        'expectedOutput' : BWTOutput('6n3827..E51.12.N4520 #3 nrtdeiKooa','#')},
      {'input' : 'Koordinaten N52.27.456 E13.08.123', 'index': '0',
        'expectedOutput' : BWTOutput('sntini i lneearsiisrwrwE.wtbuuinrNncceeeesvdeeelueeieeii.Kooddehnfinhaffn.zzzfs.','8')},
      {'input' : 'Koordinaten N52.27.456 E13.08.123', 'index': '#',
        'expectedOutput' : BWTOutput('sntini #i lneearsiisrwrwE.wtbuuinrNncceeeesvdeeelueeieeii.Kooddehnfinhaffn.zzzfs.','#')},
      {'input' : 'Koordinaten N52.27.456 E13.08.123', 'index': '0',
        'expectedOutput' : BWTOutput('xnntoe e nreerrotvzvnvnsrN.ittgedffseeioowrE.Kowwfohhueoehaeoe.eoeiittti.','8')},
      {'input' : 'Koordinaten N52.27.456 E13.08.123', 'index': '#',
        'expectedOutput' : BWTOutput('xnntoe #e nreerrotvzvnvnsrN.ittgedffseeioowrE.Kowwfohhueoehaeoe.eoeiittti.','#')},

      {'input' : 'wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach', 'index': '0',
        'expectedOutput' : BWTOutput('rnnnnnnnnaiiiiiiggggggwt------eeeeee-cllllllhffffffeeeneee-eienh','64')},
      {'input' : 'wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach', 'index': '#',
        'expectedOutput' : BWTOutput('rnnnnnnnnaiiiiiiggggggwt------eeeeee-cllllllhffffffeeeneee-eien#h','#')},
      {'input' : 'wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach', 'index': '0',
        'expectedOutput' : BWTOutput('rnnnnnnnnaiiiiiiggggggwt------eeeeee-cllllllhffffffeeeneee-eienh','64')},
      {'input' : 'wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach', 'index': '#',
        'expectedOutput' : BWTOutput('rnnnnnnnnaiiiiiiggggggwt------eeeeee-cllllllhffffffeeeneee-eien#h','#')},
    ];

    _inputsToExpected.forEach((elem) {
      BWTOutput _actual;
      if (elem['index'] == '' || elem['index'] == null)
        _actual = BWTOutput('burrowswheeler_error_no_index', '');
      else if (elem['input'].contains(elem['index']))
        _actual = BWTOutput('burrowswheeler_error_char_index', '');
      else
        test('input: ${elem['input']}, index: ${elem['index']}', () {
        BWTOutput _actual = encryptBurrowsWheeler(elem['input'], elem['index']);
          expect(_actual.text, elem['expectedOutput'].text);
          expect(_actual.index, elem['expectedOutput'].index);
      });
    });
  });

  group("bioinfo-lectures.decrypt", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : 'annb#aa', 'index': '5',  'expectedOutput' : BWTOutput('banana#','5')},
      {'input' : 'e#elplepa', 'index': '2','expectedOutput' : BWTOutput('appellee#','2')},
      {'input' : 'do#oodwg', 'index': '3', 'expectedOutput' : BWTOutput('dogwood#','3')},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, index: ${elem['index']}', () {
        BWTOutput _actual = decryptBurrowsWheeler(elem['input'], elem['index']);
        expect(_actual.text, elem['expectedOutput'].text);
        expect(_actual.index, elem['expectedOutput'].index);
      });
    });
  });

  group("BurrowsWheeler.decrypt", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'index': '0',  'compress': false, 'deu': true,
        'expectedOutput' : BWTOutput('','')},

      {'input' : 'nhleee',  'index': '4', 'expectedOutput' : BWTOutput('helene','4')},
      {'input' : 'nhleee',  'index': '',  'expectedOutput' : BWTOutput('burrowswheeler_error_no_index','')},
      {'input' : 'nhleee',  'index': 'h', 'expectedOutput' : BWTOutput('elele','h')},
      {'input' : 'nhl#eee', 'index': '#', 'expectedOutput' : BWTOutput('helene','#')},

      {'input' : 'nhle2',  'index': '4',  'expectedOutput' : BWTOutput('helene','4')},
      {'input' : 'nhle2',  'index': '',   'expectedOutput' : BWTOutput('burrowswheeler_error_no_index','')},
      {'input' : 'nhle2',  'index': 'h',  'expectedOutput' : BWTOutput('elele','h')},
      {'input' : 'nhl#e2', 'index': '#',  'expectedOutput' : BWTOutput('helene','#')},

      {'input' : '6n3827..E51.12.N4520 3 nrtdeiKooa', 'index': '22',
        'expectedOutput' : BWTOutput('Koordinaten N52.27.456 E13.08.123','22')},
      {'input' : '6n3827..E51.12.N4520 #3 nrtdeiKooa', 'index': '#',
        'expectedOutput' : BWTOutput('Koordinaten N52.27.456 E13.08.123','#')},

      {'input' : 'sntini i lne1arsi1srwrwE.wtbu1inrNnc1e3svde2lue1ie1i1.Ko1d1ehnfinhaf1n.z2fs.', 'index': '8',
        'expectedOutput' : BWTOutput('Koordinaten N52.27.456 E13.08.123','8')},
      {'input' : 'sntini #i lne1arsi1srwrwE.wtbu1inrNnc1e3svde2lue1ie1i1.Ko1d1ehnfinhaf1n.z2fs.', 'index': '#',
        'expectedOutput' : BWTOutput('Koordinaten N52.27.456 E13.08.123','#')},

      {'input' : 'xn1toe e nre1r1otvzvnvnsrN.it1gedf1se1io1wrE.Kow1foh1ueoehaeoe.eoei1t2i.', 'index': '8',
        'expectedOutput' : BWTOutput('Koordinaten N52.27.456 E13.08.123','8')},
      {'input' : 'xn1toe #e nre1r1otvzvnvnsrN.it1gedf1se1io1wrE.Kow1foh1ueoehaeoe.eoei1t2i.', 'index': '#',
        'expectedOutput' : BWTOutput('Koordinaten N52.27.456 E13.08.123','#')},

      {'input' : 'rnnnnnnnnaiiiiiiggggggwt------eeeeee-cllllllhffffffeeeneee-eienh', 'index': '64',
        'expectedOutput' : BWTOutput('wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach','64')},
      {'input' : 'rnnnnnnnnaiiiiiiggggggwt------eeeeee-cllllllhffffffeeeneee-eien#h', 'index': '#',
        'expectedOutput' : BWTOutput('wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach','#')},
      {'input' : 'rn7ai5g5wt-5e5-cl5hf5e2ne2-eienh', 'index': '64',
        'expectedOutput' : BWTOutput('wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach','64')},
      {'input' : 'rn7ai5g5wt-5e5-cl5hf5e2ne2-eien#h', 'index': '#',
        'expectedOutput' : BWTOutput('wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach','#')},
    ];

    _inputsToExpected.forEach((elem) {
      BWTOutput _actual;
      if (elem['index'] == '' || elem['index'] == null)
        _actual = BWTOutput('burrowswheeler_error_no_index', '');
      else
        test('input: ${elem['input']}, index: ${elem['index']}', () {
          _actual = decryptBurrowsWheeler(elem['input'], elem['index']);
          expect(_actual.text, elem['expectedOutput'].text);
          expect(_actual.index, elem['expectedOutput'].index);
        });
    });
  });

}