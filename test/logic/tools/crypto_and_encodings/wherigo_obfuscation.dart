import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/earwigo_tools.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';

void main() {
  group("Obfuscation.Earwigo:", () {
    // GC5K2GK „Stets gern für Sie beschäftigt,…"
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'Leider falsch...', 'expectedOutput' : 'CUXRRd PRbhQUxwv'},
      {'input' : 'Probier es weiter...', 'expectedOutput' : 'GhdPVQc Vi kRUeOi10z'},
      {'input' : 'Doppelmuffelofen', 'expectedOutput' : '8eedRXXeWVTZbRPX'},
      {'input' : 'Weiter gehts....', 'expectedOutput' : 'NUXhRd QVXigyxwv'},
      {'input' : ' Soehne - Die Ofenbauer von Auschwitz', 'expectedOutput' : ' IdSUZP 3 6WR ~PVdQOhQc mec 1gdMYmXhm'}
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = obfuscateEarwigoText(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Obfuscation.Urwigo:", () {
    // GC7HCQG  Das Geheimnis der Premiere
    var dtable = '2;f\\nV\\018\\0054?\'_GUJD\\001\\r+pN\\016k,neO5}{\$=6[\\a\\023]\\015SF\\024L\\019\\"mYr 9\\002Z0KRw<\\027E|\\\\\\003:-qPx(sg@th1X\\bcuz\\031\\025CQMi\\021!\\014&%\\029\\017\\fI\\t\\020Tj`)dy.\\022/\\v3\\000vo*W8bH7\\006\\028BAl~^a>\\030\\026\\004#';
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null,  'dtable' : '', 'expectedOutput' : ''},
      {'input' : '',    'dtable' : '', 'expectedOutput' : ''},
      {'input' : null,  'dtable' : dtable, 'expectedOutput' : ''},
      {'input' : '',    'dtable' : dtable, 'expectedOutput' : ''},

      {'input' : 'Erzaehler', 'dtable' : dtable,  'expectedOutput' : '9.Mz\\025Gw\\025.'},
      {'input' : 'Koordinaten', 'dtable' : dtable,  'expectedOutput' : '4ll.cS\\024zF\\025\\024'},
      {'input' : 'Die Theaterbuehne - Bretter die die Welt bedeuten.', 'dtable' : dtable,  'expectedOutput' : '\\015S\\025/_G\\025zF\\025.pL\\025G\\024\\025/>/u.\\025FF\\025./cS\\025/cS\\025/n\\025wF/p\\025c\\025LF\\025\\024e'},
      {'input' : 'Wie lautet die Kombination?', 'dtable' : dtable,  'expectedOutput' : 'nS\\025/wzLF\\025F/cS\\025/4l,pS\\024zFSl\\024\\t'},
      {'input' : 'Es gibt keinen Spielplan. Du bestimmst, wohin Du gehst und was Du tust.', 'dtable' : dtable,  'expectedOutput' : '9C/DSpF/\\022\\025S\\024\\025\\024/&\\019S\\025w\\019wz\\024e/\\015L/p\\025CFS,,CF\\023/6lGS\\024/\\015L/D\\025GCF/L\\024c/6zC/\\015L/FLCFe'}
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']} dtable: ${elem['dtable']}', () {
        var _actual = obfuscateUrwigoText(elem['input'], elem['dtable']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}
