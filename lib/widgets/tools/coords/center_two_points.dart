import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/centerpoint.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/units/lengths.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_coords_outputformat_distance.dart';
import 'package:gc_wizard/widgets/common/coords/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/common/coords/utils.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:latlong/latlong.dart';

class CenterTwoPoints extends StatefulWidget {
  @override
  CenterTwoPointsState createState() => CenterTwoPointsState();
}

class CenterTwoPointsState extends State<CenterTwoPoints> {
  LatLng _currentCenter = defaultCoordinate;
  double _currentDistance = 0.0;

  var _currentCoords1 = defaultCoordinate;
  var _currentCoords2 = defaultCoordinate;

  var _currentCoordsFormat1 = defaultCoordFormat();
  var _currentCoordsFormat2 = defaultCoordFormat();

  var _currentOutputFormat = defaultCoordFormat();
  var _currentOutputUnit = defaultLength;
  var _currentOutput = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          text: i18n(context, 'coords_centertwopoint_coorda'),
          coordsFormat: _currentCoordsFormat1,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat1 = ret['coordsFormat'];
              _currentCoords1 = ret['value'];
            });
          },
        ),
        GCWCoords(
          text: i18n(context, 'coords_centertwopoint_coordb'),
          coordsFormat: _currentCoordsFormat2,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat2 = ret['coordsFormat'];
              _currentCoords2 = ret['value'];
            });
          },
        ),
        GCWCoordsOutputFormatDistance(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value['coordFormat'];
              _currentOutputUnit = value['unit'];
            });
          },
        ),
        GCWSubmitFlatButton(
          onPressed: () {
            setState(() {
              _calculateOutput(context);
            });
          },
        ),
        GCWCoordsOutput(
          text: _currentOutput,
          points: [
            MapPoint(
              point: _currentCoords1,
            ),
            MapPoint(
              point: _currentCoords2,
            ),
            MapPoint(
              point: _currentCenter,
              color: ThemeColors.mapCalculatedPoint
            ),
          ],
          geodetics: [
            MapGeodetic(
              start: _currentCoords1,
              end: _currentCoords2
            ),
          ],
          circles: [
            MapCircle(
              centerPoint: _currentCenter,
              radius: _currentDistance
            ),
          ],
        ),
      ],
    );
  }

  _calculateOutput(BuildContext context) {
    var _result = centerPointTwoPoints(_currentCoords1, _currentCoords2, defaultEllipsoid());
    _currentCenter = _result['centerPoint'];
    _currentDistance = _result['distance'];
    _currentOutput =
        '${formatCoordOutput(_currentCenter, _currentOutputFormat, defaultEllipsoid())}\n'
        '${i18n(context, 'coords_center_distance')}: ${doubleFormat.format(_currentDistance / _currentOutputUnit.inMeters)} ${_currentOutputUnit.unit}';
  }
}