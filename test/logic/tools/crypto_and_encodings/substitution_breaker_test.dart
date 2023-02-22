//TODO: Problem: The word lists are assets. Currently there're certain problems to load the assets in the tests
// Either: Get loading working
// Or: Do tests with a hand-written minimum word list

// import "package:flutter_test/flutter_test.dart";
//
// void main() {
  var text10 = '''Rbo rpktigo vcrb bwucja wj kloj hcjd, km sktpqo, cq rbwr loklgo
  vcgg cjqcqr kj skhcja wgkja wjd rpycja rk ltr rbcjaq cj cr.
  -- Roppy Lpwrsborr''';
//   var text11 = '''The trouble with having an open mind, of course, is that people
//   will insist on coming along and trying to put things in it.
//   -- Terry Pratchett''';
//
  var text12 = "Yvlkv zjk avuvi Rlkfyvijkvccvi ze uvi Crxv jkribv Dfkfive ql srlve, ufty "
      "rccvj yrk jvzev Xiveqve, jfejk nrvive ar rccv reuvive uzv jzty rej Xvjvkq "
      "yrckve uzv Ulddve.";
//   var text13 = "Heute ist jeder Autohersteller in der Lage starke Motoren zu bauen, doch "
//       "alles hat seine Grenzen, sonst waeren ja alle anderen die sich ans Gesetz "
//       "halten die Dummen.";
//
//   var text14 = "Agl qrxlrq okii bl t itxakhj ugexknti alxatqlha ad gkx gtsm odsy thm "
//       "pkxkdh, thm okii gdrxl agl uslxakjkdrx ndiilnakdh gl ntslm xd mlluie tbdra, "
//       "vds qthe eltsx ad ndql.";
//   var text15 = "The museum will be a lasting physical testament to his hard work and "
//       "vision, and will house the prestigious collection he cared so deeply about, "
//       "for many years to come.";
//
//   //TODO: Problem: The word lists are assets. Currently there're certain problems to load the assets in the tests
//   // Either: Get loading working
//   // Or: Do tests with a hand-written minimum word list
//
//   group("substitution_breaker.breaker:", () {
//     List<Map<String, Object?>> _inputsToExpected = [
//       {'input' : null, 'alphabet' : BreakerAlphabet.English, 'errorCode' : ErrorCode.OK, 'expectedOutput' : ''},
//       {'input' : '', 'alphabet' : BreakerAlphabet.English, 'errorCode' : ErrorCode.OK, 'expectedOutput' : ''},
//
//       {'input' : text10, 'alphabet' : BreakerAlphabet.English, 'errorCode' : ErrorCode.OK, 'expectedOutput' : text11},
//       {'input' : text12, 'alphabet' : BreakerAlphabet.German, 'errorCode' : ErrorCode.OK, 'expectedOutput' : text13},
//       {'input' : text14, 'alphabet' : BreakerAlphabet.English, 'errorCode' : ErrorCode.OK, 'expectedOutput' : text15},
//     ];
//
//     _inputsToExpected.forEach((elem) async {
//       while(_isStarted){};
//       _isStarted = true;
//
//       test('input: ${elem['input']}', () async {
//
//         var quad = await getQuadgram(elem['alphabet']);
//         var _actual = await break_cipher(elem['input'], quad);
//         expect(_actual.plaintext, elem['expectedOutput']);
//         expect(_actual.errorCode, elem['errorCode']);
//       });
//       _isStarted = false;
//     });
//   });
//
//   group("substitution_breaker.calc_fitness:", () {
//     var en = EnglishQuadgrams();
//     var de = GermanQuadgrams();
//
//     List<Map<String, Object?>> _inputsToExpected = [
//
//       {'input' : null, 'expectedOutput' : null},
//       {'input' : '', 'expectedOutput' : null},
//
//       {'input' : text15, 'alphabet' : en.alphabet, 'quadgrams' : en.quadgrams(), 'expectedOutput' : 103},
//       {'input' : text13, 'alphabet' : de.alphabet, 'quadgrams' : de.quadgrams(), 'expectedOutput' : 103},
//       {'input' : text14, 'alphabet' : en.alphabet, 'quadgrams' : en.quadgrams(), 'expectedOutput' : 27},
//       {'input' : 'tion', 'alphabet' : en.alphabet, 'quadgrams' : en.quadgrams(), 'expectedOutput' : 136},
//       {'input' : 'ti', 'alphabet' : en.alphabet, 'quadgrams' : en.quadgrams(), 'expectedOutput' : null},
//     ];
//
//     _inputsToExpected.forEach((elem) async {
//       test('input: ${elem['input']}', () async {
//         var _actual = calc_fitness(elem['input'], alphabet: elem['alphabet'], quadgrams: await en.quadgrams()); // elem['quadgrams']
//         expect(_actual != null ? _actual.round() : _actual, elem['expectedOutput']);
//       });
//     });
//   });
// }