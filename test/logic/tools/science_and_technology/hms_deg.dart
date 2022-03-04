import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/hms_deg.dart';

void main() {
  group("hms_deg.decDeg2Hms:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
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
      {'input' : null, 'expectedOutput' : ''},
      {'input' : Equatorial.parse('24:37:21.324'), 'expectedOutput' : 24.62259},
      {'input' : Equatorial.parse('-24:37:21.324'), 'expectedOutput' : -24.62259},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = decHms2Deg(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });


  // group("hms_deg.decDeg2Hms:", () {
  //   List<Map<String, dynamic>> _inputsToExpected = [
  //     {'expectedOutput' : '', 'input' : ''},
  //     {'expectedOutput' : 'A', 'input' : '[697, 1633]'},
  //     {'expectedOutput' : 'A', 'input' : '(697.1633)'},
  //     {'expectedOutput' : 'A', 'input' : '697 1633 '},
  //     {'expectedOutput' : 'A', 'input' : '697.1633.'},
  //     {'expectedOutput' : '27', 'input' : '697 1336 1209 852 '},
  //     {'expectedOutput' : '274', 'input' : '697 1336 1209 852 fghi 770 1209 '},
  //
  //     {'expectedOutput' : '', 'input' : '697'},
  //     {'expectedOutput' : '', 'input' : '69'},
  //     {'expectedOutput' : '', 'input' : '69 1633'},
  //     {'expectedOutput' : '', 'input' : '697 1632'},
  //     {'expectedOutput' : 'A2', 'input' : '697 1633 697 1336 1209'},
  //   ];
  //
  //   _inputsToExpected.forEach((elem) {
  //     test('input: ${elem['input']}', () {
  //       var _actual = decodeDTMF(elem['input']);
  //       expect(_actual, elem['expectedOutput']);
  //     });
  //   });
  // });
}