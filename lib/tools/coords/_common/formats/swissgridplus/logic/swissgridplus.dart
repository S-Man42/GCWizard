
import 'package:gc_wizard/tools/coords/_common/formats/swissgrid/logic/swissgrid.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:latlong2/latlong.dart';

class SwissGridPlus extends SwissGrid {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.SWISS_GRID_PLUS);

  SwissGridPlus(double easting, double northing) : super(easting, northing);

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    ells ??= defaultEllipsoid;
    return _swissGridPlusToLatLon(this, ells);
  }

  static SwissGridPlus fromLatLon(LatLng coord, Ellipsoid ells) {
    return _latLonToSwissGridPlus(coord, ells);
  }

  static SwissGridPlus? parse(String input) {
    return _parseSwissGridPlus(input);
  }
}

SwissGridPlus _latLonToSwissGridPlus(LatLng coord, Ellipsoid ells) {
  SwissGrid swissGrid = SwissGrid.fromLatLon(coord, ells);

  return SwissGridPlus(swissGrid.easting + 2000000, swissGrid.northing + 1000000);
}

LatLng _swissGridPlusToLatLon(SwissGridPlus coord, Ellipsoid ells) {
  var swissGripPlus = SwissGrid(coord.easting - 2000000, coord.northing - 1000000);

  return swissGridToLatLon(swissGripPlus, ells);
}

SwissGridPlus? _parseSwissGridPlus(String input) {
  var swissGrid = SwissGrid.parse(input);
  return swissGrid == null ? null : SwissGridPlus(swissGrid.easting, swissGrid.northing);
}