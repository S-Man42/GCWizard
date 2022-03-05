import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/hms_deg.dart';

void main() {
  group("hms_deg.decDeg2Hms:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null.toString()},
      {'input' : 24.622590, 'expectedOutput' : '24:37:21.32399999999592'},
      {'input' : -24.622590, 'expectedOutput' : '-24:37:21.32399999999592'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decDeg2Hms(elem['input']);
        expect(_actual.toString(), elem['expectedOutput']);
      });
    });
  });

  group("hms_deg.decHms2Deg:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '24:37:21.324', 'expectedOutput' : 24.62259},
      {'input' : '-24:37:21.324', 'expectedOutput' : -24.62259},
      {'input' : '48:44:34.523618244', 'expectedOutput' : 48.74292322729},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decHms2Deg(Equatorial.parse(elem['input']));
        expect(_actual, elem['expectedOutput']);
      });
    });
  });



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
}