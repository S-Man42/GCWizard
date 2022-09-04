import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/date_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
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
        _currentMode == GCWSwitchPosition.right
          ? _decodeWidget()
          : _encodeWidget(),
        _buildOutput(context)
      ],
    );
  }

  Widget _decodeWidget() {
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

  Widget _encodeWidget() {
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
    if (_currentMode == GCWSwitchPosition.right)
      outputData = calculateDayInfos(_currentEncodeDate.year, dayNumber(_currentEncodeDate));
    else
      outputData = calculateDateInfos(_currentDecodeDate);

    if (outputData == null) return Container();

    var dateFormat = DateFormat('yMd', Localizations.localeOf(context).toString());

    var children = <Widget>[];

    if (_currentMode == GCWSwitchPosition.right) {
      children.add(
        GCWDefaultOutput(
          child: dateFormat.format(outputData.date),
        )
      );
    } else {
      children.add(
        GCWDefaultOutput(
          child: outputData.dayNumber,
        )
      );
    }

    children.add(
      GCWOutput(
        title: i18n(context, 'dates_weekday'),
        child: i18n(context, WEEKDAY[outputData.weekday]),
      )
    );

    children.add(
      GCWOutput(
        title: 'ISO 8601',
        child: Column(
          children: columnedMultiLineOutput(context, [
            [i18n(context, 'dates_weekday_number'), outputData.weekday],
            [i18n(context, 'dates_week_number'), outputData.weekNumberIso],
          ])
        ),
      )
    );

    children.add(
      GCWOutput(
        title: i18n(context, 'dates_day_of_the_year_alternative'),
        child: Column(
          children: columnedMultiLineOutput(context, [
            [i18n(context, 'dates_weekday_number'), outputData.weekdayAlternate],
            [i18n(context, 'dates_week_number'), outputData.weekNumberAlternate],
          ]),
        )
      )
    );

    return Column(children: children);
  }
}
