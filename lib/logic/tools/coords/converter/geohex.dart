import 'package:latlong/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/converter/chsh/geohex4j/geohex.dart';

LatLng geoHexToLatLon(GeoHex geoHex) {
  return parseGeoHexToLatLon(geoHex.text);
}

LatLng parseGeoHexToLatLon(String geoHex) {
  try {
    Zone zone = getZoneByCode(geoHex);
    return LatLng(zone.lat, zone.lon);
  } catch (e) {}

  return null;
}

GeoHex parseGeoHex(String geoHex) {
  return parseGeoHexToLatLon(geoHex) == null ? null : GeoHex(geoHex);
}

GeoHex latLonToGeoHex(LatLng coord, int precision) {
  Zone zone = getZoneByLocation(coord.latitude, coord.longitude, precision);
  return GeoHex(zone.code);
}
