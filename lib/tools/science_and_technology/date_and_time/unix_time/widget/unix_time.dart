import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/calendar/logic/calendar_constants.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/unix_time/logic/unix_time.dart';
import 'package:gc_wizard/utils/datetime_utils.dart';

class UnixTime extends StatefulWidget {
  const UnixTime({Key? key}) : super(key: key);

  @override
  _UnixTimeState createState() => _UnixTimeState();
}

class _UnixTimeState extends State<UnixTime> {
  int _currentTimeStamp = 0;
  var _currentDateTime = DateTime.now();
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        if (_currentMode == GCWSwitchPosition.right)
          GCWIntegerSpinner(
              value: _currentTimeStamp,
              min: 0,
              onChanged: (value) {
                setState(() {
                  _currentTimeStamp = value;
                });
              }),
        if (_currentMode == GCWSwitchPosition.left)
          GCWDateTimePicker(
            config: const {DateTimePickerConfig.DATE, DateTimePickerConfig.TIME, DateTimePickerConfig.SECOND_AS_INT, DateTimePickerConfig.TIMEZONES},
            onChanged: (datetime) {
              setState(() {
                _currentDateTime = datetime.datetime;
              });
            },
          ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    String output = '';
    if (_currentMode == GCWSwitchPosition.left) {//Date to Unix
      if (_invalidUnixDate(gregorianCalendarToJulianDate(_currentDateTime))) {
        output = i18n(context, 'dates_calendar_error');
      }
      output = DateTimeToUnixTime(_currentDateTime);
    } else {//UNIX to Date
      output = UnixTimeToDateTime(_currentTimeStamp);
    }
    return GCWDefaultOutput(
      child: output,
    );
  }

  bool _invalidUnixDate(double jd) {
    return (jd < JD_UNIX_START);
  }
}
