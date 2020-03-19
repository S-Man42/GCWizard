import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohash.dart';
import 'package:gc_wizard/logic/tools/coords/converter/latlon.dart';
import 'package:gc_wizard/logic/tools/coords/converter/maidenhead.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mercator.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mgrs.dart';
import 'package:gc_wizard/logic/tools/coords/converter/swissgrid.dart';
import 'package:gc_wizard/logic/tools/coords/converter/utm.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:latlong/latlong.dart';

double mod(double x, double y) {
  return x - y * (x / y).floor();
}

double modLon(double x) {
  x = mod(x, 360);

  if (x > 180)
    x -= 360;

  return x;
}

String formatCoordOutput(LatLng _coords, String _outputFormat, Ellipsoid ells) {
  var _formatted;

  switch (_outputFormat) {
    case keyCoordsDEC: _formatted = decToString(_coords); break;
    case keyCoordsDEG: _formatted = decToDegString(_coords); break;
    case keyCoordsDMS: _formatted = decToDMSString(_coords); break;
    case keyCoordsUTM: return decToUTMString(_coords, ells);
    case keyCoordsMGRS: return decToMGRSString(_coords, ells);
    case keyCoordsSwissGrid: return decToSwissGridString(_coords, ells);
    case keyCoordsSwissGridPlus: return decToSwissGridPlusString(_coords, ells);
    case keyCoordsGaussKrueger1: return decToGaussKruegerString(_coords, 1, ells);
    case keyCoordsGaussKrueger2: return decToGaussKruegerString(_coords, 2, ells);
    case keyCoordsGaussKrueger3: return decToGaussKruegerString(_coords, 3, ells);
    case keyCoordsGaussKrueger4: return decToGaussKruegerString(_coords, 4, ells);
    case keyCoordsGaussKrueger5: return decToGaussKruegerString(_coords, 5, ells);
    case keyCoordsMaidenhead: return decToMaidenheadString(_coords);
    case keyCoordsMercator: return decToMercatorString(_coords, ells);
    case keyCoordsGeohash: return decToGeohashString(_coords, 14);
    default: _formatted = decToString(_coords);
  }

  return '${_formatted['latitude']}\n${_formatted['longitude']}';
}
