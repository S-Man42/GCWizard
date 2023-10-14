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
    
    coord = UTMREF.parse(text);
    if (coord != null) coords.add(coord);

    coord = MGRS.parse(text);
    if (coord != null) coords.add(coord);

    coord = ReverseWherigoWaldmeister.parse(text);
    if (coord != null) coords.add(coord);

    coord = ReverseWherigoDay1976.parse(text);
    if (coord != null) coords.add(coord);

    coord = XYZ.parse(text);
    if (coord != null) coords.add(coord);

    coord = SwissGrid.parse(text);
    var swissGripPlus = SwissGridPlus.parse(text);
    if (swissGripPlus != null &&
        (swissGripPlus.easting.toInt().toString().length == 7 ||
            swissGripPlus.northing.toInt().toString().length == 7)) {
      if (coord != null) coords.add(swissGripPlus);
      if (coord != null) coords.add(coord);
    } else {
      if (coord != null) coords.add(coord);
    }

    coord = GaussKrueger.parse(text);
    if (coord != null) coords.add(coord);

    coord = Lambert.parse(text);
    if (coord != null) coords.add(coord);

    coord = DutchGrid.parse(text);
    if (coord != null) coords.add(coord);

    coord = Maidenhead.parse(text);
    if (coord != null) coords.add(coord);

    coord = Mercator.parse(text);
    if (coord != null) coords.add(coord);

    coord = NaturalAreaCode.parse(text);
    if (coord != null) coords.add(coord);

    coord = Geohash.parse(text);
    if (coord != null) coords.add(coord);

    coord = GeoHex.parse(text);
    if (coord != null) coords.add(coord);

    coord = Geo3x3.parse(text);
    if (coord != null) coords.add(coord);

    coord = OpenLocationCode.parse(text);
    if (coord != null) coords.add(coord);

    coord = Makaney.parse(text);
    if (coord != null) coords.add(coord);

    coord = Quadtree.parse(text);
    if (coord != null) coords.add(coord);

    coord = SlippyMap.parse(text);
    if (coord != null) coords.add(coord);
  } catch (e) {}

  return coords;
}

//wholeString == false: The first match at the text begin is taken - for copy
//wholeString == true: The whole text must be a valid coord - for var coords
BaseCoordinate? parseStandardFormats(String text, {bool wholeString = false}) {
  LatLng? coord = DMS.parse(text, wholeString: wholeString)?.toLatLng();
  if (coord != null) return DMS.fromLatLon(coord);

  coord = DMM.parse(text, wholeString: wholeString)?.toLatLng();
  if (coord != null) return DMM.fromLatLon(coord);

  coord = DEC.parse(text, wholeString: wholeString)?.toLatLng();
  if (coord != null) return DEC.fromLatLon(coord);

  return null;
}
