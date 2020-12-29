import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:latlong/latlong.dart';

class GCWMapPoint {
  LatLng point;
  String markerText;
  Color color;
  final Map<String, String> coordinateFormat;
  final bool isDragable;
  final double radius;

  GCWMapCircle circle;

  GCWMapPoint({
    @required this.point,
    this.markerText,
    this.color: COLOR_MAP_POINT,
    this.coordinateFormat,
    this.isDragable: false,
    this.radius
  }) {
    if (radius != null && radius > 0.0)
      circle = GCWMapCircle(centerPoint: this.point, radius: this.radius);
  }

  refresh() {
    if (radius != null && radius > 0.0) {
      if (circle == null)
        circle = GCWMapCircle(centerPoint: this.point, radius: this.radius);
      else {
        circle.centerPoint = this.point;
        circle.radius = this.radius;
        circle._update();
      }
    } else {
      if (circle != null)
        circle = null;
    }
  }
}

class GCWMapGeodetic {
  GCWMapPoint start;
  GCWMapPoint end;
  Color color;

  List<LatLng> shape;

  GCWMapGeodetic({
    @required this.start,
    @required this.end,
    this.color: COLOR_MAP_POLYLINE,
  }) {
    update();
  }

  void update() {
    DistanceBearingData _distBear = distanceBearing(start.point, end.point, defaultEllipsoid());

    shape = [start.point];
    const _stepLength = 5000.0;

    var _countSteps = (_distBear.distance / _stepLength).floor();

    for (int _i = 1; _i < _countSteps; _i++) {
      var _nextPoint = projection(
          start.point,
        _distBear.bearingAToB,
        _stepLength * _i,
        defaultEllipsoid()
      );
      shape.add(_nextPoint);
    }

    shape.add(end.point);
  }

  @deprecated
  static fromLatLng({LatLng start, end, Color color}) {
    return GCWMapGeodetic(
      start: GCWMapPoint(point: start),
      end: GCWMapPoint(point: end),
      color: color
    );
  }
}

class GCWMapCircle {
  LatLng centerPoint;
  double radius;
  Color color;

  List<LatLng> shape;

  GCWMapCircle({
    @required this.centerPoint,
    @required this.radius,
    this.color: COLOR_MAP_CIRCLE
  }) {
    _update();
  }

  void _update() {
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