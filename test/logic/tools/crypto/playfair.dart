import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto/playfair.dart';

void main() {
  group("Playfair.encodePlayfair:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'key': null, 'mode': PlayFairMode.JToI, 'expectedOutput' : ''},
      {'input' : '', 'key': null, 'mode': PlayFairMode.JToI, 'expectedOutput' : ''},
      {'input' : null, 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : ''},
      {'input' : '', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : ''},
      {'input' : 'A', 'key': null, 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CV'},
      {'input' : 'A', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CV'},

      {'input' : 'AX', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CV'},
      {'input' : 'AA', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CV CV'},
      {'input' : 'AXA', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CV CV'},
      {'input' : 'X', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'VS'},
      {'input' : 'XQ', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'VS'},
      {'input' : 'XX', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'VS VS'},
      {'input' : 'Q', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'SV'},
      {'input' : 'QX', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'SV'},
      {'input' : 'QQ', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'SV SV'},

      {'input' : 'BAA', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CB CV'},
      {'input' : 'BAAA', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CB CV CV'},
      {'input' : 'BAAAD', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CB CV BE'},
      {'input' : 'AAA', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CV CV CV'},
      {'input' : 'AAAB', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'CV CV BC'},

      {'input' : 'Hide the gold in the tree stump', 'key': 'playfair example', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'BM OD ZB XD NA BE KU DM UI XM MO UV IF'},
      {'input' : 'Laboulaye lady will lead to Cibola temples of gold', 'key': 'DEATH', 'mode': PlayFairMode.JToI, 'expectedOutput' : 'ME IK QO TX CQ TE ZX CO MW QC TE HN FB IK ME HA KR QC UN GI KM AV'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}', () {
        var _actual = encryptPlayfair(elem['input'], elem['key'], mode: elem['mode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Playfair.decodePlayfair:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'key': null, 'mode': PlayFairMode.JToI, 'expectedOutput' : ''},
      {'input' : '', 'key': null, 'mode': PlayFairMode.JToI, 'expectedOutput' : ''},
      {'input' : null, 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : ''},
      {'input' : '', 'key': '', 'mode': PlayFairMode.JToI, 'expectedOutput' : ''},
      {'expectedOutput' : 'AX', 'key': null, 'mode': PlayFairMode.JToI, 'input' : 'CV'},
      {'expectedOutput' : 'AX', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'CV'},

      {'expectedOutput' : 'AX', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'CV'},
      {'expectedOutput' : 'AXAX', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'CV CV'},
      {'expectedOutput' : 'XQ', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'VS'},
      {'expectedOutput' : 'XQXQ', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'VS VS'},
      {'expectedOutput' : 'QX', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'SV'},
      {'expectedOutput' : 'QXQX', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'SV SV'},

      {'expectedOutput' : 'BAAX', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'CB CV'},
      {'expectedOutput' : 'BAAXAX', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'CB CV CV'},
      {'expectedOutput' : 'BAAXAD', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'CB CV BE'},
      {'expectedOutput' : 'AXAXAX', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'CV CV CV'},
      {'expectedOutput' : 'AXAXAB', 'key': '', 'mode': PlayFairMode.JToI, 'input' : 'CV CV BC'},

      {'expectedOutput' : 'HIDETHEGOLDINTHETREXESTUMP', 'key': 'playfair example', 'mode': PlayFairMode.JToI, 'input' : 'BM OD ZB XD NA BE KU DM UI XM MO UV IF'},
      {'expectedOutput' : 'LABOULAYELADYWILLXLEADTOCIBOLATEMPLESOFGOLDX', 'key': 'DEATH', 'mode': PlayFairMode.JToI, 'input' : 'MEIKQOTXCQTEZXCOMWQCTEHNFBIKMEHAKRQCUNGIKMAV'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}, mode: ${elem['mode']}', () {
        var _actual = decryptPlayfair(elem['input'], elem['key'], mode: elem['mode']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}