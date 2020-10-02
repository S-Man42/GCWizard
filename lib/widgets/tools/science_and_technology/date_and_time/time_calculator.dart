import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_divider.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:intl/intl.dart';

// enabling int value to get passed as reference
class _WrapperForInt {
  int value;
  _WrapperForInt(this.value);
}

class TimeCalculator extends StatefulWidget {
  @override
  TimeCalculatorState createState() => TimeCalculatorState();
}

class TimeCalculatorState extends State<TimeCalculator> {
  var _currentMode = GCWSwitchPosition.left;

  var _startDays = _WrapperForInt(0);
  var _startHours = _WrapperForInt(0);
  var _startMinutes = _WrapperForInt(0);
  var _startSeconds = _WrapperForInt(0);

  var _endDays = _WrapperForInt(0);
  var _endHours = _WrapperForInt(0);
  var _endMinutes = _WrapperForInt(0);
  var _endSeconds = _WrapperForInt(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'dates_timecalculator_starttime')
        ),
        Row(
          children: [
            _buildIntegerSpinner(_startDays),
            _buildIntegerSpinner(_startHours),
            _buildIntegerSpinner(_startMinutes),
            _buildIntegerSpinner(_startSeconds),
          ],
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'dates_timecalculator_operation'),
          leftValue: '+',
          rightValue: '-',
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextDivider(
            text: i18n(context, 'dates_timecalculator_endtime')
        ),
        Row(
          children: [
            _buildIntegerSpinner(_endDays),
            _buildIntegerSpinner(_endHours),
            _buildIntegerSpinner(_endMinutes),
            _buildIntegerSpinner(_endSeconds),
          ],
        ),
        GCWDefaultOutput(
          child: _buildOutput(),
        )
      ],
    );
  }

  _buildIntegerSpinner(_value) {
    return Expanded(
      child: Container(
        child: GCWIntegerSpinner(
          value: _value.value,
          min: 0,
          suppressOverflow: true,
          layout: SpinnerLayout.VERTICAL,
          onChanged: (value) {
            setState(() {
              _value.value = value;
            });
          },
        ),
        padding: EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
      ),
    );
  }

  _buildOutput() {
    print(_startHours);

    var startTime = Duration(
      days: _startDays.value,
      hours: _startHours.value,
      minutes: _startMinutes.value,
      seconds: _startSeconds.value
    );

    var endTime = Duration(
      days: _endDays.value,
      hours: _endHours.value,
      minutes: _endMinutes.value,
      seconds: _endSeconds.value
    );

    Duration finalTime;
    if (_currentMode == GCWSwitchPosition.left)
      finalTime = startTime + endTime;
    else
      finalTime = startTime - endTime;

    var format = NumberFormat('00');

    var output = finalTime.isNegative ? '-' : '';
    finalTime = finalTime.abs();

    var days = finalTime.inDays;
    var hours = finalTime.inHours - finalTime.inDays * 24;
    var minutes = finalTime.inMinutes - finalTime.inHours * 60;
    var seconds = finalTime.inSeconds - finalTime.inMinutes * 60;

    output += '${format.format(days)}'
      ':${format.format(hours)}'
      ':${format.format(minutes)}'
      ':${format.format(seconds)}';

    return output;
  }
}