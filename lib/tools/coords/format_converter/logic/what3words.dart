
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:latlong2/latlong.dart';

What3Words latLonToWhat3Words(LatLng coord,) {

  return What3Words('test1', 'test2', 'test3', CoordinateFormatKey.WHAT3WORDS_DE);
}

LatLng What3WordsToLatLon(What3Words What3Words) {

  return LatLng(0, 0);
}

What3Words? parseWhat3Words(String input) {
  if (input.isEmpty) return null;

  if (input.split('.').length != 3) return null;

  List<String> words = input.split('.');
  return What3Words(words[0], words[1], words[2], CoordinateFormatKey.WHAT3WORDS_DE);
}


