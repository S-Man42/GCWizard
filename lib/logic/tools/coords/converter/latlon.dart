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

double _DEGPartToDouble(DEGPart degPart) {
  return degPart.sign * (degPart.degrees.abs() + degPart.minutes / 60.0);
}

DEC DEGToDEC(DEG coord) {
  var lat = _DEGPartToDouble(coord.latitude);
  var lon = _DEGPartToDouble(coord.longitude);

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

DEGPart _doubleToDEGPart(double value) {
  var _sign = coordinateSign(value);

  int _degrees = value.abs().floor();
  double _minutes = (value.abs() - _degrees) * 60.0;

  return DEGPart(_sign, _degrees, _minutes);
}

DEG DECToDEG(DEC coord) {
  var normalizedCoord = normalizeDEC(coord);

  var lat = DEGLatitude.from(_doubleToDEGPart(normalizedCoord.latitude));
  var lon = DEGLongitude.from(_doubleToDEGPart(normalizedCoord.longitude));

  return DEG(lat, lon);
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