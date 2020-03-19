import 'dart:math';

import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/intervals/constants.dart';
import 'package:gc_wizard/logic/tools/coords/intervals/coordinate_cell.dart';
import 'package:latlong/latlong.dart';

abstract class IntervalCalculator {

  List<LatLng> results = [];
  List<CoordinateCell> cells = [];
  Map<String, dynamic> parameters;
  Ellipsoid ells;

  IntervalCalculator(this.parameters, this.ells);

  bool checkCell(CoordinateCell cell, Map<String, dynamic> parameters);

  bool _resultExists(LatLng point) {
    for (LatLng result in results) {
      double lat = result.latitudeInRad;
      double lon = result.longitudeInRad;

      if (((lat - point.latitudeInRad).abs() <= delta) && (min((lon - point.longitudeInRad).abs(), 360 - (lon - point.longitudeInRad).abs()) <= delta))
        return true;
    }

    return false;
  }

  _divideCell(CoordinateCell cell) {
    var lat = cell.latInterval;
    var lon = cell.lonInterval;

    //Check if interval too small
    if ((lat.b - lat.a < eps) && (lon.b - lon.a < eps)) {
      var cellCenter = cell.cellCenter;

      if (!_resultExists(cellCenter)) {
        results.add(cellCenter);
      }
    } else {
      if (checkCell(cell, parameters) && (cells.length < MAX_CELLCOUNT)) {
        if (cell.maxHeight > cell.maxWidth) {
          double mLat = (lat.a + lat.b) / 2;
          cells.add(CoordinateCell(latInterval: Interval(a: mLat, b: lat.b), lonInterval: lon, ellipsoid: ells));
          cells.add(CoordinateCell(latInterval: Interval(a: lat.a, b: mLat), lonInterval: lon, ellipsoid: ells));
        } else {
          double mLon = (lon.a + lon.b) / 2;
          cells.add(CoordinateCell(latInterval: lat, lonInterval: Interval(a: mLon, b: lon.b), ellipsoid: ells));
          cells.add(CoordinateCell(latInterval: lat, lonInterval: Interval(a: lon.a, b: mLon), ellipsoid: ells));
        }
      }
    }
  }

  List<LatLng> check() {
    //Splitting the initial whole-world-interval into four pieces for
    //avoiding creepy effects on bearing calculations
    cells = [
      CoordinateCell(
        latInterval: Interval(a: -PI / 2.0, b: 0.0),
        lonInterval: Interval(a: -PI, b: 0.0),
        ellipsoid: ells
      ),
      CoordinateCell(
        latInterval: Interval(a: 0.0, b: PI / 2.0),
        lonInterval: Interval(a: 0.0, b: PI),
        ellipsoid: ells
      ),
      CoordinateCell(
        latInterval: Interval(a: -PI / 2.0, b: 0.0),
        lonInterval: Interval(a: 0.0, b: PI),
        ellipsoid: ells
      ),
      CoordinateCell(
        latInterval: Interval(a: 0.0, b: PI / 2.0),
        lonInterval: Interval(a: -PI, b: 0.0),
        ellipsoid: ells
      ),
    ];

    while (!cells.isEmpty) {
      _divideCell(cells.first);
      cells.removeAt(0);
    }

    return results;
  }
}