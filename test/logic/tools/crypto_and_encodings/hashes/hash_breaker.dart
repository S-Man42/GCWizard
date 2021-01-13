import "package:flutter_test/flutter_test.dart";
import "package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hash_breaker.dart";
import "package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hashes.dart";

void main() {
  group("HashBreaker.breakHash:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'searchMask': null, 'substitutions': null, 'hashFunction': null, 'expectedOutput' : null},

      {'input' : 'EAF498C0576778AB60648148D8A6FC66', 'searchMask': 'ABC', 'substitutions': {'A':'1-3', 'B': '2,4,10'}, 'hashFunction': md5Digest, 'expectedOutput' : {'state': 'ok', 'text': '210C'}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = breakHash1(elem['input'], elem['searchMask'], elem['substitutions'], elem['hashFunction']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("HashBreaker.preCheck:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'substitutions': {'A':'100-300', 'B': '1000-3000'}, 'expectedOutput' : {'status': 'high-count', 'count': 402201}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = preCheck(elem['substitutions']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}