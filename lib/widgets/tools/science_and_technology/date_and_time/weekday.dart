import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class Weekday extends StatefulWidget {
  @override
  WeekdayState createState() => WeekdayState();
}

class WeekdayState extends State<Weekday> {
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
          config: {DateTimePickerConfig.DATE},
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
    var weekday = _currentDate.weekday;

    var output;
    switch (weekday) {
      case 1:
        output = i18n(context, 'dates_weekday_monday');
        break;
      case 2:
        output = i18n(context, 'dates_weekday_tuesday');
        break;
      case 3:
        output = i18n(context, 'dates_weekday_wednesday');
        break;
      case 4:
        output = i18n(context, 'dates_weekday_thursday');
        break;
      case 5:
        output = i18n(context, 'dates_weekday_friday');
        break;
      case 6:
        output = i18n(context, 'dates_weekday_saturday');
        break;
      case 7:
        output = i18n(context, 'dates_weekday_sunday');
        break;
    }

    return GCWDefaultOutput(child: output);
  }
}
