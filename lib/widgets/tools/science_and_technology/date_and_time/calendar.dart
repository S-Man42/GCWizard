
import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/date_and_time/calendar.dart';
import 'package:gc_wizard/logic/common/date_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_date_picker.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  CalendarSystem _currentCalendarSystem = CalendarSystem.JULIANDATE;
  double _currentJulianDate = 0.0;
  DateTime _currentDate;

  @override
  void initState() {
    DateTime now = DateTime.now();
    _currentDate = DateTime(now.year, now.month, now.day);
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
        GCWDropDownButton(
          value: _currentCalendarSystem,
          onChanged: (value) {
            setState(() {
              _currentCalendarSystem = value;
            });
          },
          items: CALENDAR_SYSTEM.entries.map((system) {
            return GCWDropDownMenuItem(
              value: system.key,
              child: i18n(context, system.value),
            );
          }).toList(),
        ),
        if (_currentCalendarSystem == CalendarSystem.JULIANDATE || _currentCalendarSystem == CalendarSystem.MODIFIEDJULIANDATE)
          GCWDoubleSpinner(
              value: _currentJulianDate,
              numberDecimalDigits: 2,
              onChanged: (value) {
                setState(() {
                  _currentJulianDate = value;
                });
              }),
        if (_currentCalendarSystem == CalendarSystem.JULIANCALENDAR || _currentCalendarSystem == CalendarSystem.GREGORIANCALENDAR)
          GCWDatePicker(
            date: _currentDate,
            onChanged: (value) {
              setState(() {
                _currentDate = value;
              });
            },
          ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    double jd = 0.0;
    Map output = new Map();
    switch (_currentCalendarSystem) {
      case CalendarSystem.MODIFIEDJULIANDATE :
        jd = ModifedJulianDateToJulianDate(_currentJulianDate);
        break;
      case CalendarSystem.JULIANDATE :
        jd = _currentJulianDate;
        break;
      case CalendarSystem.GREGORIANCALENDAR :
        jd = GregorianCalendarToJulianDate(_currentDate);
        break;
      case CalendarSystem.JULIANCALENDAR :
        jd = JulianCalendarToJulianDate(_currentDate);
        break;
    }
    output['dates_calendar_system_juliandate'] = jd;
    output['dates_calendar_system_juliancalendar'] = _DateToString(context, JulianDateToJulianCalendar(jd, true), true);
    output['dates_calendar_system_modifiedjuliandate'] = JulianDateToModifedJulianDate(jd);
    output['dates_calendar_system_gregoriancalendar'] = _DateToString(context, JulianDateToGregorianCalendar(jd, true), true);
    return GCWDefaultOutput(
        child: Column(
          children: columnedMultiLineOutput(
              context,
              output.entries.map((entry) {
                return [i18n(context, entry.key), entry.value];
              }).toList(),
              flexValues: [1, 1]),
        ));
  }

  String _DateToString(context, DateOutput date, bool verbose){
    final Locale appLocale = Localizations.localeOf(context);
    switch (appLocale.languageCode) {
      case 'de' :
        if (verbose)
          return date.day + ' ' + i18n(context, MONTH[int.parse(date.month)]) + ' ' + date.year;
        else
          return date.day + '.' + date.month + '.' + date.year;
        break;
      case 'fr' :
        return date.day + ' ' + i18n(context, MONTH[int.parse(date.month)]).toLowerCase() + ' ' + date.year;
        break;
      default :
        if (verbose)
          return date.year + '/' + i18n(context, MONTH[int.parse(date.month)]) + ' ' + date.day;
        else
          return date.year + '/' + date.month + '/' + date.day;

    }
  }

}


