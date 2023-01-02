import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/coords/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/dmm_offset/logic/dmm_offset.dart';
import 'package:gc_wizard/tools/coords/utils/format_getter.dart';
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/common_widgets/gcw_integer_spinner/widget/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/gcw_text_divider/widget/gcw_text_divider.dart';
import 'package:gc_wizard/tools/coords/base/gcw_coords/widget/gcw_coords.dart';
import 'package:gc_wizard/tools/coords/base/gcw_coords_output/widget/gcw_coords_output.dart';
import 'package:gc_wizard/tools/coords/base/gcw_coords_outputformat/widget/gcw_coords_outputformat.dart';
import 'package:gc_wizard/tools/coords/base/utils/widget/format_getter.dart';
import 'package:gc_wizard/tools/coords/map_view/logic/map_geometries.dart';

class DMMOffset extends StatefulWidget {
  @override
  DMMOffsetState createState() => DMMOffsetState();
}

class DMMOffsetState extends State<DMMOffset> {
  var _currentCoords = defaultCoordinate;

  var _currentValues = [defaultCoordinate];
  var _currentMapPoints = <GCWMapPoint>[];
  var _currentCoordsFormat = defaultCoordFormat();

  var _currentOutputFormat = defaultCoordFormat();
  List<String> _currentOutput = <String>[];

  var _currentAddLatitude = 0;
  var _currentAddLongitude = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'coords_dmmoffset_start'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];

              _calculateOutput();
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'coords_dmmoffset_offset'),
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'coords_common_latitude'),
          value: _currentAddLatitude,
          onChanged: (value) {
            setState(() {
              _currentAddLatitude = value;
              _calculateOutput();
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'coords_common_longitude'),
          value: _currentAddLongitude,
          onChanged: (value) {
            setState(() {
              _currentAddLongitude = value;
              _calculateOutput();
            });
          },
        ),
        GCWCoordsOutputFormat(
          coordFormat: _currentOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentOutputFormat = value;
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
    _currentValues = [
      addIntegersToDMM(_currentCoords, {'latitude': _currentAddLatitude, 'longitude': _currentAddLongitude})
    ];

    _currentMapPoints = [
      GCWMapPoint(
          point: _currentCoords,
          markerText: i18n(context, 'coords_dmmaddintegers_start'),
          coordinateFormat: _currentCoordsFormat),
      GCWMapPoint(
          point: _currentValues[0],
          color: COLOR_MAP_CALCULATEDPOINT,
          markerText: i18n(context, 'coords_dmmaddintegers_end'),
          coordinateFormat: _currentCoordsFormat),
    ];

    _currentOutput = _currentValues.map((projection) {
      return formatCoordOutput(projection, _currentOutputFormat, defaultEllipsoid());
    }).toList();
  }
}
