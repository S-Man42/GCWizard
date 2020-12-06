import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/burrows_wheeler.dart';

void main() {

  group("BurrowsWheeler.encryptBurrowsWheeler:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'index': '', 'expectedOutputText' : '', 'expectedOutputIndex' : ''},
      {'input' : 'helene', 'index': '', 'expectedOutputText' : 'Index is mssing', 'expectedOutputIndex' : ''},
      {'input' : 'helene', 'index': '#', 'expectedOutputText' : 'nhl#eee', 'expectedOutputIndex' : ''},
      {'input' : 'Koordinaten N52.27.456 E13.08.123', 'index': '#', 'expectedOutputText' : '6n3827..E51.12.N4520 #3 nrtdeiKooa', 'expectedOutputIndex' : ''},
      {'input' : 'wenn-fliegen-hinter-fliegen-fliegen-fliegen-fliegen-fliegen-nach', 'index': '#', 'expectedOutputText' : 'rnnnnnnnnaiiiiiiggggggwt------eeeeee-cllllllhffffffeeeneee-eien#h', 'expectedOutputIndex' : ''},
    ];

    _inputsToExpected.forEach((elem) {
      if (elem['index'] == '')
        String _actual = 'Index is mssing';
      else
        test('input: ${elem['input']}, index: ${elem['index']}', () {
        BWTOutput _actual = encryptBurrowsWheeler(elem['input'], elem['index']);
        expect(_actual, [elem['expectedOutputText'],elem['expectedOutputIndex']]);
      });
    });
  });

  group("BurrowsWheeler.decryptBurrowsWheeler:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '', 'index': '', 'expectedOutputText' : ''},
      {'input' : 'NHL#EEE', 'index': '', 'expectedOutputText' : 'Index is mssing'},
      {'input' : 'NHL#EEE', 'index': '#', 'expectedOutputText' : 'HELENE'},
      {'input' : '6n3827..E51.12.N4520 #3 nrtdeiKooa', 'index': '#', 'expectedOutputText' : 'Koordinaten N52.27.456 E13.08.123'},
      {'input' : 'rnnnnnnnnaiiiiiiggggggwt      eeeeee cllllllhffffffeeeneee eien#h', 'index': '#', 'expectedOutputText' : 'wenn fliegen hinter fliegen fliegen fliegen fliegen fliegen nach'},
    ];

    _inputsToExpected.forEach((elem) {
      if (elem['index'] == '')
        String _actual = 'Index is mssing';
      else
        test('input: ${elem['input']}, index: ${elem['index']}', () {
          BWTOutput _actual = decryptBurrowsWheeler(elem['input'], elem['index']);
        expect(_actual, [elem['expectedOutputText'],elem['expectedOutputIndex']]);
      });
    });
  });
}