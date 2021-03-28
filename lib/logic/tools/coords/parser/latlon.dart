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
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:latlong/latlong.dart';

final PATTERN_NO_NUMBERS = r'\s+?';
final PATTERN_NOTHING_OR_NO_NUMBERS = r'\s*?';
final PATTERN_LAT_SIGN = r'([NS][A-Za-zÄÖÜäöü]*?|[\+\-])';
final PATTERN_LON_SIGN = r'([EWO][A-Za-zÄÖÜäöü]*?|[\+\-])';
final PATTERN_LON_SIGN_WITH_SPACE = '(?:\\s+?$PATTERN_LON_SIGN)?';
final PATTERN_LAT_DEGREE_INT = r'(\d{1,2})[\s°]+?';
final PATTERN_LON_DEGREE_INT = r'(\d{1,3})[\s°]+?';
final PATTERN_SECONDS_MINUTES = '([0-5]?[0-9])[\\s\']+?';
final PATTERN_DECIMAL = r'(?:\s*?[\.,]\s*?(\d+))?' + '[\\s\'°"]+?';
final LETTER = '[A-ZÄÖÜ]';

var regexEnd = '';

//wholeString == false: The first match at the text begin is taken - for copy
//wholeString == true: The whole text must be a valid coord - for var coords
Map<String, LatLng> parseLatLon(String text, {wholeString = false}) {
  var coords = Map<String, LatLng>();

  try {
    LatLng coord = parseDMS(text, wholeString: wholeString);
    if (coord != null) coords.addAll({keyCoordsDMS: coord});

    coord = parseDMM(text, wholeString: wholeString);
    if (coord != null) coords.addAll({keyCoordsDMM: coord});

    coord = parseDEC(text, wholeString: wholeString);
    if (coord != null) coords.addAll({keyCoordsDEC: coord});

    coord = parseUTM(text, defaultEllipsoid());
    if (coord != null) coords.addAll({keyCoordsUTM: coord});

    coord = parseMGRS(text, defaultEllipsoid());
    if (coord != null) coords.addAll({keyCoordsMGRS: coord});

    coord = parseWaldmeister(text);
    if (coord != null) coords.addAll({keyCoordsReverseWhereIGoWaldmeister: coord});

    coord = parseXYZ(text, defaultEllipsoid());
    if (coord != null) coords.addAll({keyCoordsXYZ: coord});

    coord = parseSwissGrid(text, defaultEllipsoid());
    if (coord != null) coords.addAll({keyCoordsSwissGrid: coord});

    coord = parseSwissGrid(text, defaultEllipsoid(), isSwissGridPlus: true);
    if (coord != null) coords.addAll({keyCoordsSwissGridPlus: coord});

    coord = parseGaussKrueger(text, defaultEllipsoid());
    if (coord != null) coords.addAll({keyCoordsGaussKrueger: coord});

    coord = maidenheadToLatLon(text);
    if (coord != null) coords.addAll({keyCoordsMaidenhead: coord});

    coord = parseMercator(text, defaultEllipsoid());
    if (coord != null) coords.addAll({keyCoordsMercator: coord});

    coord = parseNaturalAreaCode(text);
    if (coord != null) coords.addAll({keyCoordsNaturalAreaCode: coord});

    coord = geohashToLatLon(text);
    if (coord != null) coords.addAll({keyCoordsGeohash: coord});

    coord = geoHexToLatLon(text);
    if (coord != null) coords.addAll({keyCoordsGeoHex: coord});

    coord = geo3x3ToLatLon(text);
    if (coord != null) coords.addAll({keyCoordsGeo3x3: coord});

    coord = openLocationCodeToLatLon(text);
    if (coord != null) coords.addAll({keyCoordsOpenLocationCode: coord});

    coord = parseQuadtree(text);
    if (coord != null) coords.addAll({keyCoordsQuadtree: coord});

    coord = parseSlippyMap(text);
    if (coord != null) coords.addAll({keyCoordsSlippyMap: coord});
  } catch (e) {}
  return coords;
}

//wholeString == false: The first match at the text begin is taken - for copy
//wholeString == true: The whole text must be a valid coord - for var coords
Map<String, dynamic> parseStandardFormats(String text, {wholeString = false}) {
  LatLng coord = parseDMS(text, wholeString: wholeString);
  if (coord != null) return {'format': keyCoordsDMS, 'coordinate': coord};

  coord = parseDMM(text, wholeString: wholeString);
  if (coord != null) return {'format': keyCoordsDMM, 'coordinate': coord};

  coord = parseDEC(text, wholeString: wholeString);
  if (coord != null) return {'format': keyCoordsDEC, 'coordinate': coord};

  return null;
}
