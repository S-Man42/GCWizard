import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohash.dart';
import 'package:gc_wizard/logic/tools/coords/converter/maidenhead.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mercator.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mgrs.dart';
import 'package:gc_wizard/logic/tools/coords/converter/open_location_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/logic/tools/coords/converter/reverse_whereigo_waldmeister.dart';
import 'package:gc_wizard/logic/tools/coords/converter/slippy_map.dart';
import 'package:gc_wizard/logic/tools/coords/converter/swissgrid.dart';
import 'package:gc_wizard/logic/tools/coords/converter/utm.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/utils/common_utils.dart';
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

String formatCoordOutput(LatLng _coords, Map<String, String> _outputFormat, Ellipsoid ells) {
  int _getGKCode() {
    switch (_outputFormat['subtype']) {
      case keyCoordsGaussKruegerGK1: return 1;
      case keyCoordsGaussKruegerGK2: return 2;
      case keyCoordsGaussKruegerGK3: return 3;
      case keyCoordsGaussKruegerGK4: return 4;
      case keyCoordsGaussKruegerGK5: return 5;
      default: return 0;
    }
  }

  var _formatted;

  switch (_outputFormat['format']) {
    case keyCoordsDEC: _formatted = DEC.from(_coords).format(); break;
    case keyCoordsDEG: _formatted = DEG.from(_coords).format(); break;
    case keyCoordsDMS: _formatted = DMS.from(_coords).format(); break;
    case keyCoordsUTM: return latLonToUTMString(_coords, ells);
    case keyCoordsMGRS: return latLonToMGRSString(_coords, ells);
    case keyCoordsSwissGrid: return decToSwissGridString(_coords, ells);
    case keyCoordsSwissGridPlus: return latLonToSwissGridPlusString(_coords, ells);
    case keyCoordsGaussKrueger: return latLonToGaussKruegerString(_coords, _getGKCode(), ells);
    case keyCoordsMaidenhead: return latLonToMaidenhead(_coords);
    case keyCoordsMercator: return latLonToMercator(_coords, ells).toString();
    case keyCoordsSlippyMap: return latLonToSlippyMapString(_coords, double.tryParse(_outputFormat['subtype']));
    case keyCoordsGeohash: return latLonToGeohash(_coords, 14);
    case keyCoordsOpenLocationCode: return latLonToOpenLocationCode(_coords, codeLength: 14);
    case keyCoordsQuadtree: return latLonToQuadtree(_coords).join();
    case keyCoordsReverseWhereIGoWaldmeister: return latLonToWaldmeisterString(_coords);
    default: _formatted = DEC.from(_coords).format();
  }

  return '${_formatted['latitude']}\n${_formatted['longitude']}';
}

int coordinateSign(double value) {
  return value == 0 ? 1 : value.sign.floor();
}

bool coordEquals(LatLng coords1, LatLng coords2, {tolerance: 1e-10}) {
  return doubleEquals(coords1.latitude, coords2.latitude)
    && doubleEquals(coords1.longitude, coords2.longitude);
}