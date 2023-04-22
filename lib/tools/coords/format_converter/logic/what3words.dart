
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:latlong2/latlong.dart';

const int _DEFAULT_PRECISION = 40;

What3Words latLonToWhat3Words(LatLng coord, {int precision = _DEFAULT_PRECISION}) {

  return What3Words('test1', 'test2', 'test3');
}

LatLng What3WordsToLatLon(What3Words What3Words) {

  return LatLng(0, 0);
}

What3Words? parseWhat3Words(String input) {
  if (input.isEmpty) return null;

  if (input.split('.').length != 3) return null;

  List<String> words = input.split('.');
  return What3Words(words[0], words[1], words[2]);
}


