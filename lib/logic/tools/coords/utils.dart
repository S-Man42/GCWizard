import 'package:gc_wizard/logic/tools/coords/converter/dec.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dmm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/dms.dart';
import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geo3x3.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohash.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohex.dart';
import 'package:gc_wizard/logic/tools/coords/converter/maidenhead.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mercator.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mgrs.dart';
import 'package:gc_wizard/logic/tools/coords/converter/natural_area_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/open_location_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/logic/tools/coords/converter/reverse_whereigo_waldmeister.dart';
import 'package:gc_wizard/logic/tools/coords/converter/slippy_map.dart';
import 'package:gc_wizard/logic/tools/coords/converter/swissgrid.dart';
import 'package:gc_wizard/logic/tools/coords/converter/utm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/xyz.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:latlong/latlong.dart';

double mod(double x, double y) {
  return x - y * (x / y).floor();
}

double modLon(double x) {
  x = mod(x, 360);

  if (x > 180) x -= 360;

  return x;
}

String formatCoordOutput(LatLng _coords, Map<String, String> _outputFormat, Ellipsoid ells, [int precision]) {
  int _getGKCode() {
    switch (_outputFormat['subtype']) {
      case keyCoordsGaussKruegerGK1:
        return 1;
      case keyCoordsGaussKruegerGK2:
        return 2;
      case keyCoordsGaussKruegerGK3:
        return 3;
      case keyCoordsGaussKruegerGK4:
        return 4;
      case keyCoordsGaussKruegerGK5:
        return 5;
      default:
        return 0;
    }
  }

  switch (_outputFormat['format']) {
    case keyCoordsDEC:
      return latLonToDECString(_coords, precision);
    case keyCoordsDMM:
      return latLonToDMMString(_coords, precision);
    case keyCoordsDMS:
      return latLonToDMSString(_coords, precision);
    case keyCoordsUTM:
      return latLonToUTMString(_coords, ells);
    case keyCoordsMGRS:
      return latLonToMGRSString(_coords, ells);
    case keyCoordsXYZ:
      return latLonToXYZString(_coords, ells);
    case keyCoordsSwissGrid:
      return decToSwissGridString(_coords, ells);
    case keyCoordsSwissGridPlus:
      return latLonToSwissGridPlusString(_coords, ells);
    case keyCoordsGaussKrueger:
      return latLonToGaussKruegerString(_coords, _getGKCode(), ells);
    case keyCoordsMaidenhead:
      return latLonToMaidenhead(_coords);
    case keyCoordsMercator:
      return latLonToMercator(_coords, ells).toString();
    case keyCoordsNaturalAreaCode:
      return latLonToNaturalAreaCode(_coords).toString();
    case keyCoordsSlippyMap:
      return latLonToSlippyMapString(_coords, double.tryParse(_outputFormat['subtype']));
    case keyCoordsGeohash:
      return latLonToGeohash(_coords, 14);
    case keyCoordsGeoHex:
      return latLonToGeoHex(_coords, 20);
    case keyCoordsGeo3x3:
      return latLonToGeo3x3(_coords, 20);
    case keyCoordsOpenLocationCode:
      return latLonToOpenLocationCode(_coords, codeLength: 14);
    case keyCoordsQuadtree:
      return latLonToQuadtree(_coords).join();
    case keyCoordsReverseWhereIGoWaldmeister:
      return latLonToWaldmeisterString(_coords);
    default:
      return latLonToDECString(_coords);
  }
}

int coordinateSign(double value) {
  return value == 0 ? 1 : value.sign.floor();
}

bool coordEquals(LatLng coords1, LatLng coords2, {tolerance: 1e-10}) {
  return doubleEquals(coords1.latitude, coords2.latitude) && doubleEquals(coords1.longitude, coords2.longitude);
}

double normalizeBearing(double bearing) {
  return modulo(bearing, 360.0);
}
