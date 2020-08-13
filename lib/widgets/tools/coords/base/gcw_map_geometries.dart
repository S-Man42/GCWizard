import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:latlong/latlong.dart';

class MapPoint {
  final LatLng point;
  final String markerText;
  final Color color;
  final Map<String, String> coordinateFormat;

  const MapPoint({
    @required this.point,
    this.markerText,
    this.color: ThemeColors.mapPoint,
    this.coordinateFormat
  });
}

class MapGeodetic {
  LatLng start;
  LatLng end;
  final Color color;

  List<LatLng> shape;

  MapGeodetic({
    @required this.start,
    @required this.end,
    this.color: ThemeColors.mapPolyline,
  }) {
    _initialize();
  }

  void _initialize() {
    if (this.start == null)
      this.start = defaultCoordinate;
    if (this.end == null)
      this.end = defaultCoordinate;

    DistanceBearingData _distBear = distanceBearing(this.start, this.end, defaultEllipsoid());

    shape = [this.start];
    const _stepLength = 5000.0;

    var _countSteps = (_distBear.distance / _stepLength).floor();

    for (int _i = 1; _i < _countSteps; _i++) {
      var _nextPoint = projection(
          this.start,
          _distBear.bearingAToB,
          _stepLength * _i,
          defaultEllipsoid()
      );
      shape.add(_nextPoint);
    }

    shape.add(this.end);
  }
}

class MapCircle {
  LatLng centerPoint;
  final double radius;
  final Color color;

  List<LatLng> shape;

  MapCircle({
    @required this.centerPoint,
    @required this.radius,
    this.color: ThemeColors.mapCircle
  }) {
    _initialize();
  }

  void _initialize() {
    if (this.centerPoint == null)
      this.centerPoint = defaultCoordinate;

    var _degrees = 0.5;

    double _prevLongitude;
    bool shouldSort = false;

    shape = List.generate(((360.0 + _degrees) /_degrees).floor(), (index) => index * _degrees).map((e) {
      LatLng coord = projection(this.centerPoint, e, this.radius, defaultEllipsoid());

      // if there is a huge longitude step around the world (nearly 360°)
      // then one coordinate is place to the left side of the map, the next one to the right (or vice versa)
      // this yields in a nasty line right over the whole map. In that case, there is no circle
      // To avoid this the coordinate should be sorted. This works only in that case.
      // In normal cases, this would ruin your circle
      if (_prevLongitude != null) {
        if ((_prevLongitude - coord.longitude).abs() > 350)
          shouldSort = true;
      }
      _prevLongitude = coord.longitude;

      return coord;
    }).toList();

    if (shouldSort) {
      shape.sort((a, b) {
        return a.longitude.compareTo(b.longitude);
      });
    }
  }
}