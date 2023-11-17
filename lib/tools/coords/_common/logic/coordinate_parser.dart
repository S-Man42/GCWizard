import 'package:gc_wizard/tools/coords/_common/formats/dec/logic/dec.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dmm/logic/dmm.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dms/logic/dms.dart';
import 'package:gc_wizard/tools/coords/_common/formats/dutchgrid/logic/dutchgrid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/gausskrueger/logic/gauss_krueger.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geo3x3/logic/geo3x3.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geohash/logic/geohash.dart';
import 'package:gc_wizard/tools/coords/_common/formats/geohex/logic/geohex.dart';
import 'package:gc_wizard/tools/coords/_common/formats/lambert/logic/lambert.dart';
import 'package:gc_wizard/tools/coords/_common/formats/maidenhead/logic/maidenhead.dart';
import 'package:gc_wizard/tools/coords/_common/formats/makaney/logic/makaney.dart';
import 'package:gc_wizard/tools/coords/_common/formats/mercator/logic/mercator.dart';
import 'package:gc_wizard/tools/coords/_common/formats/mgrs_utm/logic/mgrs.dart';
import 'package:gc_wizard/tools/coords/_common/formats/natural_area_code/logic/natural_area_code.dart';
import 'package:gc_wizard/tools/coords/_common/formats/openlocationcode/logic/open_location_code.dart';
import 'package:gc_wizard/tools/coords/_common/formats/quadtree/logic/quadtree.dart';
import 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_day1976/logic/reverse_wherigo_day1976.dart';
import 'package:gc_wizard/tools/coords/_common/formats/reversewherigo_waldmeister/logic/reverse_wherigo_waldmeister.dart';
import 'package:gc_wizard/tools/coords/_common/formats/slippymap/logic/slippy_map.dart';
import 'package:gc_wizard/tools/coords/_common/formats/swissgrid/logic/swissgrid.dart';
import 'package:gc_wizard/tools/coords/_common/formats/swissgridplus/logic/swissgridplus.dart';
import 'package:gc_wizard/tools/coords/_common/formats/utm/logic/utm.dart';
import 'package:gc_wizard/tools/coords/_common/formats/xyz/logic/xyz.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:latlong2/latlong.dart';


//wholeString == false: The first match at the text begin is taken - for copy
//wholeString == true: The whole text must be a valid coord - for var coords
List<BaseCoordinate> parseCoordinates(String text, {bool wholeString = false}) {
  var coords = <BaseCoordinate>[];

  try {
    BaseCoordinate? coord = parseStandardFormats(text, wholeString: wholeString);
    if (coord != null) coords.add(coord);
    
    coord = UTMREFCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = MGRSCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = ReverseWherigoWaldmeisterCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = ReverseWherigoDay1976Coordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = XYZCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = SwissGridCoordinate.parse(text);
    var swissGridPlus = SwissGridPlusCoordinate.parse(text);
    if (swissGridPlus != null &&
        (swissGridPlus.easting.toInt().toString().length == 7 ||
            swissGridPlus.northing.toInt().toString().length == 7)) {
      if (coord != null) coords.add(swissGridPlus);
      if (coord != null) coords.add(coord);
    } else {
      if (coord != null) coords.add(coord);
    }

    coord = GaussKruegerCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = LambertCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = DutchGridCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = MaidenheadCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = MercatorCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = NaturalAreaCodeCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = GeohashCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = GeoHexCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = Geo3x3Coordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = OpenLocationCodeCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = MakaneyCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = QuadtreeCoordinate.parse(text);
    if (coord != null) coords.add(coord);

    coord = SlippyMapCoordinate.parse(text);
    if (coord != null) coords.add(coord);
  } catch (e) {}

  return coords;
}

//wholeString == false: The first match at the text begin is taken - for copy
//wholeString == true: The whole text must be a valid coord - for var coords
BaseCoordinate? parseStandardFormats(String text, {bool wholeString = false}) {
  LatLng? coord = DMSCoordinate.parse(text, wholeString: wholeString)?.toLatLng();
  if (coord != null) return DMSCoordinate.fromLatLon(coord);

  coord = DMMCoordinate.parse(text, wholeString: wholeString)?.toLatLng();
  if (coord != null) return DMMCoordinate.fromLatLon(coord);

  coord = DECCoordinate.parse(text, wholeString: wholeString)?.toLatLng();
  if (coord != null) return DECCoordinate.fromLatLon(coord);

  return null;
}
