import 'package:latlong/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/converter/taisukef/geo3x3/geo3x3.dart' as Geo3x3Converter;

LatLng geo3x3ToLatLon(Geo3x3 geo3x3) {
  return parseGeo3x3ToLatLon(geo3x3.text);
}

LatLng parseGeo3x3ToLatLon(String code) {
  var latLon = Geo3x3Converter.Geo3x3.decode(code.toUpperCase());
  return latLon == null ? null : LatLng(latLon[0], latLon[1]);
}

Geo3x3 parseGeo3x3(String code) {
  var latLon = Geo3x3Converter.Geo3x3.decode(code.toUpperCase());
  return latLon == null ? null : Geo3x3(code);
}

Geo3x3 latLonToGeo3x3(LatLng coord, int level) {
  return Geo3x3(Geo3x3Converter.Geo3x3.encode(coord.latitude, coord.longitude, level));
}
