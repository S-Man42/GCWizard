import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/coords/antipodes/logic/antipodes.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/utils/format_getter.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_submit_button/widget/gcw_submit_button.dart';
import 'package:gc_wizard/tools/coords/base/gcw_coords/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/coords/base/gcw_coords_output/widget/gcw_coords_output.dart';
import 'package:gc_wizard/tools/coords/base/gcw_coords_outputformat/widget/gcw_coords_outputformat.dart';
import 'package:gc_wizard/tools/coords/base/utils/widget/format_getter.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';

class Antipodes extends StatefulWidget {
  @override
  AntipodesState createState() => AntipodesState();
}

class AntipodesState extends State<Antipodes> {
  var _currentCoords = defaultCoordinate;

  var _currentValues = [defaultCoordinate];
  var _currentMapPoints = <GCWMapPoint>[];
  var _currentCoordsFormat = defaultCoordFormat();

  var _currentOutputFormat = defaultCoordFormat();
  List<String> _currentOutput = <String>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'coords_antipodes_coorda'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
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
        ),
      ],
    );
  }

  _calculateOutput() {
    _currentValues = [antipodes(_currentCoords)];

    _currentMapPoints = [
      GCWMapPoint(
          point: _currentCoords,
          markerText: i18n(context, 'coords_antipodes_coorda'),
          coordinateFormat: _currentCoordsFormat),
      GCWMapPoint(
          point: _currentValues[0],
          color: COLOR_MAP_CALCULATEDPOINT,
          markerText: i18n(context, 'coords_antipodes_coordb'),
          coordinateFormat: _currentOutputFormat),
    ];

    _currentOutput = _currentValues.map((coord) {
      return formatCoordOutput(coord, _currentOutputFormat, defaultEllipsoid());
    }).toList();
  }
}
