import 'package:latlong2/latlong.dart';
import 'package:gc_wizard/tools/coords/data/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/external_libs/chsh/geohex4j/logic/geohex.dart';

LatLng geoHexToLatLon(GeoHex geoHex) {
  try {
    Zone zone = getZoneByCode(geoHex.text);
    return LatLng(zone.lat, zone.lon);
  } catch (e) {}

  return null;
}

GeoHex parseGeoHex(String input) {
  if (input == null) return null;
  input = input.trim();
  if (input == '') return null;

  var _geoHex = GeoHex(input);
  return geoHexToLatLon(_geoHex) == null ? null : _geoHex;
}

GeoHex latLonToGeoHex(LatLng coord, int precision) {
  Zone zone = getZoneByLocation(coord.latitude, coord.longitude, precision);
  return GeoHex(zone.code);
}
