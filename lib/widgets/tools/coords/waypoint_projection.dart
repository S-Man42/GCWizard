import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
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

  var _currentValue = defaultCoordinate;
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
          points: [
            MapPoint(
              point: _currentCoords,
              markerText: i18n(context, 'coords_waypointprojection_start'),
              coordinateFormat: _currentCoordsFormat
            ),
            MapPoint(
              point: _currentValue,
              color: ThemeColors.mapCalculatedPoint,
              markerText: i18n(context, 'coords_waypointprojection_end'),
              coordinateFormat: _currentOutputFormat
            )
          ],
          geodetics: [
            MapGeodetic(
              start: _currentCoords,
              end: _currentValue
            )
          ],
        ),
      ],
    );
  }

  _calculateOutput() {
    _currentValue = projection(_currentCoords, _currentBearing['value'], _currentDistance, defaultEllipsoid());
    _currentOutput = [formatCoordOutput(_currentValue, _currentOutputFormat, defaultEllipsoid())];
  }
}