import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/coords/converter/dec.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dmm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dms.dart';
import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohash.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohex.dart';
import 'package:gc_wizard/logic/tools/coords/converter/maidenhead.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mercator.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mgrs.dart';
import 'package:gc_wizard/logic/tools/coords/converter/natural_area_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/open_location_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/logic/tools/coords/converter/reverse_whereigo_waldmeister.dart';
import 'package:gc_wizard/logic/tools/coords/converter/slippy_map.dart';
import 'package:gc_wizard/logic/tools/coords/converter/swissgrid.dart';
import 'package:gc_wizard/logic/tools/coords/converter/utm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/xyz.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
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
    {'text': '52° 12\′ 30\″ N, 20°12\′ 31\″ O', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.2083333333, 020.2086111111)}},

    {'text': 'N 52° 12\' 30.15" E 20° 12\' 30.15"', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.208375, 20.208375)}},
    {'text': 'N 52° 12\′ 30\″,O 20°12\′ 31\″', 'expectedOutput': {'format': keyCoordsDMS, 'coordinate': LatLng(52.2083333333, 020.2086111111)}},
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

  group("Parser.dec.parseDEC:", () {
    List<Map<String, dynamic>> _inputsToExpected = _inputsToExpectedDEC;

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseDEC(elem['text']);
        expect(_actual, elem['expectedOutput']['coordinate']);
      });
    });
  });

  group("Parser.dmm.parseDMM:", () {
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

  group("Parser.dms.parseDMS:", () {
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
          expect(_actual.keys.elementAt(0), elem['expectedOutput']['format']);
          expect((_actual.values.elementAt(0).latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.values.elementAt(0).longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        });
      });
  });

  group("Parser.dmm.parseDMMWithLeftPadMilliminutes:", () {
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
      {'text': '52 6.3127 20 06.4589', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.105211666666, 20.107648333333333)}},

      {'text': 'N 52° 12\' E 20° 12\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.2)}},
      {'text': 'N 52° 12.3\' E 20° 12.4\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.20005, 20.200066666666)}},
      {'text': 'N 52° 12.31\' E 20° 12.45\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.200516666666, 20.20075)}},
      {'text': 'N 52° 12.312\' E 20° 12.458\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.20763333333333)}},
      {'text': 'N 52° 12.3127\' E 20° 12.4589\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.205211666666666, 20.20764833333333)}},

      {'text': 'N 52° 12\' E 20° 12.458\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2, 20.20763333333333)}},
      {'text': 'N 52° 12.312\' E 20° 12\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2052, 20.2)}},
      {'text': 'N 52° 12.31\' E 20° 12.4589\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.200516666666665, 20.207648333333335)}},

      {'text': 'N 52° 12.3189452\' E 20° 12.15846874\'', 'leftPadMilliMinutes': true, 'expectedOutput': {'format': keyCoordsDMM, 'coordinate': LatLng(52.2053157533, 20.2026411457)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}, leftPadMilliMinutes: ${elem['leftPadMilliMinutes']}', () {
        var _actual = parseDMM(elem['text'], leftPadMilliMinutes: elem['leftPadMilliMinutes']);
        expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
        expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
      });
    });
  });

  group("Parser.gauss_krueger.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '9392110.611090261', 'expectedOutput': null},
      {'text': '9392110.611090261\n5120027.146589669', 'expectedOutput': {'format': keyCoordsGaussKrueger, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
      {'text': '9392110.611090261, 5120027.146589669', 'expectedOutput': {'format': keyCoordsGaussKrueger, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
      {'text': '9392110.611090261 5120027.146589669', 'expectedOutput': {'format': keyCoordsGaussKrueger, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
      {'text': 'R: 9392110.611090261\nH: 5120027.146589669', 'expectedOutput': {'format': keyCoordsGaussKrueger, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
      {'text': 'r: 9392110.611090261\nh: 5120027.146589669', 'expectedOutput': {'format': keyCoordsGaussKrueger, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
      {'text': 'R:9392110.611090261\nH:5120027.146589669', 'expectedOutput': {'format': keyCoordsGaussKrueger, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
      {'text': 'R 9392110.611090261\nH 5120027.146589669', 'expectedOutput': {'format': keyCoordsGaussKrueger, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
      {'text': 'R9392110.611090261\nH5120027.146589669', 'expectedOutput': {'format': keyCoordsGaussKrueger, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
    ];

    var ells = getEllipsoidByName('coords_ellipsoid_earthsphere');

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseGaussKrueger(elem['text'], ells);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.geohash.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'ö84nys2q8rm9j3', 'expectedOutput': null},
      {'text': 'u84nys2q8rm9j3', 'expectedOutput': {'format': keyCoordsGeoHex, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
      {'text': 'U84nys2q8rm9j3', 'expectedOutput': {'format': keyCoordsGeoHex, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = geohashToLatLon(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.geohex.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'ÖD31365480657013431886', 'expectedOutput': null},
      {'text': 'QD31365480657013431886', 'expectedOutput': {'format': keyCoordsGeoHex, 'coordinate': LatLng(46.211024251, 025.5985061856)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = geoHexToLatLon(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.maidenhead.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'ÖD31365480657013431886', 'expectedOutput': null},
      {'text': 'KN26TF10TP64XX49', 'expectedOutput': {'format': keyCoordsMaidenhead, 'coordinate': LatLng(46.2110242332, 025.5985060764)}},
      {'text': 'kn26tf10tp64xx49', 'expectedOutput': {'format': keyCoordsMaidenhead, 'coordinate': LatLng(46.2110242332, 025.5985060764)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = maidenheadToLatLon(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.mercator.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'Y: 5814230.730194772 X: 2849612.661492129', 'expectedOutput': {'format': keyCoordsMercator, 'coordinate': LatLng(46.25149839125229, 25.62718234979449)}},
      {'text': 'Y:5814230.730194772X:2849612.661492129', 'expectedOutput': {'format': keyCoordsMercator, 'coordinate': LatLng(46.25149839125229, 25.62718234979449)}},
      {'text': 'Y5814230.730194772X2849612.661492129', 'expectedOutput': {'format': keyCoordsMercator, 'coordinate': LatLng(46.25149839125229, 25.62718234979449)}},
      {'text': '5814230.730194772 2849612.661492129', 'expectedOutput': {'format': keyCoordsMercator, 'coordinate': LatLng(46.25149839125229, 25.62718234979449)}},
    ];

    var ells = getEllipsoidByName('coords_ellipsoid_earthsphere');

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseMercator(elem['text'], ells);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.mgrs.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'ÖD31365480657013431886', 'expectedOutput': null},
      {'text': '35T LM 91892.8208 18448.7408', 'expectedOutput': {'format': keyCoordsMGRS, 'coordinate': LatLng(46.04117356610081, 25.598809996225977)}},
      {'text': '35 T LM 91892.8208 18448.7408', 'expectedOutput': {'format': keyCoordsMGRS, 'coordinate': LatLng(46.04117356610081, 25.598809996225977)}},
      {'text': '35T LM 91892 18448', 'expectedOutput': {'format': keyCoordsMGRS, 'coordinate': LatLng(46.04116677326809, 25.59879952996897)}},
      {'text': '35T LM 9189218448', 'expectedOutput': {'format': keyCoordsMGRS, 'coordinate': LatLng(46.04116677326809, 25.59879952996897)}},
      {'text': '35TLM9189218448', 'expectedOutput': {'format': keyCoordsMGRS, 'coordinate': LatLng(46.04116677326809, 25.59879952996897)}},
      {'text': '35T LM 9189 1844', 'expectedOutput': {'format': keyCoordsMGRS, 'coordinate': LatLng(46.04109450354022, 25.598775440767994)}},
      {'text': '35T LM 918 184', 'expectedOutput': {'format': keyCoordsMGRS, 'coordinate': LatLng(46.0407204797636, 25.59761842865664)}},
    ];

    var ells = getEllipsoidByName('coords_ellipsoid_earthsphere');

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseMGRS(elem['text'], ells);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.natural_area_code.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'K3ZVLFSSQP1MKBNZ', 'expectedOutput': null},
      {'text': 'K3ZVLFSS QP1MKBNZ', 'expectedOutput': {'format': keyCoordsNaturalAreaCode, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'X: K3ZVLFSS Y: QP1MKBNZ', 'expectedOutput': {'format': keyCoordsNaturalAreaCode, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'X:K3ZVLFSS Y:QP1MKBNZ', 'expectedOutput': {'format': keyCoordsNaturalAreaCode, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'X K3ZVLFSS Y QP1MKBNZ', 'expectedOutput': {'format': keyCoordsNaturalAreaCode, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseNaturalAreaCode(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.open_location_code.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'AGR76H6X+C95QFH', 'expectedOutput': null},
      {'text': '1GR76H6X+C95QFH', 'expectedOutput': null},
      {'text': '8GR76H6X+C95QFH', 'expectedOutput': {'format': keyCoordsOpenLocationCode, 'coordinate': LatLng(46.2110175, 025.5984958496)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = openLocationCodeToLatLon(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.quadtree.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '1203203022132122220122000301310333201333', 'expectedOutput': {'format': keyCoordsQuadtree, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': '41203203022132122220122000301310333201333', 'expectedOutput': null},
      {'text': 'A1203203022132122220122000301310333201333', 'expectedOutput': null},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseQuadtree(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.reverse_whereigo_waldmeister.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '104181 924569 248105', 'expectedOutput': {'format': keyCoordsReverseWhereIGoWaldmeister, 'coordinate': LatLng(46.21101, 025.59849)}},
      {'text': '104181\n924569\n248105', 'expectedOutput': {'format': keyCoordsReverseWhereIGoWaldmeister, 'coordinate': LatLng(46.21101, 025.59849)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseWaldmeister(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.slippy_map.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '584.813499 363.434344', 'expectedOutput': {'format': keyCoordsSlippyMap, 'coordinate': LatLng(46.211017406, 025.5984957422)}},
      {'text': 'X: 584.813499 Y: 363.434344', 'expectedOutput': {'format': keyCoordsSlippyMap, 'coordinate': LatLng(46.211017406, 025.5984957422)}},
      {'text': 'X:584.813499 Y:363.434344', 'expectedOutput': {'format': keyCoordsSlippyMap, 'coordinate': LatLng(46.211017406, 025.5984957422)}},
      {'text': 'X:584.813499 Y:363.434344', 'expectedOutput': {'format': keyCoordsSlippyMap, 'coordinate': LatLng(46.211017406, 025.5984957422)}},
      {'text': 'X584.813499Y363.434344', 'expectedOutput': {'format': keyCoordsSlippyMap, 'coordinate': LatLng(46.211017406, 025.5984957422)}},
      {'text': 'x584.813499y363.434344', 'expectedOutput': {'format': keyCoordsSlippyMap, 'coordinate': LatLng(46.211017406, 025.5984957422)}},
    ];

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseSlippyMap(elem['text']);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.swissgrid.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '1989048.7411670878 278659.94052181806', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'Y: 1989048.7411670878 X: 278659.94052181806', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'Y:1989048.7411670878 X:278659.94052181806', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'Y:1989048.7411670878X:278659.94052181806', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'Y1989048.7411670878X278659.94052181806', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'y1989048.7411670878x278659.94052181806', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
    ];

    var ells = getEllipsoidByName('coords_ellipsoid_earthsphere');

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseSwissGrid(elem['text'], ells);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.swissgrid_plus.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '3989048.741167088 1278659.9405218181', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'Y: 3989048.741167088 X: 1278659.9405218181', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'Y:3989048.741167088 X:1278659.9405218181', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'Y:3989048.741167088X:1278659.9405218181', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'Y3989048.741167088X1278659.9405218181', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
      {'text': 'y3989048.741167088x1278659.9405218181', 'expectedOutput': {'format': keyCoordsSwissGrid, 'coordinate': LatLng(46.2110174566, 025.598495717)}},
    ];

    var ells = getEllipsoidByName('coords_ellipsoid_earthsphere');

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseSwissGrid(elem['text'], ells, isSwissGridPlus: true);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.utm.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': '35 T 391892.0 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T 391892.0 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T391892.0 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T W 391892.0 N 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T mW 391892.0 mN 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T m W 391892.0 m N 5118448.0002', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35TmW391892mN5118448', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35TW391892N5118448', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},

      {'text': '35T 391892.0 W 5118448.0002 N', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T 391892.0 mW 5118448.0002 mN', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T 391892.0 m W 5118448.0002 m N', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T391892mW5118448mN', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T391892W5118448N', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},

      {'text': '35T3918925118448', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(46.04116677506691, 25.59879952992334)}},
      {'text': '35T5701685650300', 'expectedOutput': {'format': keyCoordsUTM, 'coordinate': LatLng(50.83043359228835, 27.99948922153779)}},

    ];

    var ells = getEllipsoidByName('coords_ellipsoid_earthsphere');

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseUTM(elem['text'], ells);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });

  group("Parser.xyz.parseLatLon:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'text': '', 'expectedOutput': null},
      {'text': 'X: 3987428.547121 Y: 1910326.935629 Z: 4581509.856737', 'expectedOutput': {'format': keyCoordsXYZ, 'coordinate': LatLng(46.01873890823172, 25.598495717002137)}},
      {'text': 'X: 3987428.547121\nY: 1910326.935629\nZ: 4581509.856737', 'expectedOutput': {'format': keyCoordsXYZ, 'coordinate': LatLng(46.01873890823172, 25.598495717002137)}},
      {'text': 'X:3987428.547121Y:1910326.935629Z:4581509.856737', 'expectedOutput': {'format': keyCoordsXYZ, 'coordinate': LatLng(46.01873890823172, 25.598495717002137)}},
      {'text': 'X3987428.547121Y1910326.935629Z4581509.856737', 'expectedOutput': {'format': keyCoordsXYZ, 'coordinate': LatLng(46.01873890823172, 25.598495717002137)}},
      {'text': '3987428.547121 1910326.935629 4581509.856737', 'expectedOutput': {'format': keyCoordsXYZ, 'coordinate': LatLng(46.01873890823172, 25.598495717002137)}},
    ];

    var ells = getEllipsoidByName('coords_ellipsoid_earthsphere');

    _inputsToExpected.forEach((elem) {
      test('text: ${elem['text']}', () {
        var _actual = parseXYZ(elem['text'], ells);
        if (_actual == null)
          expect(null, elem['expectedOutput']);
        else {
          expect((_actual.latitude - elem['expectedOutput']['coordinate'].latitude).abs() < 1e-8, true);
          expect((_actual.longitude - elem['expectedOutput']['coordinate'].longitude).abs() < 1e-8, true);
        }
      });
    });
  });
}