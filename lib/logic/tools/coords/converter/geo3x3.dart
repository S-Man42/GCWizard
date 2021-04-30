import 'package:latlong/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/converter/taisukef/geo3x3/geo3x3.dart';

LatLng geo3x3ToLatLon(String code) {
  var latLon = Geo3x3.decode(code.toUpperCase());
  return LatLng(latLon[0], latLon[1]);
}

String latLonToGeo3x3(LatLng coord, int level) {
  return Geo3x3.encode(coord.latitude, coord.longitude, level);
}

LatLng parseGeo3x3(String input) {
  if (input == null) return null;
  input = input.trim();

  if (input == '') return null;
  if (RegExp(r'[EeWw][1-9]+').hasMatch(input)) {
    return geo3x3ToLatLon(input);
  }

  return null;
}
