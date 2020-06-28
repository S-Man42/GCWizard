import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/logic/tools/coords/data/ellipsoid.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/julian_date.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/sun_rise_set.dart' as logic;
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class SunRiseSet extends StatefulWidget {
  @override
  SunRiseSetState createState() => SunRiseSetState();
}

class SunRiseSetState extends State<SunRiseSet> {
  var _currentDateTime = {'datetime': DateTime.now(), 'timezone': DateTime.now().timeZoneOffset};
  var _currentCoords = defaultCoordinate;
  var _currentCoordsFormat = defaultCoordFormat();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWCoords(
          text: 'Location',
          coordsFormat: _currentCoordsFormat,
          onChanged: (ret) {
            setState(() {
              _currentCoordsFormat = ret['coordsFormat'];
              _currentCoords = ret['value'];
            });
          },
        ),
        GCWTextDivider(
          text: 'Date (yyyy/mm/dd) & Time (HH/mm/ss)',
        ),
        GCWDateTimePicker(
          type: DateTimePickerType.DATE_ONLY,
          withTimezones: true,
          onChanged: (datetime) {
            setState(() {
              _currentDateTime = datetime;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    var sunRise = logic.SunRiseSet(
      _currentCoords,
      JulianDate(_currentDateTime['datetime'], _currentDateTime['timezone']),
      _currentDateTime['timezone'],
      getEllipsoidByName(Prefs.get('coord_default_ellipsoid_name'))
    );

    var outputs = [
      ['Astronomical Morning', sunRise.astronomicalMorning.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.astronomicalMorning)],
      ['Nautical Morning', sunRise.nauticalMorning.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.nauticalMorning)],
      ['Civil Morning', sunRise.civilMorning.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.civilMorning)],
      ['Rise', sunRise.rise.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.rise)],
      ['Transit', sunRise.transit.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.transit)],
      ['Set', sunRise.set.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.set)],
      ['Civil Evening', sunRise.civilEvening.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.civilEvening)],
      ['Nautical Evening', sunRise.nauticalEvening.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.nauticalEvening)],
      ['Astronomical Evening', sunRise.astronomicalEvening.isNaN ? 'N/A' : formatHoursToHHmmss(sunRise.astronomicalEvening)],
    ];

    var rows = columnedMultiLineOutput(outputs);

    rows.insert(0,
      GCWTextDivider(
        text: i18n(context, 'common_output')
      )
    );

    return Column(
      children: rows
    );
  }
}