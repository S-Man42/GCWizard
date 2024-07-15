import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/science_and_technology/postcode/logic/postcode.dart';

void main() {
  group("Postcode.decode:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : '', 'expectedOutput' : const PostcodeResult('','',false,'','','', PostcodeFormat.Linear30, ErrorCode.Length)},
      {'input' : 'l.ll....lll.llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.lllll.', 'expectedOutput' : const PostcodeResult('','',false,'','','', PostcodeFormat.Linear30, ErrorCode.Length)},
      {'input' : 'l.ll....lll.llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.llllx', 'expectedOutput' : const PostcodeResult('','',false,'','','', PostcodeFormat.Linear30, ErrorCode.Character)},
      {'input' : '.l.l.ll.l.l..llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...ll.llll', 'expectedOutput' : const PostcodeResult('','',false,'','','', PostcodeFormat.Linear30, ErrorCode.Length)},
      {'input' : ' | ||||||  || | ||| || || | ||', 'expectedOutput' : const PostcodeResult('8502','5',true,'','','', PostcodeFormat.Linear30, ErrorCode.Ok)},

      {'input' : '|  |||  ||||| | |||||  ||| | | | |||', 'expectedOutput' : const PostcodeResult('90513','2',true,'','','', PostcodeFormat.Linear36, ErrorCode.Ok)},

      {'input' : '.|||||||| ||||||||||||||||||  ||  |||  ||||| | |||||  ||| | | | |||||', 'expectedOutput' : const PostcodeResult('90513','2',true,'300','010','', PostcodeFormat.Linear69, ErrorCode.Ok)},
      {'input' : '..||||||||.||||||||||||||||||..||..|||..|||||.|.|||||..|||.|.|.|.|||||', 'expectedOutput' : const PostcodeResult('90513','2',true,'300','010','', PostcodeFormat.Linear69, ErrorCode.Ok)},      {'input' : '|||||||| ||||||||||||||||||  ||  |||  ||||| | |||||  ||| | | | |||||', 'expectedOutput' : const PostcodeResult('90513','2',true,'300','010','', PostcodeFormat.Linear69, ErrorCode.Ok)},
      {'input' : '|||||||| ||||||||||||||||||  ||  |||  ||||| | |||||  ||| | ||  |||||', 'expectedOutput' : const PostcodeResult('90513','3',false,'300','010','', PostcodeFormat.Linear69, ErrorCode.Ok)},
      {'input' : '|||||||| ||||||||||||||||||  ||  |||  ||||| | |||||  ||| | | |  ||||', 'expectedOutput' : const PostcodeResult('90513','?',false,'300','010','', PostcodeFormat.Linear69, ErrorCode.Invalid)},

      {'input' : '.| |||| | ||||||||| ||||||||||||||||||  ||  |||  ||||| | |||||  ||| | | | |||||', 'expectedOutput' : const PostcodeResult('90513','2',true,'300','010','54', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : 'l.ll....lll.llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.lllll', 'expectedOutput' : const PostcodeResult('90513','2',true,'300','010','83', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : 'l.ll.l..lll.llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.lllll', 'expectedOutput' : const PostcodeResult('90513','2',true,'300','010','82', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : '.|.||||.|.|||||||||.||||||||||||||||||..|.||.||..|||||.|.|||||..|||.|.|..||||||', 'expectedOutput' : const PostcodeResult('90514','1',true,'300','010','54', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : '.|.||||.|.|||||||||.||||||||||||||||||..|.||.||..|||||.|.|||||..|||.|.|..||||||', 'expectedOutput' : const PostcodeResult('90514','1',true,'300','010','54', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : '..|.||||.|.|||||||||.||||||||||||||||||..|.||.||..|||||.|.|||||..|||.|.|..||||||', 'expectedOutput' : const PostcodeResult('90514','1',true,'300','010','54', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : '.|.||||.|.|||||||||.||||||||||||||||||..|.|.|||..|||||.|.|||||..|||.|.||..|||||', 'expectedOutput' : const PostcodeResult('90512','3',true,'300','010','54', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : '.||..|.||||||||||||.||||||||||||||||||..||...||..|||||.|.|||||..|||.|.||.||.|||', 'expectedOutput' : const PostcodeResult('90517','8',true,'300','010','83', PostcodeFormat.Linear80, ErrorCode.Ok)},
      {'input' : '|.||..|.||||||||||||.||||||||||||||||||..||...||..|||||.|.|||||..|||.|.||.||.|||', 'expectedOutput' : const PostcodeResult('90517','8',true,'300','010','83', PostcodeFormat.Linear80, ErrorCode.Ok)},

      {'input' : 'l.l.ll.l.l..llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...l.l.lll', 'expectedOutput' : const PostcodeResult('90513','?',false,'300','010','54', PostcodeFormat.Linear80, ErrorCode.Invalid)},
      {'input' : 'l.l.ll.l.l..llll.lll.lllll.llllllllllll...l..lll..lllll.l.l.lll..lll.l...ll.llll', 'expectedOutput' : const PostcodeResult('90513','4',false,'300','010','54', PostcodeFormat.Linear80, ErrorCode.Ok)},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var _actual = decodePostcode(elem['input'] as String);
        expect(_actual.toString(), (elem['expectedOutput'] as PostcodeResult).toString());
      });
    }
  });

  group("Postcode.encode:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : const PostcodeResult('','',false,'','','', PostcodeFormat.Linear30, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('90513','',false,'','','', PostcodeFormat.Linear30, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('8502','5',true,'','','', PostcodeFormat.Linear30, ErrorCode.Ok), 'expectedOutput' : '.|.||||||..||.|.|||.||.||.|.||'},

      {'input' : const PostcodeResult('','',false,'','','', PostcodeFormat.Linear36, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('9051','2',true,'','','', PostcodeFormat.Linear36, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('905131','2',true,'','','', PostcodeFormat.Linear36, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('90513','2',true,'','','', PostcodeFormat.Linear36, ErrorCode.Ok), 'expectedOutput' : '|..|||..|||||.|.|||||..|||.|.|.|.|||'},

      {'input' : const PostcodeResult('','',false,'','','', PostcodeFormat.Linear69, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('9051','2',true,'','','', PostcodeFormat.Linear69, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('905131','2',true,'','','', PostcodeFormat.Linear69, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('90513','2',true,'3000','010','', PostcodeFormat.Linear69, ErrorCode.Length), 'expectedOutput' : 'streetCodeLength'},
      {'input' : const PostcodeResult('90513','2',true,'300','1000','', PostcodeFormat.Linear69, ErrorCode.Length), 'expectedOutput' : 'houseNumberLength'},
      {'input' : const PostcodeResult('90513','2',true,'300','010','', PostcodeFormat.Linear69, ErrorCode.Ok), 'expectedOutput' : '.||||||||.||||||||||||||||||..||..|||..|||||.|.|||||..|||.|.|.|.|||||'},

      {'input' : const PostcodeResult('','',false,'','','54', PostcodeFormat.Linear80, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('9051','2',true,'','','54', PostcodeFormat.Linear80, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('905131','2',true,'','','54', PostcodeFormat.Linear80, ErrorCode.Length), 'expectedOutput' : 'postalCodeLength'},
      {'input' : const PostcodeResult('90513','2',true,'3000','010','54', PostcodeFormat.Linear80, ErrorCode.Length), 'expectedOutput' : 'streetCodeLength'},
      {'input' : const PostcodeResult('90513','2',true,'300','1000','54', PostcodeFormat.Linear80, ErrorCode.Length), 'expectedOutput' : 'houseNumberLength'},
      {'input' : const PostcodeResult('90513','2',true,'300','010','544', PostcodeFormat.Linear80, ErrorCode.Length), 'expectedOutput' : 'feeProtectionCodeLength'},

      {'input' : const PostcodeResult('90513','2',true,'300','010','54', PostcodeFormat.Linear80, ErrorCode.Ok), 'expectedOutput' : '.|.||||.|.|||||||||.||||||||||||||||||..||..|||..|||||.|.|||||..|||.|.|.|.|||||'},
      {'input' : const PostcodeResult('90513','2',true,'300','010','83', PostcodeFormat.Linear80, ErrorCode.Ok), 'expectedOutput' : '.||..|.||||||||||||.||||||||||||||||||..||..|||..|||||.|.|||||..|||.|.|.|.|||||'},
      {'input' : const PostcodeResult('90513','2',true,'300','010','82', PostcodeFormat.Linear80, ErrorCode.Ok), 'expectedOutput' : '.||.||.||||||||||||.||||||||||||||||||..||..|||..|||||.|.|||||..|||.|.|.|.|||||'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}', () {
        var input = elem['input'] as PostcodeResult;
        var _actual = encodePostcode(input.postalCode, int.tryParse(input.streetCode) ?? 0,
            int.tryParse(input.houseNumber) ?? 0, int.tryParse(input.feeProtectionCode) ?? 0, input.format);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}