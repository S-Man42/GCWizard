import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/hms_deg.dart';

void main() {

  group("hms_deg.raDeg2Hms:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null.toString()},
      {'input' : 66.918277, 'expectedOutput' : '4:27:40.386480000000375'},
      {'input' : -66.918277, 'expectedOutput' : '-4:27:40.386480000000375'},
      {'input' : 9.618291666666666, 'expectedOutput' : '0:38:28.389999999999844'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = raDeg2Hms(elem['input']);
        expect(_actual.toString(), elem['expectedOutput']);
      });
    });
  });

  group("hms_deg.raHms2Deg:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '4:27:40.386', 'expectedOutput' : 66.918275},
      {'input' : '-4:27:40.386', 'expectedOutput' : -66.918275},
      {'input' : '0:38:28.39', 'expectedOutput' : 9.618291666666666},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = raHms2Deg(Equatorial.parse(elem['input']));
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("DMMPart.parse:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : 'N 52° 12.312', 'expectedOutput' : '52° 12.312\''},
      {'input' : 'E 52° 12.312', 'expectedOutput' : '52° 12.312\''},
      {'input' : '52° 12.312', 'expectedOutput' : '52° 12.312\''},
      {'input' : '+52° 12.312', 'expectedOutput' : '52° 12.312\''},
      {'input' : 'W 52° 12.312', 'expectedOutput' : '-52° 12.312\''},
      {'input' : 'S 52° 12.312', 'expectedOutput' : '-52° 12.312\''},
      {'input' : '-52° 12.312', 'expectedOutput' : '-52° 12.312\''},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = DMMPart.parse(elem['input']);
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