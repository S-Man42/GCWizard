import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/reverse.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/krevo.wherigotools/ucommons.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';

void main() {
  group("Reverse.reverse:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABC%&/6789abcÄ', 'expectedOutput' : 'Äcba9876/&%CBA'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = reverse(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });


  group("Reverse.reverse:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
           {'input' : 'ABC%&/6789abcÄ', 'expectedOutput' : 'Äcba9876/&%CBA'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        int maxLen = 0;
        int minLen = 20;
        var y = [0,0,0,0,0,0,0,0,0,0,0,0,0];
        for (int i = 121324; i <= 121324; i++) {
          var x = breakUrwigoHash(i);
          if (x == null) {
            print('null: $i');
            y[0]++;
            continue;
          }

          y[x.length]++;

          if (x.length > maxLen) {
            maxLen = x.length;
            print('max: $maxLen $x $i');
          }

          if (x.length < minLen) {
            minLen = x.length;
            print('min: $minLen $x $i');
          }
        }

        print('max: $maxLen');
        print('min: $minLen');
        print(y);

        var _actual = reverse(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}