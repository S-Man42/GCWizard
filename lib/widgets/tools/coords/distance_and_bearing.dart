import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/distance_bearing.dart';
import 'package:gc_wizard/logic/tools/coords/distance_and_bearing.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
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

  Length _currentOutputUnit = UNITCATEGORY_LENGTH.defaultUnit;

  DistanceBearingData _currentValue = DistanceBearingData();
  List<GCWOutputText> _currentOutput = [];

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
        GCWTextDivider(
          text: i18n(context, 'coords_distancebearing_outputunit'),
        ),
        GCWUnitDropDownButton(
          unitList: allLengths(),
          value: _currentOutputUnit,
          onlyShowSymbols: false,
          onChanged: (Length value) {
            setState(() {
              _currentOutputUnit = value;
            });
          }
        ),
        GCWSubmitFlatButton(
          onPressed: () {
            setState(() {
              _calculateOutput(context);
            });
          },
        ),
        GCWCoordsOutput(
          outputs: _currentOutput,
          points: [
            GCWMapPoint(
              point: _currentCoords1,
              markerText: i18n(context, 'coords_distancebearing_coorda'),
              coordinateFormat: _currentCoordsFormat1
            ),
            GCWMapPoint(
              point: _currentCoords2,
              markerText: i18n(context, 'coords_distancebearing_coordb'),
              coordinateFormat: _currentCoordsFormat2
            ),
          ],
          geodetics: [
            GCWMapGeodetic(
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

    _currentOutput = [];
    _currentOutput.add(GCWOutputText(
      text: '${i18n(context, 'coords_distancebearing_distance')}: ${doubleFormat.format(_currentOutputUnit.fromMeter(_currentValue.distance))} ${_currentOutputUnit.symbol}',
      copyText: doubleFormat.format(_currentOutputUnit.fromMeter(_currentValue.distance)),
    ));
    _currentOutput.add(GCWOutputText(
      text: '${i18n(context, 'coords_distancebearing_bearingatob')}: ${doubleFormat.format(_currentValue.bearingAToB)}°',
      copyText: doubleFormat.format(_currentValue.bearingAToB),
    ));
    _currentOutput.add(GCWOutputText(
      text: '${i18n(context, 'coords_distancebearing_bearingbtoa')}: ${doubleFormat.format(_currentValue.bearingBToA)}°',
      copyText: doubleFormat.format(_currentValue.bearingBToA),
    ));
  }
}