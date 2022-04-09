import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_image_reader.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_io.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/piet_session.dart';
import 'package:gc_wizard/widgets/utils/file_utils.dart';

void main() {
  group("Piet.PietSession:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      // {'code': null, 'expectedOutput': ''},
      // {'code': '', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_hello_artistic2.gif', 'expectedOutput': ''},
      //{'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_alpha_filled.png', 'expectedOutput': ''},
       {'path': r'H:\Meine Ablage\PietSharp-main\Images\piet_factorial_big.png', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_fizzbuzz.png', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_hello.png', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_hello_artistic.gif', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_helloworld-mondrian-big.png', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_nfib.gif', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_nprime.gif', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_power2_big.png', 'expectedOutput': ''},
      // {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_tetris.png', 'expectedOutput': ''},
    ];

    _inputsToExpected.forEach((elem) {
      test('path: ${elem['path']}, input: ${elem['input']}', () async {

        var data  = await readByteDataFromFile(elem['path']);
        var imageReader = PietImageReader();
        var _pietPixels = imageReader.ReadImage(data);
        var _pietIO = PietIO();

        var pietSession = PietSession(_pietPixels, _pietIO);

        pietSession.Run();
        // var _actual = interpretCow(elem['path']).output;
        // expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
