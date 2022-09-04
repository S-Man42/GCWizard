import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/date_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/day_of_the_year.dart';
import 'package:intl/intl.dart';

class DayOfTheYear extends StatefulWidget {
  @override
  DayOfTheYearState createState() => DayOfTheYearState();
}

class DayOfTheYearState extends State<DayOfTheYear> {
  var _currentMode = GCWSwitchPosition.left;
  DateTime _currentEncodeDate;
  DateTime _currentDecodeDate;

  @override
  void initState() {
    DateTime now = DateTime.now();
    _currentEncodeDate = DateTime(now.year, now.month, now.day);
    _currentDecodeDate = DateTime(now.year, now.month, now.day);

     super.initState();
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
        _currentMode == GCWSwitchPosition.left
          ? _encodeWidget()
          : _decodeWidget(),
        _buildOutput(context)
      ],
    );
  }

  Widget _encodeWidget() {
    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'dates_day_of_the_year_date')),
        GCWDateTimePicker(
          config: {DateTimePickerConfig.DAY_OF_THE_YEAR},
          datetime: _currentEncodeDate,
          maxDays: 366,
          onChanged: (value) {
            setState(() {
              _currentEncodeDate = value['datetime'];
            });
          },
        ),
    ]);
  }

  Widget _decodeWidget() {
    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'dates_weekday_date')),
        GCWDateTimePicker(
          config: {DateTimePickerConfig.DATE},
          datetime: _currentDecodeDate,
          onChanged: (value) {
            setState(() {
              _currentDecodeDate = value['datetime'];
            });
          },
        ),
    ]);
  }


  Widget _buildOutput(BuildContext context) {
    DayOfTheYearOutput outputData;
    if (_currentMode == GCWSwitchPosition.left)
      outputData = calculateDayInfos(_currentEncodeDate.year, dayNumber(_currentEncodeDate));
    else
      outputData = calculateDateInfos(_currentDecodeDate);

    if (outputData == null) return Container();

    DateFormat formatter = DateFormat('yyyy-MM-dd');

    List<Widget> rows;
    if (_currentMode == GCWSwitchPosition.left)
      rows = columnedMultiLineOutput(context, [
        [i18n(context, 'dates_weekday_date'), formatter.format(outputData.date)],
        [i18n(context, 'dates_weekday'), i18n(context, WEEKDAY[outputData.weekday])],
        [i18n(context, 'dates_weekday'), outputData.weekday],
        [i18n(context, 'dates_week_number'), outputData.weekNumberIso],
      ]);
    else
      rows = columnedMultiLineOutput(context, [
        [i18n(context, 'dates_day_number'), outputData.dayNumber ],
        [i18n(context, 'dates_weekday'), i18n(context, WEEKDAY[outputData.weekday])],
        [i18n(context, 'dates_weekday'), outputData.weekday],
        [i18n(context, 'dates_week_number'), outputData.weekNumberIso],
      ]);


    var rowsAlternate = columnedMultiLineOutput(context, [
      [i18n(context, 'dates_weekday'), outputData.weekdayAlternate],
      [i18n(context, 'dates_week_number'), outputData.weekNumberAlternate],
    ]);

    rows.add(GCWOutput(
      title: i18n(context, 'dates_day_of_the_year_alternatively'),
      child: Column(children: rowsAlternate),
    ));

    return Column(children: rows);
  }
}
