import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/burrows_wheeler.dart';

void main() {

  group("BurrowsWheeler.encryptBurrowsWheeler:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'index': '', 'expectedOutput' : ''},
      {'input' : 'helene', 'index': '', 'expectedOutput' : 'Index is mssing'},
      {'input' : 'helene', 'index': '#', 'expectedOutput' : 'nhl#eee'},
      {'input' : 'Koordinaten N52.27.456 E13.08.123', 'index': '#', 'expectedOutput' : '6n3827..E51.12.N4520 #3 nrtdeiKooa'},
      {'input' : 'wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach', 'index': '#', 'expectedOutput' : 'rnnnnnnnnaiiiiiiggggggwt------eeeeee-cllllllhffffffeeeneee-eien#h'},
    ];

    _inputsToExpected.forEach((elem) {
      if (elem['index'] == '')
        String _actual = 'Index is mssing';
      else
        test('input: ${elem['input']}, index: ${elem['index']}', () {
        String _actual = encryptBurrowsWheeler(elem['input'], elem['index']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("BurrowsWheeler.decryptBurrowsWheeler:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'index': '', 'expectedOutput' : ''},
      {'input' : 'NHL#EEE', 'index': '', 'expectedOutput' : 'Index is mssing'},
      {'input' : 'NHL#EEE', 'index': '#', 'expectedOutput' : 'HELENE'},
      {'input' : '6n3827..E51.12.N4520 #3 nrtdeiKooa', 'index': '#', 'expectedOutput' : 'Koordinaten N52.27.456 E13.08.123'},
      {'input' : 'rnnnnnnnnaiiiiiiggggggwt      eeeeee cllllllhffffffeeeneee eien#h', 'index': '#', 'expectedOutput' : 'wenn fliegen hinter fliegen fliegen fliegen fliegen fliegen nach'},
    ];

    _inputsToExpected.forEach((elem) {
      if (elem['index'] == '')
        String _actual = 'Index is mssing';
      else
        test('input: ${elem['input']}, index: ${elem['index']}', () {
          String _actual = decryptBurrowsWheeler(elem['input'], elem['index']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}