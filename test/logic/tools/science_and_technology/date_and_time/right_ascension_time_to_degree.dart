import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/right_ascension_time_to_degree.dart';

void main() {

  group("right_ascension_time_to_degree.raDegree2Time:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null.toString()},
      {'input' : 66.918277, 'expectedOutput' : '4:27:40.3864800000'},
      {'input' : -66.918277, 'expectedOutput' : '-4:27:40.3864800000'},
      {'input' : 9.618291666666666, 'expectedOutput' : '0:38:28.3900000000'},

      {'input' : 90.0, 'expectedOutput' : '6:0:0.0'},
      {'input' : 460.0, 'expectedOutput' : '30:40:0.0000000000'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = raDegree2Time(RADEG(elem['input']));
        expect(_actual.toString(), elem['expectedOutput']);
      });
    });
  });

  group("right_ascension_time_to_degree.raTime2Degree:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : null},
      {'input' : '4:27:40.386', 'expectedOutput' : '66.918275'},
      {'input' : '-4:27:40.386', 'expectedOutput' : '-66.918275'},
      {'input' : '0:38:28.39', 'expectedOutput' : '9.6182916667'},

      {'input' : '-44:27:40.386', 'expectedOutput' : '-666.918275'},
      {'input' : '50:38:28.39', 'expectedOutput' : '759.6182916667'},
      {'input' : '-3:8:0', 'expectedOutput' : '759.6182916667'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = raTime2Degree(Equatorial.parse(elem['input']));
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
        var _actual = RADEG.parse(elem['input']);
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