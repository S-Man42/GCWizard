import 'package:latlong/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/converter/chsh/geohex4j/geohex.dart';

LatLng geoHexToLatLon(GeoHex geoHex) {
  try {
    Zone zone = getZoneByCode(geoHex.text);
    return LatLng(zone.lat, zone.lon);
  } catch (e) {}

  return null;
}

GeoHex parseGeoHex(String geoHex) {
  var _geoHex = GeoHex(geoHex);
  return geoHexToLatLon(_geoHex) == null ? null : _geoHex;
}

GeoHex latLonToGeoHex(LatLng coord, int precision) {
  Zone zone = getZoneByLocation(coord.latitude, coord.longitude, precision);
  return GeoHex(zone.code);
}
