import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/date_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/day_of_the_year.dart';

class DayOfTheYear extends StatefulWidget {
  @override
  DayOfTheYearState createState() => DayOfTheYearState();
}

class DayOfTheYearState extends State<DayOfTheYear> {
  DateTime _currentDate;

  @override
  void initState() {
    DateTime now = DateTime.now();
    _currentDate = DateTime(now.year, now.month, now.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(text: i18n(context, 'dates_weekday_date')),
        GCWDateTimePicker(
          config: {DateTimePickerConfig.DAY_OF_THE_YEAR},
          datetime: _currentDate,
          onChanged: (value) {
            setState(() {
              _currentDate = value['datetime'];
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var outputData = calculateDayInfos(_currentDate.year, _currentDate.difference(new DateTime(_currentDate.year)).inDays + 1);
    if (outputData == null) return Container();

    var rows = columnedMultiLineOutput(context, [
      [i18n(context, 'dates_weekday_date'), outputData.date.toString()],
      [i18n(context, 'dates_weekday'), i18n(context, WEEKDAY[outputData.weekday])],
      [i18n(context, 'dates_weeknumber'), outputData.weeknumber]
    ]);

    return Column(children: rows);
  }
}
