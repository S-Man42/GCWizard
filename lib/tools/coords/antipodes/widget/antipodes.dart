import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/coord/gcw_coords/gcw_coords.dart';
import 'package:gc_wizard/common_widgets/coord/gcw_coords_output/gcw_coords_output.dart';
import 'package:gc_wizard/common_widgets/coord/gcw_coords_output/gcw_coords_outputformat.dart';
import 'package:gc_wizard/common_widgets/gcw_submit_button/gcw_submit_button.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/tools/coords/antipodes/logic/antipodes.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';
import 'package:gc_wizard/tools/coords/utils/default_getter.dart';
import 'package:gc_wizard/tools/coords/utils/format_getter.dart';

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
