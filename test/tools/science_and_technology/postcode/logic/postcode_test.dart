import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/postcode/logic/postcode.dart';

void main() {
  group("Postcode.decode:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : const postcodeResult('','','','','', PostcodeFormat.Linear30, ErrorCode.Length)},
      {'input' : 'l.ll....lll.llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.lllll.', 'expectedOutput' : const postcodeResult('','','','','', PostcodeFormat.Linear30, ErrorCode.Length)},
      {'input' : 'l.ll....lll.llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.llllx', 'expectedOutput' : const postcodeResult('','','','','', PostcodeFormat.Linear30, ErrorCode.Character)},

      {'input' : '.| |||| | ||||||||| ||||||||||||||||||  ||  |||  ||||| | |||||  ||| | | | |||||', 'expectedOutput' : const postcodeResult('90513','2','300','010','54', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : 'l.ll....lll.llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.lllll', 'expectedOutput' : const postcodeResult('90513','2','300','010','83', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : 'l.ll.l..lll.llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.lllll', 'expectedOutput' : const postcodeResult('90513','2','300','010','82', PostcodeFormat.Linear80, ErrorCode.Ok)},

      {'input' : '.|||||||| ||||||||||||||||||  ||  |||  ||||| | |||||  ||| | | | |||||', 'expectedOutput' : const postcodeResult('90513','2','300','010','', PostcodeFormat.Linear69, ErrorCode.Ok)},

      {'input' : '|  |||  ||||| | |||||  ||| | | | |||', 'expectedOutput' : const postcodeResult('90513','2','','','', PostcodeFormat.Linear36, ErrorCode.Ok)},

      {'input' : ' | ||||||  || | ||| || || | ||', 'expectedOutput' : const postcodeResult('8502','5','','','', PostcodeFormat.Linear30, ErrorCode.Ok)},

    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decodePostcode(elem['input'] as String);
        expect(_actual.toString(), (elem['expectedOutput'] as postcodeResult).toString());
      });
    }
  });
}