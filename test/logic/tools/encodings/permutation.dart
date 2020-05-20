import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/encodings/permutation.dart';

void main() {
  group("DuckSpeak.encodeDuckSpeak:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'avoidDouble': true, 'expectedOutput' : []},
      {'input' : null, 'avoidDouble': false, 'expectedOutput' : []},
      {'input' : '', 'avoidDouble': true, 'expectedOutput' : []},
      {'input' : '', 'avoidDouble': false, 'expectedOutput' : []},

      {'input' : 'Hallo', 'avoidDouble': true, 'expectedOutput' : ["Hallo", "aHllo", "laHlo", "alHlo", "Hlalo", "lHalo", "lalHo", "allHo", "llaHo", "Hllao", "lHlao", "llHao", "oallH", "aollH", "laolH", "alolH", "olalH", "loalH", "laloH", "alloH", "llaoH", "ollaH", "lolaH", "lloaH", "Holla", "oHlla", "loHla", "olHla", "Hlola", "lHola", "lolHa", "ollHa", "lloHa", "Hlloa", "lHloa", "llHoa", "Haoll", "aHoll", "oaHll", "aoHll", "Hoall", "oHall", "laoHl", "aloHl", "oalHl", "aolHl", "loaHl", "olaHl", "Hloal", "lHoal", "olHal", "loHal", "Holal", "oHlal", "Halol", "aHlol", "laHol", "alHol", "Hlaol", "lHaol"]},
      {'input' : 'Hallo', 'avoidDouble': false, 'expectedOutput' : ["Hallo", "aHllo", "laHlo", "alHlo", "Hlalo", "lHalo", "lalHo", "allHo", "lalHo", "allHo", "llaHo", "llaHo", "Hllao", "lHlao", "llHao", "llHao", "Hllao", "lHlao", "Hallo", "aHllo", "laHlo", "alHlo", "Hlalo", "lHalo", "oallH", "aollH", "laolH", "alolH", "olalH", "loalH", "laloH", "alloH", "laloH", "alloH", "llaoH", "llaoH", "ollaH", "lolaH", "lloaH", "lloaH", "ollaH", "lolaH", "oallH", "aollH", "laolH", "alolH", "olalH", "loalH", "Holla", "oHlla", "loHla", "olHla", "Hlola", "lHola", "lolHa", "ollHa", "lolHa", "ollHa", "lloHa", "lloHa", "Hlloa", "lHloa", "llHoa", "llHoa", "Hlloa", "lHloa", "Holla", "oHlla", "loHla", "olHla", "Hlola", "lHola", "Haoll", "aHoll", "oaHll", "aoHll", "Hoall", "oHall", "laoHl", "aloHl", "oalHl", "aolHl", "loaHl", "olaHl", "Hloal", "lHoal", "olHal", "loHal", "Holal", "oHlal", "Halol", "aHlol", "laHol", "alHol", "Hlaol", "lHaol", "Halol", "aHlol", "laHol", "alHol", "Hlaol", "lHaol", "oalHl", "aolHl", "laoHl", "aloHl", "olaHl", "loaHl", "Holal", "oHlal", "loHal", "olHal", "Hloal", "lHoal", "Haoll", "aHoll", "oaHll", "aoHll", "Hoall", "oHall"]},
      {'input' : '123', 'avoidDouble': true, 'expectedOutput' : ["123", "213", "321", "231", "132", "312"]},
      {'input' : '123', 'avoidDouble': false, 'expectedOutput' : ["123", "213", "321", "231", "132", "312"]},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']} ${elem['avoidDouble']}', () {
        var _actual = buildPermutation(elem['input'], elem['avoidDouble']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
