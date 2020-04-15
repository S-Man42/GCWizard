import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/units/lengths.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

class DistanceBearing extends StatefulWidget {
  @override
  DistanceBearingState createState() => DistanceBearingState();
}

class DistanceBearingState extends State<DistanceBearing> {
  var _currentCoords1 = defaultCoordinate;
  var _currentCoords2 = defaultCoordinate;

  var _currentCoordsFormat1 = defaultCoordFormat();
  var _currentCoordsFormat2 = defaultCoordFormat();

  DistanceBearingData _currentValue = DistanceBearingData();
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
          text: i18n(context, 'coords_distancebearing_coorda'),
          coordsFormat: _currentCoordsFormat1,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat1 = ret['coordsFormat'];
              _currentCoords1 = ret['value'];
            });
          },
        ),
        GCWCoords(
          text: i18n(context, 'coords_distancebearing_coordb'),
          coordsFormat: _currentCoordsFormat2,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat2 = ret['coordsFormat'];
              _currentCoords2 = ret['value'];
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
              markerText: 'A'
            ),
            MapPoint(
                point: _currentCoords2,
                markerText: 'B'
            ),
          ],
          geodetics: [
            MapGeodetic(
              start: _currentCoords1,
              end: _currentCoords2
            )
          ],
        ),
      ],
    );
  }

  _calculateOutput(BuildContext context) {
    _currentValue = distanceBearing(_currentCoords1, _currentCoords2, defaultEllipsoid());

    var _forAllLenghtUnits = allLengths.map((length) {
      return '\t\t${doubleFormat.format(_currentValue.distance / length.inMeters)} ${length.unit}';
    }).join('\n');

    _currentOutput = '${i18n(context, 'coords_distancebearing_distance')}:\n$_forAllLenghtUnits\n\n'
        '${i18n(context, 'coords_distancebearing_bearingatob')}: ${doubleFormat.format(_currentValue.bearingAToB)}°\n'
        '${i18n(context, 'coords_distancebearing_bearingbtoa')}: ${doubleFormat.format(_currentValue.bearingBToA)}°';
  }
}