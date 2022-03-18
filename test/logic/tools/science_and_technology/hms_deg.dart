import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/hms_deg.dart';

void main() {

  group("hms_deg.raDeg2Hms:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null.toString()},
      {'input' : 66.918277, 'expectedOutput' : '4:27:40.386480000000375'},
      {'input' : -66.918277, 'expectedOutput' : '-4:27:40.386480000000375'},
      {'input' : 9.618291666666666, 'expectedOutput' : '0:38:28.389999999999844'},

      {'input' : 460.0, 'expectedOutput' : '30:40:4.26'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = raDeg2Hms(DEG(elem['input']));
        expect(_actual.toString(), elem['expectedOutput']);
      });
    });
  });

  group("hms_deg.raHms2Deg:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '4:27:40.386', 'expectedOutput' : '66.918275'},
      {'input' : '-4:27:40.386', 'expectedOutput' : '-66.918275'},
      {'input' : '0:38:28.39', 'expectedOutput' : "9.6182916667"},

      {'input' : '-44:27:40.386', 'expectedOutput' : '-666.918275'},
      {'input' : '50:38:28.39', 'expectedOutput' : '759.6182916667'},

    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = raHms2Deg(Equatorial.parse(elem['input']));
        if (_actual == null)
          expect(_actual, elem['expectedOutput']);
        else
          expect(_actual.toString(), elem['expectedOutput']);
      });
    });
  });

  group("DEG.parse:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '66.918277', 'expectedOutput' : '66.918277'},
      {'input' : '-66.918277', 'expectedOutput' : '-66.918277'},
      {'input' : '9.618291666666666', 'expectedOutput' : '9.6182916667'},

      {'input' : '460.0', 'expectedOutput' : '460.000'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = DEG.parse(elem['input']);
        if (_actual == null)
          expect(_actual, elem['expectedOutput']);
        else
          expect(_actual.toString(), elem['expectedOutput']);
      });
    });
  });

  group("Equatorial.parse:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '4:27:40.386', 'expectedOutput' : '4:27:40.386'},
      {'input' : '-4:27:40.386', 'expectedOutput' : '-4:27:40.386'},
      {'input' : '0:38:28.39', 'expectedOutput' : '0:38:28.39'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = Equatorial.parse(elem['input']);
        if (_actual == null)
          expect(_actual, elem['expectedOutput']);
        else
          expect(_actual.toString(), elem['expectedOutput']);
      });
    });
  });
}