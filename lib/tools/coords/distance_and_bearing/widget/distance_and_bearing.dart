import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/common/units/logic/length.dart';
import 'package:gc_wizard/tools/common/units/logic/unit.dart';
import 'package:gc_wizard/tools/common/units/logic/unit_category.dart';
import 'package:gc_wizard/tools/coords/data/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/data/logic/distance_bearing.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/logic/distance_and_bearing.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/tools/common/base/gcw_output_text/widget/gcw_output_text.dart';
import 'package:gc_wizard/tools/common/gcw_submit_button/widget/gcw_submit_button.dart';
import 'package:gc_wizard/tools/common/gcw_text_divider/widget/gcw_text_divider.dart';
import 'package:gc_wizard/tools/common/units/gcw_unit_dropdownbutton/widget/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/tools/coords/base/gcw_coords/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/coords/base/gcw_coords_output/widget/gcw_coords_output.dart';
import 'package:gc_wizard/tools/coords/base/utils/widget/utils.dart';
import 'package:gc_wizard/tools/coords/map_view/gcw_map_geometries/widget/gcw_map_geometries.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';

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

  var _currentMapPoints = <GCWMapPoint>[];
  var _currentMapPolylines = <GCWMapPolyline>[];

  @override
  void initState() {
    super.initState();

    _currentOutputUnit = getUnitBySymbol(allLengths(), Prefs.get(PREFERENCE_DEFAULT_LENGTH_UNIT));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'coords_distancebearing_coorda'),
          coordsFormat: _currentCoordsFormat1,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat1 = ret['coordsFormat'];
              _currentCoords1 = ret['value'];
            });
          },
        ),
        GCWCoords(
          title: i18n(context, 'coords_distancebearing_coordb'),
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
            }),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _calculateOutput(context);
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

  _calculateOutput(BuildContext context) {
    final doubleFormatCopy = NumberFormat('0.0#######');

    _currentValue = distanceBearing(_currentCoords1, _currentCoords2, defaultEllipsoid());

    _currentOutput = [];
    _currentOutput.add(GCWOutputText(
      text:
          '${i18n(context, 'coords_distancebearing_distance')}: ${doubleFormat.format(_currentOutputUnit.fromMeter(_currentValue.distance))} ${_currentOutputUnit.symbol}',
      copyText: doubleFormatCopy.format(_currentOutputUnit.fromMeter(_currentValue.distance)),
    ));
    _currentOutput.add(GCWOutputText(
      text:
          '${i18n(context, 'coords_distancebearing_bearingatob')}: ${doubleFormat.format(_currentValue.bearingAToB)}°',
      copyText: doubleFormatCopy.format(_currentValue.bearingAToB),
    ));
    _currentOutput.add(GCWOutputText(
      text:
          '${i18n(context, 'coords_distancebearing_bearingbtoa')}: ${doubleFormat.format(_currentValue.bearingBToA)}°',
      copyText: doubleFormatCopy.format(_currentValue.bearingBToA),
    ));

    var mapPoint1 = GCWMapPoint(
        point: _currentCoords1,
        markerText: i18n(context, 'coords_distancebearing_coorda'),
        coordinateFormat: _currentCoordsFormat1);
    var mapPoint2 = GCWMapPoint(
        point: _currentCoords2,
        markerText: i18n(context, 'coords_distancebearing_coordb'),
        coordinateFormat: _currentCoordsFormat2);

    _currentMapPoints = [mapPoint1, mapPoint2];

    _currentMapPolylines = [
      GCWMapPolyline(points: [mapPoint1, mapPoint2])
    ];
  }
}
