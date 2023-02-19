import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:latlong/latlong.dart';

void main() {
  final List<Map<String, dynamic>> _inputsToExpectedDEC = [
    {'text': '52.12312 N 20.12312 E', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52.12312 S 20.12312 W', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.12312, -20.12312)}},
    {'text': '00.12312 S 000.12312 W', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-0.12312, -0.12312)}},
    {'text': '52.12312 N, 20.12312 E', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52.12312 S, 20.12312 W', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.12312, -20.12312)}},
    {'text': '52. 12312 N, 20 .12312 E', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52. 12312 S, 20 .12312 W', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.12312, -20.12312)}},
    {'text': '52 . 12312 N, 20.12312 E', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52 . 12312 S, 20.12312 W', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.12312, -20.12312)}},
    {'text': '52.12312N, 20.12312E', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52.12312S, 20.12312W', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.12312, -20.12312)}},
    {'text': '52.12312N 20.12312E', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52.12312S 20.12312W', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.12312, -20.12312)}},
    {'text': '52.12312Nord 20.12312East', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52.12312Süd 20.12312West', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.12312, -20.12312)}},
    {'text': '52.12312 north 20.12312 osten', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52.12312 south 20.12312 westen', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.12312, -20.12312)}},
    {'text': '52 n 20 o', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52, 20)}},
    {'text': '52 s 20 w', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52, -20)}},

    {'text': 'N 52.12312 E 20.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': 'N 52.12312° E 20.12312°', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': 'N 52 .12312 E 20 .  12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': 'N 00.12312 E 000.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(0.12312, 0.12312)}},
    {'text': '52.12312 20.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52. 12312 20. 12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': 'N 2.12312 E 020.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(2.12312, 20.12312)}},
    {'text': '+2.12312 -020.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(2.12312, -20.12312)}},
    {'text': '-2.12312, 020.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-2.12312, 20.12312)}},
    {'text': 'S 2.12312 E 180.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-2.12312, -179.87688)}},
    {'text': 'N52.12312° E20.12312°', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': 'North 52.12312 East20.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': 'North 52,12312, East20,12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': 'North 52,12312, Ost20,12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': 'n 02.12312 w20.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(2.12312, -20.12312)}},
    {'text': 'n 02 w20', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(2.0, -20.0)}},
    {'text': 's 02.12312,W 20.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-2.12312, -20.12312)}},
    {'text': 's 02.12312, W20.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-2.12312, -20.12312)}},
    {'text': 's 02.12312, West 20.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-2.12312, -20.12312)}},
    {'text': ' south 52.2321 E101.12312', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52.2321, 101.12312)}},
    {'text': '92 Westen 0', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(88.0, 180.0)}},
    {'text': 'Süden 92 1', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-88.0, -179.0)}},

    {'text': '52.12312 N 20.12312 E', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52.12312Nord 20.12312East', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '52 s 20 w', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-52, -20)}},

    {'text': 'N 52.12312° E 20.12312° SomeText', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(52.12312, 20.12312)}},
    {'text': '-2.12312, 020.12312SomeMoreText', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(-2.12312, 20.12312)}},
    {'text': '92 Westen 0\nA: 1', 'expectedOutput': {'format': keyCoordsDEC, 'coordinate': LatLng(88.0, 180.0)}},
  ];

  final List<Map<String, dynamic>> _inputsToExpectedDMM = [
    {'text': '52° 12.312\' N 20° 12.312\' E', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '52° 12.312\' S 20° 12.312\' W', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': ' 52°12.312′N 122°12.312′W', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, -122.2052)}},
    {'text': '00° 12.312\' S 000° 12.312\' W', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-0.2052, -0.2052)}},
    {'text': '52° 12.312\' North 20° 12.312\' Ost', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '52° 12.312\' South 20° 12.312\' West', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '52° 12 .312\' North 20° 12. 312\' West', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, -20.2052)}},
    {'text': '52° 12 . 312\' South 20° 12  . 312\' West', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '52 12.312 North 20 12.312 East', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '52 12.312 Süden 20 12.312 Westen', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '52 12.312 N 20 12.312 E', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '52 6.312 S 20 6.312 W', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.1052, -20.1052)}},
    {'text': '52 06.312 S 20 06.312 W', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.1052, -20.1052)}},
    {'text': '52 06.312 S 20 06.312 W', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.1052, -20.1052)}},
    {'text': '52 12.312N 20 12.312East', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '52 12.312S 20 12.312West', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '52 12.312\'N 20°12.312\'East', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '52 12.312\'S 20°12.312\'West', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '052 12.312\'S 20°12.312\'West', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '52 12N, 20 12 East', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
    {'text': '52 12 N 20 12 E', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
    {'text': '52 06 S 20 6 W', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.1, -20.1)}},

    {'text': 'N 52° 12.312\' E 20° 12.312\'', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': 'N 52°12.312\' E 20°12.312\'', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': 'N 52°12. 312\' E 20°12. 312\'', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': 'N 52° 12.312 E 20° 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': 'N 052° 12.312 E 20° 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': 'N 051° 39.688\' E 006° 27.336\'', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(51.66146666666667, 6.4556)}},
    {'text': 'N 152° 12.312 E 20° 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(27.79480000000001, -159.7948)}},
    {'text': 'Süd 52° 12.312 West20° 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': 'N 52 12.312 E 20 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '52 12.312 20 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '-52 12.312 -20 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '52 12.312, 20 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': '52 6.312, 20 06.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.1052, 20.1052)}},
    {'text': 'N52 12.312, E20 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': 'N2 12,312, E020 12,312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(2.2052, 20.2052)}},
    {'text': 'S2 12,312, W020 12,312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-2.2052, -20.2052)}},
    {'text': 'Nord 52 12.312, Ost 20 12.312', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': 'N52 12.15 E20 12.15', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2025, 20.2025)}},
    {'text': 'N52 12 E20 12', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
    {'text': 'N 52 12 E 20 12', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
    {'text': '52 12 20 12', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
    {'text': '52 6 20 06', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.1, 20.1)}},
    {'text': '-52 6 -20 06', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.1, -20.1)}},
    {'text': '-052 6 -20 06', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.1, -20.1)}},

    {'text': '52 12.312S 20 12.312West SomeText', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '52° 12.312\' S 20° 12.312\' W SomeMoreText', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.2052, -20.2052)}},
    {'text': '52 12 N 20 12 E\nA: 1', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},

    {'text': 'N52 12.312, E20 12.312, SomeText', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2052)}},
    {'text': 'N52 12 E20 12\nA: 1, B: 2', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
    {'text': '-52 6 -20 06SomeMoreText', 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(-52.1, -20.1)}},

    {'text': 'N 12.312 E 20.123', 'expectedOutput': null},
    {'text': '12.312 20.123', 'expectedOutput': null},
    {'text': '12.312 N 20.123 E', 'expectedOutput': null},
  ];

  final List<Map<String, dynamic>> _inputsToExpectedDMS = [
    {'text': '52° 12\' 30.15" N 20° 12\' 30.15" E', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52° 12\' 30.15" N, 20° 12\' 30.15" E', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52° 12\' 30.15" S 20° 12\' 30.15" W', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, -20.208375)}},
    {'text': '52° 12\' 30.15" S, 20° 12\' 30.15" W', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, -20.208375)}},
    {'text': '52 12 30.15 S, 20 12 30.15 W', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, -20.208375)}},
    {'text': '52 12 30 .15 S, 20 12 30. 15 E', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, 20.208375)}},
    {'text': '52 12 30.15S, 20 12 30.15W', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, -20.208375)}},
    {'text': '52 12 45 S, 20 12 45 W', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.2125, -20.2125)}},
    {'text': '52 12 45 S, 20 12 45 W', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.2125, -20.2125)}},
    {'text': '52°12\'30.15"N 020°12\'30.15"E', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52°12\'30.15"S 000°12\'30.15"W', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, -0.208375)}},
    {'text': '52°12\'30.15"North, 20°12\'30.15"O', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52°12\'30.15" North, 20°12\'30.15"O', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52°12\'30.15" Süden 20°12\'30.15" Westen', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, -20.208375)}},
    {'text': '052°12\'30.15" Süden 20°12\'30.15" Westen', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, -20.208375)}},

    {'text': 'N 52° 12\' 30.15" E 20° 12\' 30.15"', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'N 52°12\'30.15" E 20°12\'30.15"', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52°12\'30.15" 20°12\'30.15"', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'N 52 12 30.15 E 20 12 30.15', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52 12 30.15 20 12 30.15', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52 12 30.15, 20 12 30.15', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'N52 12 30.15, E20 12 30.15', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'N52 12 30,15, E20 12 30,15', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'North 52 12 30.15, East 20 12 30.15', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'North 52 6 30.15, East 20 06 30.15', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.108375, 20.108375)}},
    {'text': 'North 52 12 30 .15, East 20 12 30. 15', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'N 52 12 45 E 20 12 45', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.2125, 20.2125)}},
    {'text': '52 12 45 20 12 45', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.2125, 20.2125)}},
    {'text': '52 12 9 20 12 09', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.2025, 20.2025)}},
    {'text': '52 6 9 20 6 9', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.1025, 20.1025)}},
    {'text': '52 6 0 20 6 9.0', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.1, 20.1025)}},
    {'text': '052 6 0 20 6 9.0', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.1, 20.1025)}},

    {'text': '52 12 45 S, 20 12 45 W SomeText', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.2125, -20.2125)}},
    {'text': '52° 12\' 30.15" N 20° 12\' 30.15" E SomeMoreText', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52°12\'30.15" Süden 20°12\'30.15" Westen\nA: 42', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(-52.208375, -20.208375)}},

    {'text': 'N 52 12 30.15 E 20 12 30.15 SomeText', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'North 52 12 30.15, East 20 12 30.15SomeText', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': '52 6 0 20 6 9.0ABC', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.1, 20.1025)}},

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

  group("Parser.latlon.parseDEC:", () {
    List<Map<String, dynamic>> _inputsToExpected = _inputsToExpectedDEC;

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseDEC(elem['text']);
        expect(_actual, elem['expectedOutput']['coordinate']);
      });
    });
  });

  group("Parser.latlon.parseDMM:", () {
    List<Map<String, dynamic>> _inputsToExpected = _inputsToExpectedDMM;

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseDMM(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else
          expect(_actual, elem['expectedOutput']['coordinate']);
      });
    });
  });

  group("Parser.latlon.parseDMS:", () {
    List<Map<String, dynamic>> _inputsToExpected = _inputsToExpectedDMS;

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseDMS(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.latlon.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = _inputsToExpectedDEC;
    _inputsToExpected.addAll(_inputsToExpectedDMM);
    _inputsToExpected.addAll(_inputsToExpectedDMS);

    _inputsToExpected
      .where((elem) => elem['expectedOutput'] != null)  // the NULL tests are only for the specific DEC/DEG/DMS tests
      .forEach((elem) {
        test('text: ${elem['text']}', () {
          var _actual = parseLatLon(elem['text']);
          expect(_actual['format'], elem['expectedOutput']['format']);
          expect((_actual['coordinate'].latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual['coordinate'].longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        });
      });
  });

  group("Parser.latlon.parseDMMWithLeftPadMilliminutes:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '52 12\'N 20°12\'East', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
      {'text': '52 12.3\'N 20°12.4\'East', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.205, 20.206666666666)}},
      {'text': '52 12.31\'N 20°12.45\'East', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20516666666666, 20.2075)}},
      {'text': '52 12.312\'N 20°12.458\'East', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.20763333333333)}},
      {'text': '52 12.3127\'N 20°12.4589\'East', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20521166666, 20.20764833333333)}},

      {'text': '52 6 20 06', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.1, 20.1)}},
      {'text': '52 6.3 20 06.4', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.105, 20.1066666666)}},
      {'text': '52 6.31 20 06.45', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.105166666666, 20.1075)}},
      {'text': '52 6.312 20 06.458', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.1052, 20.1076333333)}},
      {'text': '52 6.3127 20 06.4589', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.105211666666, 20.107648333333)}},

      {'text': 'N 52° 12\' E 20° 12\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
      {'text': 'N 52° 12.3\' E 20° 12.4\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.205, 20.206666666666)}},
      {'text': 'N 52° 12.31\' E 20° 12.45\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20516666666666, 20.2075)}},
      {'text': 'N 52° 12.312\' E 20° 12.458\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.20763333333333)}},
      {'text': 'N 52° 12.3127\' E 20° 12.4589\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20521166666, 20.20764833333333)}},

      {'text': 'N 52° 12\' E 20° 12.458\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.20763333333333)}},
      {'text': 'N 52° 12.312\' E 20° 12\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2)}},
      {'text': 'N 52° 12.31\' E 20° 12.4589\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20516666666666, 20.20764833333333)}},

      {'text': 'N 52° 12.3189452\' E 20° 12.15846874\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20531575333333, 20.202641145666668)}},
      {'text': 'N 52° 12.318945258\' E 20° 12.4584687489\'', 'leftPadMilliMinutes': false, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2053157543, 20.207641145815)}},

      {'text': '52 12\'N 20°12\'East', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
      {'text': '52 12.3\'N 20°12.4\'East', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20005, 20.200066666666)}},
      {'text': '52 12.31\'N 20°12.45\'East', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.200516666666, 20.20075)}},
      {'text': '52 12.312\'N 20°12.458\'East', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.20763333333333)}},
      {'text': '52 12.3127\'N 20°12.4589\'East', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.25211666666666, 20.2764833333333)}},

      {'text': '52 6 20 06', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.1, 20.1)}},
      {'text': '52 6.3 20 06.4', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.10005, 20.100066666666)}},
      {'text': '52 6.31 20 06.45', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.100516666666, 20.10075)}},
      {'text': '52 6.312 20 06.458', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.1052, 20.10763333333333)}},
      {'text': '52 6.3127 20 06.4589', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.15211666666, 20.17648333333333)}},

      {'text': 'N 52° 12\' E 20° 12\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
      {'text': 'N 52° 12.3\' E 20° 12.4\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20005, 20.200066666666)}},
      {'text': 'N 52° 12.31\' E 20° 12.45\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.200516666666, 20.20075)}},
      {'text': 'N 52° 12.312\' E 20° 12.458\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.20763333333333)}},
      {'text': 'N 52° 12.3127\' E 20° 12.4589\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.25211666666666, 20.2764833333333)}},

      {'text': 'N 52° 12\' E 20° 12.458\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.20763333333333)}},
      {'text': 'N 52° 12.312\' E 20° 12\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2)}},
      {'text': 'N 52° 12.31\' E 20° 12.4589\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.200516666666, 20.2764833333333)}},

      {'text': 'N 52° 12.3189452\' E 20° 12.15846874\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(74.64246666666666, 104.31456666666668)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}, leftPadMilliMinutes: ${elem['leftPadMilliMinutes']}', () {
        var _actual = parseDMM(elem['text'], leftPadMilliMinutes: elem['leftPadMilliMinutes']);
        expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
        expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
      });
    });
  });
}