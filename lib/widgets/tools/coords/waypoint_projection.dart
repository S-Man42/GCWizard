import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_bearing.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class WaypointProjection extends StatefulWidget {
  @override
  WaypointProjectionState createState() => WaypointProjectionState();
}

class WaypointProjectionState extends State<WaypointProjection> {
  var _currentCoords = defaultCoordinate;
  var _currentDistance = 0.0;
  var _currentBearing = {'text': '','value': 0.0};
  var _currentReverse = false;

  var _currentValues = [defaultCoordinate];
  var _currentMapPoints = <GCWMapPoint>[];
  var _currentGeodetics = <GCWMapGeodetic>[];
  var _currentCoordsFormat = defaultCoordFormat();

  var _currentOutputFormat = defaultCoordFormat();
  List<String> _currentOutput = <String>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          text: i18n(context, 'coords_waypointprojection_start'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWDistance(
          onChanged: (value) {
            setState(() {
              _currentDistance = value;
            });
          },
        ),
        GCWBearing(
          onChanged: (value) {
            setState(() {
              _currentBearing = value;
            });
          },
        ),
        GCWOnOffSwitch(
          value: _currentReverse,
          title: i18n(context, 'coords_waypointprojection_reverse'),
          onChanged: (value) {
            setState(() {
              _currentReverse = value;
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
        GCWSubmitFlatButton(
          onPressed: () {
            setState(() {
              _calculateOutput();
            });
          },
        ),
        GCWCoordsOutput(
          outputs: _currentOutput,
          points: _currentMapPoints,
          geodetics: _currentGeodetics,
        ),
      ],
    );
  }

  _calculateOutput() {
    if (_currentReverse) {
      _currentValues = reverseProjection(_currentCoords, _currentBearing['value'], _currentDistance, defaultEllipsoid());
      if (_currentValues == null || _currentValues.length == 0) {
        _currentOutput = [i18n(context, 'coords_waypointprojection_reverse_nocoordinatefound')];
        return;
      }

      _currentMapPoints = [
        GCWMapPoint(
          point: _currentCoords,
          markerText: i18n(context, 'coords_waypointprojection_start'),
          coordinateFormat: _currentCoordsFormat
        )
      ];

      _currentGeodetics = <GCWMapGeodetic>[];

      _currentValues.forEach((projection) {
        _currentMapPoints.add(
          GCWMapPoint(
            point: projection,
            color: COLOR_MAP_CALCULATEDPOINT,
            markerText: i18n(context, 'coords_waypointprojection_end'),
            coordinateFormat: _currentOutputFormat
          )
        );

        _currentGeodetics.add(
          GCWMapGeodetic(
            start: projection,
            end: _currentCoords
          )
        );
      });
    } else {
      _currentValues = [projection(_currentCoords, _currentBearing['value'], _currentDistance, defaultEllipsoid())];

      _currentMapPoints = [
        GCWMapPoint(
          point: _currentCoords,
          markerText: i18n(context, 'coords_waypointprojection_start'),
          coordinateFormat: _currentCoordsFormat
        ),
        GCWMapPoint(
          point: _currentValues[0],
          color: COLOR_MAP_CALCULATEDPOINT,
          markerText: i18n(context, 'coords_waypointprojection_end'),
          coordinateFormat: _currentOutputFormat
        )
      ];

      _currentGeodetics = [GCWMapGeodetic(
        start: _currentCoords,
        end: _currentValues[0]
      )];
    }

    _currentOutput = _currentValues.map((projection) {
      return formatCoordOutput(projection, _currentOutputFormat, defaultEllipsoid());
    }).toList();
  }
}