import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';

double _normalizeLat(double lat) {
  if (lat > 90.0)
    return _normalizeLat(180.0 - lat);
  if (lat < -90.0)
    return _normalizeLat(-180.0 + -lat);

  return lat;
}

double _normalizeLon(double lon) {
  if (lon > 180.0)
    return _normalizeLon(lon - 360.0);
  if (lon < -180.0)
    return _normalizeLon(360.0 + lon);

  return lon;
}

DEC normalizeDEC(DEC coord) {
  var normalizedLat = coord.latitude;
  var normalizedLon = coord.longitude;

  while (normalizedLat > 90.0 || normalizedLat < -90) {
    if (normalizedLat > 90.0) {
      normalizedLat = 180.0 - normalizedLat;
    } else {
      normalizedLat = -180.0 + -normalizedLat;
    }

    normalizedLon += 180.0;
  }

  normalizedLon = _normalizeLon(normalizedLon);

  return DEC(normalizedLat, normalizedLon);
}

double _DMMPartToDouble(DMMPart dmmPart) {
  return dmmPart.sign * (dmmPart.degrees.abs() + dmmPart.minutes / 60.0);
}

DEC DMMToDEC(DMM coord) {
  var lat = _DMMPartToDouble(coord.latitude);
  var lon = _DMMPartToDouble(coord.longitude);

  return normalizeDEC(DEC(lat, lon));
}

double _DMSPartToDouble(DMSPart dmsPart) {
  return dmsPart.sign * (dmsPart.degrees.abs() + dmsPart.minutes / 60.0 + dmsPart.seconds / 60.0 / 60.0);
}

DEC DMSToDEC(DMS coord) {
  var lat = _DMSPartToDouble(coord.latitude);
  var lon = _DMSPartToDouble(coord.longitude);

  return normalizeDEC(DEC(lat, lon));
}

DMMPart _doubleToDMMPart(double value) {
  var _sign = coordinateSign(value);

  int _degrees = value.abs().floor();
  double _minutes = (value.abs() - _degrees) * 60.0;

  return DMMPart(_sign, _degrees, _minutes);
}

DMM DECToDMM(DEC coord) {
  var normalizedCoord = normalizeDEC(coord);

  var lat = DMMLatitude.from(_doubleToDMMPart(normalizedCoord.latitude));
  var lon = DMMLongitude.from(_doubleToDMMPart(normalizedCoord.longitude));

  return DMM(lat, lon);
}

DMSPart _doubleToDMSPart(double value) {
  var _sign = coordinateSign(value);

  int _degrees = value.abs().floor();
  double _minutesD = (value.abs() - _degrees) * 60.0;

  int _minutes = _minutesD.floor();
  double _seconds = (_minutesD - _minutes) * 60.0;

  return DMSPart(_sign, _degrees, _minutes, _seconds);
}

DMS DECToDMS(DEC coord) {
  var normalizedCoord = normalizeDEC(coord);

  var lat = DMSLatitude.from(_doubleToDMSPart(normalizedCoord.latitude));
  var lon = DMSLongitude.from(_doubleToDMSPart(normalizedCoord.longitude));

  return DMS(lat, lon);
}