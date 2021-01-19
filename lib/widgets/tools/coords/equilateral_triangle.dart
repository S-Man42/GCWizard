import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/equilateral_triangle.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class EquilateralTriangle extends StatefulWidget {
  @override
  EquilateralTriangleState createState() => EquilateralTriangleState();
}

class EquilateralTriangleState extends State<EquilateralTriangle> {
  var _currentIntersections = [];

  var _currentCoordsFormat1 = defaultCoordFormat();
  var _currentCoords1 = defaultCoordinate;

  var _currentCoordsFormat2 = defaultCoordFormat();
  var _currentCoords2 = defaultCoordinate;

  var _currentOutputFormat = defaultCoordFormat();
  List<String> _currentOutput = [];
  var _currentMapPoints;
  List<GCWMapPolyline> _currentMapPolylines;

  @override
  void initState() {
    super.initState();
    _currentMapPoints = [
      GCWMapPoint(point: _currentCoords1),
      GCWMapPoint(point: _currentCoords2)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, "coords_equilateraltriangle_coorda"),
          coordsFormat: _currentCoordsFormat1,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat1 = ret['coordsFormat'];
              _currentCoords1 = ret['value'];
            });
          },
        ),
        GCWCoords(
          title: i18n(context, "coords_equilateraltriangle_coordb"),
          coordsFormat: _currentCoordsFormat2,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat2 = ret['coordsFormat'];
              _currentCoords2 = ret['value'];
            });
          },
        ),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value;
            });
          },
        ),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _calculateOutput();
            });
          },
        ),
        GCWCoordsOutput(
          outputs: _currentOutput,
          points: _currentMapPoints,
          polylines: _currentMapPolylines,
        ),
      ],
    );
  }

  _calculateOutput() {
    _currentIntersections = equilateralTriangle(_currentCoords1, _currentCoords2, defaultEllipsoid());

    _currentMapPoints = [
      GCWMapPoint(
        point: _currentCoords1,
        markerText: i18n(context, 'coords_equilateraltriangle_coorda'),
        coordinateFormat: _currentCoordsFormat1
      ),
      GCWMapPoint(
        point: _currentCoords2,
        markerText: i18n(context, 'coords_equilateraltriangle_coordb'),
        coordinateFormat: _currentCoordsFormat2
      )
    ];

    if (_currentIntersections.isEmpty) {
      _currentOutput = [i18n(context, "coords_intersect_nointersection")];
      return;
    }

    var intersectionMapPoints = _currentIntersections
      .map((intersection) => GCWMapPoint(
        point: intersection,
        color: COLOR_MAP_CALCULATEDPOINT,
        markerText: i18n(context, 'coords_common_intersection'),
        coordinateFormat: _currentOutputFormat
      )).toList();

    _currentMapPoints.addAll(intersectionMapPoints);

    _currentMapPolylines = [
      GCWMapPolyline(
        points: [_currentMapPoints[0], _currentMapPoints[1]]
      ),
    ];

    intersectionMapPoints.forEach((intersection) {
      _currentMapPolylines.addAll([
        GCWMapPolyline(
          points: [_currentMapPoints[0], intersection],
          color: HSLColor
            .fromColor(COLOR_MAP_POLYLINE)
            .withLightness(HSLColor.fromColor(COLOR_MAP_POLYLINE).lightness + 0.2)
            .toColor()
        ),
        GCWMapPolyline(
          points: [_currentMapPoints[1], intersection],
          color: HSLColor
            .fromColor(COLOR_MAP_POLYLINE)
            .withLightness(HSLColor.fromColor(COLOR_MAP_POLYLINE).lightness -0.3)
            .toColor()
        )
      ]);
    });

    _currentOutput = _currentIntersections
      .map((intersection) => formatCoordOutput(intersection, _currentOutputFormat, defaultEllipsoid()))
      .toList();
  }
}