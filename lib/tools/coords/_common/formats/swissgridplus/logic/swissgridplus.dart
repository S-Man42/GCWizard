import 'package:gc_wizard/tools/coords/_common/formats/swissgrid/logic/swissgrid.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinate_format_constants.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/ellipsoid.dart';
import 'package:latlong2/latlong.dart';

const swissgridplusKey = 'coords_swissgridplus';

class SwissGridPlusFormatDefinition extends AbstractCoordinateFormatDefinition {
  @override
  CoordinateFormatKey type = CoordinateFormatKey.SWISS_GRID_PLUS;

  @override
  BaseCoordinate defaultCoordinate = SwissGridPlusCoordinate.defaultCoordinate;

  @override
  String key = swissgridplusKey;
}

class SwissGridPlusCoordinate extends SwissGridCoordinate {
  @override
  CoordinateFormat get format => CoordinateFormat(CoordinateFormatKey.SWISS_GRID_PLUS);

  SwissGridPlusCoordinate(super.easting, super.northing);

  @override
  LatLng toLatLng({Ellipsoid? ells}) {
    ells ??= defaultEllipsoid;
    return _swissGridPlusToLatLon(this, ells);
  }

  static SwissGridPlusCoordinate fromLatLon(LatLng coord, Ellipsoid ells) {
    return _latLonToSwissGridPlus(coord, ells);
  }

  static SwissGridPlusCoordinate? parse(String input) {
    return _parseSwissGridPlus(input);
  }

  static SwissGridPlusCoordinate get defaultCoordinate => SwissGridPlusCoordinate(0, 0);
}

SwissGridPlusCoordinate _latLonToSwissGridPlus(LatLng coord, Ellipsoid ells) {
  SwissGridCoordinate swissGrid = SwissGridCoordinate.fromLatLon(coord, ells);

  return SwissGridPlusCoordinate(swissGrid.easting + 2000000, swissGrid.northing + 1000000);
}

LatLng _swissGridPlusToLatLon(SwissGridPlusCoordinate coord, Ellipsoid ells) {
  var swissGripPlus = SwissGridCoordinate(coord.easting - 2000000, coord.northing - 1000000);

  return swissGridToLatLon(swissGripPlus, ells);
}

SwissGridPlusCoordinate? _parseSwissGridPlus(String input) {
  var swissGrid = SwissGridCoordinate.parse(input);
  return swissGrid == null ? null : SwissGridPlusCoordinate(swissGrid.easting, swissGrid.northing);
}