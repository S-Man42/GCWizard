
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
    _currentJulianDate = GregorianCalendarToJulianDate(_currentDate);
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
        if (_currentCalendarSystem == CalendarSystem.JULIANCALENDAR || _currentCalendarSystem == CalendarSystem.GREGORIANCALENDAR ||
            _currentCalendarSystem == CalendarSystem.ISLAMICCALENDAR || _currentCalendarSystem == CalendarSystem.COPTICCALENDAR ||
            _currentCalendarSystem == CalendarSystem.PERSIANCALENDAR || _currentCalendarSystem == CalendarSystem.HEBREWCALENDAR)
          GCWDatePicker(
            date: _currentDate,
            type: _currentCalendarSystem,
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
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.JULIANDATE :
        jd = _currentJulianDate;
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.GREGORIANCALENDAR :
        jd = GregorianCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.JULIANCALENDAR :
        jd = JulianCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
      case CalendarSystem.ISLAMICCALENDAR :
        jd = IslamicCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = WEEKDAY_ISLAMIC[Weekday(jd)];
        break;
      case CalendarSystem.PERSIANCALENDAR :
        jd = PersianCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = WEEKDAY_PERSIAN[Weekday(jd)];
        break;
      case CalendarSystem.HEBREWCALENDAR :
        jd = HebrewCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = WEEKDAY_HEBREW[Weekday(jd)];
        break;
      case CalendarSystem.COPTICCALENDAR :
        jd = CopticCalendarToJulianDate(_currentDate);
        output['dates_weekday_title'] = i18n(context, WEEKDAY[Weekday(jd)]);
        break;
    }
    output['dates_calendar_system_juliandate'] = (jd + 0.5).floor();
    output['dates_calendar_system_juliancalendar'] = _DateToString(context, JulianDateToJulianCalendar(jd, true), CalendarSystem.JULIANCALENDAR, true);
    output['dates_calendar_system_modifiedjuliandate'] = JulianDateToModifedJulianDate(jd);
    output['dates_calendar_system_gregoriancalendar'] = _DateToString(context, JulianDateToGregorianCalendar(jd, true), CalendarSystem.GREGORIANCALENDAR, true);
    output['dates_calendar_system_islamiccalendar'] = _DateToString(context, JulianDateToIslamicCalendar(jd), CalendarSystem.ISLAMICCALENDAR, true);
    output['dates_calendar_system_hebrewcalendar'] = _HebrewDateToString(JulianDateToHebrewCalendar(jd), jd, true);
    output['dates_calendar_system_persiancalendar'] = _DateToString(context, JulianDateToPersianCalendar(jd), CalendarSystem.PERSIANCALENDAR, true);
    output['dates_calendar_system_copticcalendar'] = _DateToString(context, JulianDateToCopticCalendar(jd), CalendarSystem.COPTICCALENDAR, true);
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

  String _HebrewDateToString(DateOutput HebrewDate, double jd, bool verbose){
    if (typeOfJewYear(JewishYearLength(jd)).contains('embolistic'))
      if (verbose)
        return HebrewDate.day + ' ' + MONTH_NAMES[CalendarSystem.HEBREWCALENDAR][int.parse(HebrewDate.month)].toString() + ' ' + HebrewDate.year;
      else
        return HebrewDate.day + '.' + HebrewDate.month + '.' + HebrewDate.year;
    else {
      int month = int.parse(HebrewDate.month);
      if (month > 6)
        month = 1 + int.parse(HebrewDate.month);
      if (verbose)
        return HebrewDate.day + ' ' + MONTH_NAMES[CalendarSystem.HEBREWCALENDAR][month] + ' ' + HebrewDate.year;
      else
        return HebrewDate.day + '.' + month.toString() + '.' + HebrewDate.year;
    }
  }

  String _DateToString(context, DateOutput date, CalendarSystem calendar, bool verbose){
    final Locale appLocale = Localizations.localeOf(context);
    switch (calendar) {
      case CalendarSystem.ISLAMICCALENDAR:
      case CalendarSystem.PERSIANCALENDAR:
      case CalendarSystem.COPTICCALENDAR:
        if (verbose)
          return date.day + ' ' + MONTH_NAMES[calendar][int.parse(date.month)].toString() + ' ' + date.year;
        else
          return date.day + '.' + date.month + '.' + date.year;
        break;
      case CalendarSystem.GREGORIANCALENDAR :
      case CalendarSystem.JULIANCALENDAR :
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
    };
  }

}


