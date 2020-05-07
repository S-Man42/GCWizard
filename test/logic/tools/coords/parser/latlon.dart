import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:latlong/latlong.dart';

void main() {
  group("Parser.latlon.parseDEC:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '52.12312 N 20.12312 E', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312 S 20.12312 W', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '000.12312 S 000.12312 W', 'expectedOutput': LatLng(-0.12312, -0.12312)},
      {'text': '52.12312 N, 20.12312 E', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312 S, 20.12312 W', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312N, 20.12312E', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312S, 20.12312W', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312N 20.12312E', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312S 20.12312W', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312Nord 20.12312East', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312Süd 20.12312West', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312 north 20.12312 osten', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312 south 20.12312 westen', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52 n 20 o', 'expectedOutput': LatLng(52, 20)},
      {'text': '52 s 20 w', 'expectedOutput': LatLng(-52, -20)},
      {'text': '52. n 20. e', 'expectedOutput': LatLng(52, 20)},
      {'text': '52. s 20. w', 'expectedOutput': LatLng(-52, -20)},

      {'text': 'N 52.12312 E 20.12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'N 00.12312 E 000.12312', 'expectedOutput': LatLng(0.12312, 0.12312)},
      {'text': '52.12312 20.12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'N 52. E 20.', 'expectedOutput': LatLng(52.0, 20.0)},
      {'text': 'N 2.12312 E 020.12312', 'expectedOutput': LatLng(2.12312, 20.12312)},
      {'text': '+2.12312 -020.12312', 'expectedOutput': LatLng(2.12312, -20.12312)},
      {'text': '-2.12312, 020.12312', 'expectedOutput': LatLng(-2.12312, 20.12312)},
      {'text': 'S 2.12312 E 180.12312', 'expectedOutput': LatLng(-2.12312, -179.87688)},
      {'text': 'N52.12312° E20.12312°', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'North 52.12312 East20.12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'North 52,12312, East20,12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'North 52,12312, Ost20,12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'n 02.12312 w20.12312', 'expectedOutput': LatLng(2.12312, -20.12312)},
      {'text': 'n 02 w20,', 'expectedOutput': LatLng(2.0, -20.0)},
      {'text': 's 02.12312,W 20.12312', 'expectedOutput': LatLng(-2.12312, -20.12312)},
      {'text': 's 02.12312, W20.12312', 'expectedOutput': LatLng(-2.12312, -20.12312)},
      {'text': 's 02.12312, West 20.12312', 'expectedOutput': LatLng(-2.12312, -20.12312)},
      {'text': ' south 52.2321 E101.12312', 'expectedOutput': LatLng(-52.2321, 101.12312)},
      {'text': '92 Westen 0', 'expectedOutput': LatLng(88.0, 0.0)},
      {'text': 'Süden 92 1', 'expectedOutput': LatLng(-88.0, 1.0)},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseDEC(elem['text']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Parser.latlon.parseDEG:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '52° 12.312\' N 20° 12.312\' E', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52° 12.312\' S 20° 12.312\' W', 'expectedOutput': LatLng(-52.2052, -20.2052)},
      {'text': '00° 12.312\' S 000° 12.312\' W', 'expectedOutput': LatLng(-0.2052, -0.2052)},
      {'text': '52° 12.312\' North 20° 12.312\' Ost', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52° 12.312\' South 20° 12.312\' West', 'expectedOutput': LatLng(-52.2052, -20.2052)},
      {'text': '52 12.312 North 20 12.312 East', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312 N 20 12.312 E', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312 Süden 20 12.312 Westen', 'expectedOutput': LatLng(-52.2052, -20.2052)},
      {'text': '52 12.312N 20 12.312East', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312S 20 12.312West', 'expectedOutput': LatLng(-52.2052, -20.2052)},
      {'text': '52 12N, 20 12. East', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': '52 12 N 20 12 E', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': '52 12N , 20 12. East', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': '52 12S, 20 12. W', 'expectedOutput': LatLng(-52.2, -20.2)},

      {'text': 'N 52° 12.312\' E 20° 12.312\'', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N 52°12.312\' E 20°12.312\'', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N 52° 12.312 E 20° 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N 52 12.312 E 20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312 20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312, 20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N52 12.312, E20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N2 12,312, E020 12,312', 'expectedOutput': LatLng(2.2052, 20.2052)},
      {'text': 'Nord 52 12.312, Ost 20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N52 12.15 E20 12.15', 'expectedOutput': LatLng(52.2025, 20.2025)},
      {'text': 'N52 12. E20 12.', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': 'N52 12 E20 12', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': 'N 52 12 E 20 12', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': '52 12 20 12', 'expectedOutput': LatLng(52.2, 20.2)},

      {'text': 'N 12.312 E 20.123', 'expectedOutput': null},
      {'text': '12.312 20.123', 'expectedOutput': null},
      {'text': '12.312 N 20.123 E', 'expectedOutput': null},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseDEG(elem['text']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("Parser.latlon.parseDMS:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '52° 12\' 30.15" N 20° 12\' 30.15" E', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52° 12\' 30.15" N, 20° 12\' 30.15" E', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52° 12\' 30.15" S 20° 12\' 30.15" W', 'expectedOutput': LatLng(-52.208375, -20.208375)},
      {'text': '52° 12\' 30.15" S, 20° 12\' 30.15" W', 'expectedOutput': LatLng(-52.208375, -20.208375)},
      {'text': '52 12 30.15 S, 20 12 30.15 W', 'expectedOutput': LatLng(-52.208375, -20.208375)},
      {'text': '52 12 30.15S, 20 12 30.15W', 'expectedOutput': LatLng(-52.208375, -20.208375)},
      {'text': '52 12 45 S, 20 12 45 W', 'expectedOutput': LatLng(-52.2125, -20.2125)},
      {'text': '52°12\'30.15"N 020°12\'30.15"E', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52°12\'30.15"S 000°12\'30.15"W', 'expectedOutput': LatLng(-52.208375, -0.208375)},
      {'text': '52°12\'30.15"North, 20°12\'30.15"O', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52°12\'30.15" North, 20°12\'30.15"', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52°12\'30.15" Süden 20°12\'30.15" Westen', 'expectedOutput': LatLng(-52.208375, -20.208375)},

      {'text': 'N 52° 12\' 30.15" E 20° 12\' 30.15"', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N 52°12\'30.15" E 20°12\'30.15"', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52°12\'30.15" 20°12\'30.15"', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N 52 12 30.15 E 20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52 12 30.15 20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52 12 30.15, 20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N52 12 30.15, E20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N52 12 30,15, E20 12 30,15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'North 52 12 30.15, East 20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N52° 12 minutes 30.15 E20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N 52 12 45. E 20 12 45.', 'expectedOutput': LatLng(52.2125, 20.2125)},
      {'text': 'N 52 12 45 E 20 12 45', 'expectedOutput': LatLng(52.2125, 20.2125)},
      {'text': '52 12 45 20 12 45', 'expectedOutput': LatLng(52.2125, 20.2125)},

      {'text': 'N 52 12 E 20 12', 'expectedOutput': null},
      {'text': '52 12 N 20 12 E', 'expectedOutput': null},
      {'text': '52 12 20 12', 'expectedOutput': null},
      {'text': 'N 12.312 E 20.123', 'expectedOutput': null},
      {'text': '12.312 N 20.123 E', 'expectedOutput': null},
      {'text': '12.312 20.123', 'expectedOutput': null},
      {'text': '52 12.312 20 12.312', 'expectedOutput': null},
      {'text': 'N 52 12.312 E 20 12.312', 'expectedOutput': null},
      {'text': '52 12.312 N 20 12.312 E', 'expectedOutput': null},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseDMS(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput'].longitude).abs() <1e-8, true);
        }
      });
    });
  });

  group("Parser.latlon.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '52.12312 N 20.12312 E', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312 S 20.12312 W', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312 N, 20.12312 E', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312 S, 20.12312 W', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312N, 20.12312E', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312S, 20.12312W', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312N 20.12312E', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312S 20.12312W', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312Nord 20.12312East', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312Süd 20.12312West', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52.12312 north 20.12312 osten', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': '52.12312 south 20.12312 westen', 'expectedOutput': LatLng(-52.12312, -20.12312)},
      {'text': '52 n 20 o', 'expectedOutput': LatLng(52, 20)},
      {'text': '52 s 20 w', 'expectedOutput': LatLng(-52, -20)},
      {'text': '52. n 20. e', 'expectedOutput': LatLng(52, 20)},
      {'text': '52. s 20. w', 'expectedOutput': LatLng(-52, -20)},

      {'text': 'N 52.12312 E 20.12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'N 52. E 20.', 'expectedOutput': LatLng(52.0, 20.0)},
      {'text': 'N 2.12312 E 020.12312', 'expectedOutput': LatLng(2.12312, 20.12312)},
      {'text': '+2.12312 -020.12312', 'expectedOutput': LatLng(2.12312, -20.12312)},
      {'text': '-2.12312, 020.12312', 'expectedOutput': LatLng(-2.12312, 20.12312)},
      {'text': 'S 2.12312 E 180.12312', 'expectedOutput': LatLng(-2.12312, -179.87688)},
      {'text': 'N52.12312° E20.12312°', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'North 52.12312 East20.12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'North 52,12312, East20,12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'North 52,12312, Ost20,12312', 'expectedOutput': LatLng(52.12312, 20.12312)},
      {'text': 'n 02.12312 w20.12312', 'expectedOutput': LatLng(2.12312, -20.12312)},
      {'text': 'n 02 w20,', 'expectedOutput': LatLng(2.0, -20.0)},
      {'text': 's 02.12312,W 20.12312', 'expectedOutput': LatLng(-2.12312, -20.12312)},
      {'text': 's 02.12312, W20.12312', 'expectedOutput': LatLng(-2.12312, -20.12312)},
      {'text': 's 02.12312, West 20.12312', 'expectedOutput': LatLng(-2.12312, -20.12312)},
      {'text': ' south 52.2321 E101.12312', 'expectedOutput': LatLng(-52.2321, 101.12312)},
      {'text': '92 Westen 0', 'expectedOutput': LatLng(88.0, 0.0)},
      {'text': 'Süden 92 1', 'expectedOutput': LatLng(-88.0, 1.0)},

      {'text': '52° 12.312\' N 20° 12.312\' E', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52° 12.312\' S 20° 12.312\' W', 'expectedOutput': LatLng(-52.2052, -20.2052)},
      {'text': '52° 12.312\' North 20° 12.312\' Ost', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52° 12.312\' South 20° 12.312\' West', 'expectedOutput': LatLng(-52.2052, -20.2052)},
      {'text': '52 12.312 North 20 12.312 East', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312 Süden 20 12.312 Westen', 'expectedOutput': LatLng(-52.2052, -20.2052)},
      {'text': '52 12.312N 20 12.312East', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312S 20 12.312West', 'expectedOutput': LatLng(-52.2052, -20.2052)},
      {'text': '52 12N, 20 12. East', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': '52 12N , 20 12. East', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': '52 12S, 20 12. W', 'expectedOutput': LatLng(-52.2, -20.2)},

      {'text': 'N 52° 12.312\' E 20° 12.312\'', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N 52°12.312\' E 20°12.312\'', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N 52° 12.312 E 20° 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N 52 12.312 E 20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312 20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': '52 12.312, 20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N52 12.312, E20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N2 12,312, E020 12,312', 'expectedOutput': LatLng(2.2052, 20.2052)},
      {'text': 'Nord 52 12.312, Ost 20 12.312', 'expectedOutput': LatLng(52.2052, 20.2052)},
      {'text': 'N52 12.15 E20 12.15', 'expectedOutput': LatLng(52.2025, 20.2025)},
      {'text': 'N52 12. E20 12.', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': 'N52 12 E20 12', 'expectedOutput': LatLng(52.2, 20.2)},
      {'text': 'N 52 12 E 20 12', 'expectedOutput': LatLng(52.2, 20.2)},

      {'text': '52° 12\' 30.15" N 20° 12\' 30.15" E', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52° 12\' 30.15" N, 20° 12\' 30.15" E', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52° 12\' 30.15" S 20° 12\' 30.15" W', 'expectedOutput': LatLng(-52.208375, -20.208375)},
      {'text': '52° 12\' 30.15" S, 20° 12\' 30.15" W', 'expectedOutput': LatLng(-52.208375, -20.208375)},
      {'text': '52 12 30.15 S, 20 12 30.15 W', 'expectedOutput': LatLng(-52.208375, -20.208375)},
      {'text': '52 12 30.15S, 20 12 30.15W', 'expectedOutput': LatLng(-52.208375, -20.208375)},
      {'text': '52 12 45 S, 20 12 45 W', 'expectedOutput': LatLng(-52.2125, -20.2125)},
      {'text': '52°12\'30.15"N 020°12\'30.15"E', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52°12\'30.15"S 000°12\'30.15"W', 'expectedOutput': LatLng(-52.208375, -0.208375)},
      {'text': '52°12\'30.15"North, 20°12\'30.15"O', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52°12\'30.15" North, 20°12\'30.15"', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52°12\'30.15" Süden 20°12\'30.15" Westen', 'expectedOutput': LatLng(-52.208375, -20.208375)},

      {'text': 'N 52° 12\' 30.15" E 20° 12\' 30.15"', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N 52°12\'30.15" E 20°12\'30.15"', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52°12\'30.15" 20°12\'30.15"', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N 52 12 30.15 E 20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52 12 30.15 20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': '52 12 30.15, 20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N52 12 30.15, E20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N52 12 30,15, E20 12 30,15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'North 52 12 30.15, East 20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N52° 12 minutes 30.15 E20 12 30.15', 'expectedOutput': LatLng(52.208375, 20.208375)},
      {'text': 'N 52 12 45. E 20 12 45.', 'expectedOutput': LatLng(52.2125, 20.2125)},
      {'text': 'N 52 12 45 E 20 12 45', 'expectedOutput': LatLng(52.2125, 20.2125)},
      {'text': '52 12 45 20 12 45', 'expectedOutput': LatLng(52.2125, 20.2125)},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseLatLon(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput'].longitude).abs() <1e-8, true);
        }
      });
    });
  });
}