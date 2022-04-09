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
      {'path': r'H:\Meine Ablage\PietSharp-main\Images\Piet_hello_artistic2.gif', 'expectedOutput': ''},
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
