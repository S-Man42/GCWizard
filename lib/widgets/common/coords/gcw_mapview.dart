import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_map_geometries.dart';
import 'package:latlong/latlong.dart';

class GCWMapView extends StatefulWidget {
  final List<MapPoint> points;
  final List<MapGeodetic> geodetics;
  final List<MapCircle> circles;

  const GCWMapView({Key key, this.points, this.geodetics, this.circles})
      : super(key: key);

  @override
  GCWMapViewState createState() => GCWMapViewState();
}

class GCWMapViewState extends State<GCWMapView> {
  //////////////////////////////////////////////////////////////////////////////
  // from: https://stackoverflow.com/a/58958668/3984221
  LatLng computeCentroid(Iterable<LatLng> points) {
    double latitude = 0;
    double longitude = 0;
    int n = points.length;

    for (LatLng point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / n, longitude / n);
  }

  //////////////////////////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////////////////////
  // from: https://stackoverflow.com/a/13274361/3984221

  double _latRad(_lat) {
    var _sin = sin(_lat * PI / 180);
    var _radX2 = log((1 + _sin) / (1 - _sin)) / 2;
    return max(min(_radX2, PI), -PI) / 2;
  }

  int _zoom(_mapPx, _worldPx, _fraction) {
    return (log(_mapPx / _worldPx / _fraction) / ln2).floor();
  }

  int _getBoundsZoomLevel() {
    var _mapDim = MediaQuery.of(context).size;
    var _worldDim = {'height': 256, 'width': 256};
    var _zoomMax = 18;

    var _bounds = LatLngBounds();
    widget.points.forEach((point) => _bounds.extend(point.point));

    var _ne = _bounds.northEast;
    var _sw = _bounds.southWest;

    var _latFraction = (_latRad(_ne.latitude) - _latRad(_sw.latitude)) / PI;

    var _lngDiff = _ne.longitude - _sw.longitude;
    var _lngFraction = ((_lngDiff < 0) ? (_lngDiff + 360) : _lngDiff) / 360;

    var _latZoom = _zoomMax;
    if (_latFraction > 0.0)
      _latZoom = _zoom(_mapDim.height, _worldDim['height'], _latFraction);

    var _lngZoom = _zoomMax;
    if (_lngFraction > 0.0)
      _lngZoom = _zoom(_mapDim.width, _worldDim['width'], _lngFraction);

    return min(min(_latZoom, _lngZoom), _zoomMax);
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> _markers = widget.points.map((_point) {
      return Marker(
          width: 25.0,
          height: 25.0,
          point: _point.point,
          anchorPos: AnchorPos.align(AnchorAlign.center),
          builder: (context) {
            return Container(
              child: Column (
                children: <Widget> [
                  Icon(
                    Icons.my_location,
                    size: 25.0,
                    color: _point.color,
                  ),
                  //Text(_point.markerText)
                ]
              ),

            );
          });
    }).toList();

    List<Polyline> _polylines = _addPolylines();
    List<Polyline> _circlePolylines = _addCircles();
    _polylines.addAll(_circlePolylines);

    return FlutterMap(
      options: MapOptions(
          center: computeCentroid(widget.points.map((_point) => _point.point).toList()),
          zoom: _getBoundsZoomLevel().toDouble(),
          minZoom: 1.0,
          maxZoom: 18.0),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
            markers: _markers
        ),
        PolylineLayerOptions(
            polylines: _polylines
        ),
      ],
    );
  }

  List<Polyline> _addPolylines() {
    List<Polyline> _polylines = widget.geodetics.map((_geodetic) {
      return Polyline(
        points: _geodetic.shape,
        strokeWidth: 3.0,
        color: _geodetic.color,
      );
    }).toList();
    return _polylines;
  }

  List<Polyline> _addCircles() {

    List<Polyline> _polylines =  widget.circles.map((_circle) {
      return Polyline(
        points: _circle.shape,
        strokeWidth: 3.0,
        color: _circle.color,
      );
    }).toList();

    return _polylines;
  }
}
