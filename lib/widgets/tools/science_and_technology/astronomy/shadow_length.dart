import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/sun_position.dart' as logic;
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
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
        GCWDoubleSpinner(
          value: _currentHeight,
          min: 0.0,
          numberDecimalDigits: 3,
          onChanged: (value) {
            setState(() {
              _currentHeight = value;
            });
          }),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    var format = NumberFormat('0.000');

    var julianDate = JulianDate(_currentDateTime['datetime'], _currentDateTime['timezone']);

    var sunPosition =
    logic.SunPosition(_currentCoords, julianDate, getEllipsoidByName(Prefs.get('coord_default_ellipsoid_name')));

    var outputsSun = [
      [i18n(context, 'shadowlength_length'), format.format(_currentHeight * cos(sunPosition.altitude) / sin(sunPosition.altitude)) + 'm'],
      [i18n(context, 'astronomy_position_azimuth'), format.format(sunPosition.azimuth) + '°'],
      [i18n(context, 'astronomy_position_altitude'), format.format(sunPosition.altitude) + '°'],
    ];

    var rowsSunData = columnedMultiLineOutput(context, outputsSun);

    rowsSunData.insert(0, GCWTextDivider(text: i18n(context, 'common_output')));

    var output = rowsSunData;
    return Column(children: output);
  }
}
