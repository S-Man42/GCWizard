import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/sun_position.dart' as logic;
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_distance.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_outputformat_distance.dart';
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

  Length _currentInputLength = getUnitBySymbol(allLengths(), Prefs.get('default_length_unit'));
  Length _currentOutputLength = getUnitBySymbol(allLengths(), Prefs.get('default_length_unit'));

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
        GCWTextDivider(
          text: i18n(context, 'shadowlength_outputunit')
        ),
        GCWUnitDropDownButton(
            unitList: allLengths(),
            value: _currentOutputLength,
            onChanged: (Length value) {
              setState(() {
                _currentOutputLength = value;
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
    var _currentLength = _currentHeight * cos(degreesToRadian(sunPosition.altitude)) / sin(degreesToRadian(sunPosition.altitude));
    var lengthOutput = '';

    if(_currentLength < 0)
      lengthOutput = i18n(context, 'shadowlength_no_shadow');
    else {
      _currentLength = _currentOutputLength.fromMeter(_currentLength);
      lengthOutput = format.format(_currentLength) + ' ' + _currentOutputLength.symbol;
    }

    var outputShadow = GCWDefaultOutput(
      child: i18n(context, 'shadowlength_length') + ': $lengthOutput',
      copyText: _currentLength.toString(),
    );

    var outputsSun = [
      [i18n(context, 'astronomy_position_azimuth'), format.format(sunPosition.azimuth) + '°'],
      [i18n(context, 'astronomy_position_altitude'), format.format(sunPosition.altitude) + '°'],
    ];

    var rowsSunData = columnedMultiLineOutput(context, outputsSun);
    rowsSunData.insert(0, GCWTextDivider(text: i18n(context, 'astronomy_sunposition_title')));

    var output = rowsSunData;
    output.insert(0, outputShadow);
    return Column(children: output);
  }
}
