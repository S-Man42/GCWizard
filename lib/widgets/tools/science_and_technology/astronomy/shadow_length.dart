import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/sun_position.dart' as logic;
import 'package:gc_wizard/theme/fixed_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/shadow_length.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
import 'package:gc_wizard/logic/tools/coords/projection.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_output.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat_distance.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/map_view/gcw_map_geometries.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:intl/intl.dart';
import 'package:prefs/prefs.dart';

class ShadowLength extends StatefulWidget {
  @override
  ShadowLengthState createState() => ShadowLengthState();
}

class ShadowLengthState extends State<ShadowLength> {
  var _currentDateTime = {'datetime': DateTime.now(), 'timezone': DateTime.now().timeZoneOffset};
  var _currentCoords = defaultCoordinate;
  var _currentCoordsFormat = defaultCoordFormat();
  var _currentHeight = 0.0;

  var _currentOutputFormat = defaultCoordFormat();
  var _currentLength = 0.0;
  var _currentValues = [defaultCoordinate];
  var _currentBearing = 0.0;


  Length _currentInputLength = getUnitBySymbol(allLengths(), Prefs.get(PREFERENCE_DEFAULT_LENGTH_UNIT));
  Length _currentOutputLength = getUnitBySymbol(allLengths(), Prefs.get(PREFERENCE_DEFAULT_LENGTH_UNIT));
  var _currentCoordsOutputFormat = defaultCoordFormat();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          title: i18n(context, 'common_location'),
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'astronomy_postion_datetime'),
        ),
        GCWDateTimePicker(
          type: DateTimePickerType.DATETIME,
          withTimezones: true,
          onChanged: (datetime) {
            setState(() {
              _currentDateTime = datetime;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'shadowlength_height'),
        ),
        GCWDistance(
          value: _currentHeight,
          unit: _currentInputLength,
          onChanged: (value) {
            setState(() {
              _currentHeight = value;
            });
          },
        ),
        GCWCoordsOutputFormatDistance(
          coordFormat: _currentCoordsOutputFormat,
          onChanged: (value) {
            setState(() {
              _currentCoordsOutputFormat = value['coordFormat'];
              _currentOutputLength = value['unit'];
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {

    var format = NumberFormat('0.000');
    var julianDate = JulianDate(_currentDateTime['datetime'], _currentDateTime['timezone']);
    var sunPosition =
        logic.SunPosition(_currentCoords, julianDate, getEllipsoidByName(Prefs.get('coord_default_ellipsoid_name')));

    var shadowLen = shadowLength(
        _currentHeight,
        _currentCoords,
        defaultEllipsoid(),
        _currentDateTime['datetime'],
        _currentDateTime['timezone']
    );

    var lengthOutput = '';
    var _currentLength = shadowLen.length;

    var _currentFormattedLength;
    if (_currentLength < 0)
      lengthOutput = i18n(context, 'shadowlength_no_shadow');
    else {
      _currentFormattedLength = _currentOutputLength.fromMeter(_currentLength);
      lengthOutput = format.format(_currentFormattedLength) + ' ' + _currentOutputLength.symbol;
    }

    if (sunPosition.azimuth > 180)
      _currentBearing = sunPosition.azimuth - 180;
    else
    _currentBearing = sunPosition.azimuth + 180;

    var outputsShadow = [
      [i18n(context, 'shadowlength_length'), lengthOutput],
      [i18n(context, 'shadowlength_shadow_direction'), format.format(_currentBearing) + '°'],
    ];
    var rowsShadowData = columnedMultiLineOutput(context, outputsShadow);
    var outputShadowData = GCWDefaultOutput(
      child: Column(
        children: rowsShadowData,
      ),

    );

    var outputsSun = [
      [i18n(context, 'astronomy_position_azimuth'), format.format(shadowLen.sunPosition.azimuth) + '°'],
      [i18n(context, 'astronomy_position_altitude'), format.format(shadowLen.sunPosition.altitude) + '°'],
    ];

    var rowsSunData = columnedMultiLineOutput(context, outputsSun);
    rowsSunData.insert(0, GCWTextDivider(text: i18n(context, 'astronomy_sunposition_title')));

    _currentValues = [projection(_currentCoords, _currentBearing, _currentLength, defaultEllipsoid())];
    var _currentOutput = _currentValues.map((projection) {
      return formatCoordOutput(projection, _currentOutputFormat, defaultEllipsoid());
    }).toList();
    var _currentMapPoints = [
      GCWMapPoint(
          point: _currentCoords,
          markerText: i18n(context, 'coords_waypointprojection_start'),
          coordinateFormat: _currentCoordsFormat),
      GCWMapPoint(
          point: _currentValues[0],
          color: COLOR_MAP_CALCULATEDPOINT,
          markerText: i18n(context, 'coords_waypointprojection_end'),
          coordinateFormat: _currentOutputFormat)
    ];
    var   _currentMapPolylines = [
      GCWMapPolyline(points: [_currentMapPoints[0], _currentMapPoints[1]])
    ];
    var shadowProjection = GCWExpandableTextDivider(
      text: i18n(context, 'shadowlength_shadow_waypoint'),
      child: Column(
        children: <Widget>[
          GCWCoordsOutputFormat(
            coordFormat: _currentOutputFormat,
            onChanged: (value) {
              setState(() {
                _currentOutputFormat = value;
              });
            },
          ),
          GCWCoordsOutput(
            outputs: _currentOutput,
            points: _currentMapPoints,
            polylines: _currentMapPolylines,
          ),
        ]
      )
    );

    var output = rowsSunData;

    output.insert(0, shadowProjection);
    output.insert(0, outputShadowData);

    return Column(children: output);
  }
}
