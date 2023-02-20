import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/brainfk/ook.dart';

void main() {
  group("Ook.interpretOok:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'code' : null, 'expectedOutput' : ''},
      {'code' : '', 'expectedOutput' : ''},

      {'code' : '.', 'input': 'ABC123', 'expectedOutput' : ''}, // error case: no fitting subsitution
      //Input copy
      {'code' : 'Ook. Ook! Ook! Ook? Ook! Ook. Ook. Ook! Ook? Ook!', 'input': 'ABC123', 'expectedOutput' : 'ABC123'},
      {'code' : 'Ook. Ook! Ook! Ook? Ook! Ook. Ook. Ook! Ook?', 'input': 'ABC123', 'expectedOutput' : 'A'}, // error case: no fitting subsitution

      {'code' : 'Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip? Yip. Yip? Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip! Yip. Yip? Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip. Yip? Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip? Yip. Yip? Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip.'
          ' Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip? Yip. Yip? Yip! Yip. Yip? Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip! Yip. Yip? Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip?'
          ' Yip! Yip! Yip. Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip! Yip? Yip. Yip? Yip! Yip. Yip? Yip! Yip! Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip?'
          ' Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip? Yip. Yip? Yip! Yip. Yip? Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip!'
          ' Yip? Yip! Yip! Yip. Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip? Yip. Yip? Yip!'
          ' Yip. Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip! Yip! Yip! Yip! Yip!'
          ' Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip. Yip? Yip! Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip? Yip.'
          ' Yip? Yip! Yip. Yip? Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip!'
          ' Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip! Yip? Yip! Yip! Yip. Yip? Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip? Yip. Yip? Yip!'
          ' Yip. Yip? Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip. Yip.'
          ' Yip. Yip. Yip. Yip. Yip! Yip. Yip. Yip. Yip. Yip. Yip! Yip. Yip! Yip! Yip!'
          ' Yip! Yip! Yip! Yip! Yip. Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip!'
          'Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip! Yip. Yip? Yip.', 'input': '', 'expectedOutput' : 'free the prof'},
    ];

    _inputsToExpected.forEach((elem) {
      test('code: ${elem['code']}, input: ${elem['input']}', () {
        var _actual = interpretOok(elem['code'], input: elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Ook.generateOok:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text' : null, 'expectedOutput' : ''},
      {'text' : '', 'expectedOutput' : ''},

      //Input copy
      {'text' : 'Verrückt!', 'expectedOutput' : 'Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook. Ook. Ook! Ook. Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook! Ook. Ook? Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook. Ook! Ook? Ook. Ook? Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook! Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook! Ook! Ook! Ook! Ook! Ook.'},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = generateOok(elem['text']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}