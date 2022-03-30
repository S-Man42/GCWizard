import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_toolbar.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_sign_dropdownbutton.dart';

enum DateTimePickerConfig {SIGN, TIME, TIME_MSEC, DATE, TIMEZONES }

class TimeZone {
  final int offset;
  final String name;

  TimeZone(this.offset, this.name);
}

final TIMEZONES = [
  TimeZone(720, 'IDLW'),
  TimeZone(-660, ''),
  TimeZone(-600, 'HAST'),
  TimeZone(-570, ''),
  TimeZone(-540, 'HDT, AKST, YST'),
  TimeZone(-480, 'PST, PT, AKDT, YDT'),
  TimeZone(-420, 'MST, PDT'),
  TimeZone(-360, 'CST, MDT'),
  TimeZone(-300, 'CDT, EST'),
  TimeZone(-240, 'EDT, AST'),
  TimeZone(-210, 'NST'),
  TimeZone(-180, '-ADT'),
  TimeZone(-150, 'NDT'),
  TimeZone(-120, ''),
  TimeZone(-60, ''),
  TimeZone(0, 'UTC, GMT, WET/WEZ'),
  TimeZone(60, 'WEST/WEDT/WESZ, BST, IST, CET/MET/MEZ'),
  TimeZone(120, 'CEST/CEDT/MEST/MESZ, WAST, EET/OEZ, CAT, SAST'),
  TimeZone(180, 'EEST/EEDT, BT, MSK, EAT, AST'),
  TimeZone(210, 'IRT'),
  TimeZone(240, ''),
  TimeZone(270, 'IRST'),
  TimeZone(300, ''),
  TimeZone(330, 'IST'),
  TimeZone(345, ''),
  TimeZone(360, ''),
  TimeZone(390, ''),
  TimeZone(420, 'ICT'),
  TimeZone(480, 'CNST'),
  TimeZone(540, 'JST'),
  TimeZone(570, 'ACST'),
  TimeZone(600, 'AEST'),
  TimeZone(630, 'ACDT'),
  TimeZone(660, 'AEDT, NFT'),
  TimeZone(720, 'IDLE, NZST'),
  TimeZone(765, 'IDLE, NZST'),
  TimeZone(780, 'NZDT'),
  TimeZone(825, ''),
  TimeZone(840, ''),
];

class GCWDateTimePicker extends StatefulWidget {
  final Function onChanged;
  final DateTime datetime;
  final Set<DateTimePickerConfig> config;
  final Duration timezoneOffset;

  const GCWDateTimePicker(
      {Key key,
      this.onChanged,
      this.datetime,
      this.config,
      this.timezoneOffset: const Duration(hours: 0)})
      : super(key: key);

  @override
  GCWDateTimePickerState createState() => GCWDateTimePickerState();
}

class GCWDateTimePickerState extends State<GCWDateTimePicker> {
  var _currentSign = 1;
  var _currentYear = 0;
  var _currentMonth = 1;
  var _currentDay = 1;
  var _currentHour = 0;
  var _currentMinute = 0;
  var _currentSecond = 0.0;
  var _currentTimezoneOffset = 0;
  var _currentTimezoneOffsetIndex;

  var _monthFocusNode;
  var _dayFocusNode;
  var _hourFocusNode;
  var _minuteFocusNode;
  var _secondFocusNode;
  var _msecondFocusNode;

  @override
  void initState() {
    super.initState();

    DateTime date = widget.datetime ?? DateTime.now();

    if (widget.config.contains(DateTimePickerConfig.SIGN)) {
      _currentSign = _sign(date);
      _currentMonth = date.month;
      _currentDay = date.day;
    }

    if (widget.config.contains(DateTimePickerConfig.DATE)) {
      _currentYear = date.year;
      _currentMonth = date.month;
      _currentDay = date.day;
    }

    if (widget.config.contains(DateTimePickerConfig.TIME)) {
      _currentHour = date.hour;
      _currentMinute = date.minute;
      _currentSecond = date.second.toDouble();
    }

    if (widget.config.contains(DateTimePickerConfig.TIMEZONES)) {
      _currentTimezoneOffset = date.timeZoneOffset.inMinutes;
      _currentTimezoneOffsetIndex = _timezoneOffsetToIndex(_currentTimezoneOffset);
    }

    _monthFocusNode = FocusNode();
    _dayFocusNode = FocusNode();
    _hourFocusNode = FocusNode();
    _minuteFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _msecondFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _monthFocusNode.dispose();
    _dayFocusNode.dispose();
    _hourFocusNode.dispose();
    _minuteFocusNode.dispose();
    _secondFocusNode.dispose();
    _msecondFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = Map<Widget, int>(); // widget: flex

    if (widget.config.contains(DateTimePickerConfig.SIGN)) {
      widgets.addAll({
        GCWCoordsSignDropDownButton(
          itemList: ['+', '-'],
          value: _currentSign,
          onChanged: (value) {
            setState(() {
              _currentSign = value;
              _setCurrentValueAndEmitOnChange();
            });
          }
        ) : 4}
      );
    }

    if (widget.config.contains(DateTimePickerConfig.DATE)) {
      widgets.addAll({
        GCWIntegerSpinner(
          layout: SpinnerLayout.VERTICAL,
          value: _currentYear,
          min: -5000,
          max: 5000,
          onChanged: (value) {
            setState(() {
              _currentYear = value;
              _setCurrentValueAndEmitOnChange();

              if (_currentYear.toString().length == 4) {
                FocusScope.of(context).requestFocus(_monthFocusNode);
              }
            });
          },
        ): 5}
      );
      widgets.addAll({
        GCWIntegerSpinner(
          focusNode: _monthFocusNode,
          layout: SpinnerLayout.VERTICAL,
          value: _currentMonth,
          min: 1,
          max: 12,
          onChanged: (value) {
            setState(() {
              _currentMonth = value;
              _setCurrentValueAndEmitOnChange();

              if (_currentMonth.toString().length == 2) {
                FocusScope.of(context).requestFocus(_dayFocusNode);
              }
            });
          },
        ): 4});
      widgets.addAll({
        GCWIntegerSpinner(
          focusNode: _dayFocusNode,
          layout: SpinnerLayout.VERTICAL,
          value: _currentDay,
          min: 1,
          max: 31,
          onChanged: (value) {
            setState(() {
              _currentDay = value;
              _setCurrentValueAndEmitOnChange();
            });
          },
        ): 4});
    }

    if (widget.config.contains(DateTimePickerConfig.DATE) && widget.config.contains(DateTimePickerConfig.TIME)) {
      widgets.addAll({
        GCWText(
          text: '-',
          textAlign: TextAlign.center,
        ): 1});
    }

    if (widget.config.contains(DateTimePickerConfig.TIME) ) {
      widgets.addAll({
        GCWIntegerSpinner(
          layout: SpinnerLayout.VERTICAL,
          value: _currentHour,
          min: 0,
          max: 23,
          onChanged: (value) {
            setState(() {
              _currentHour = value;
              _setCurrentValueAndEmitOnChange();

              if (_currentHour
                  .toString()
                  .length == 2) {
                FocusScope.of(context).requestFocus(_minuteFocusNode);
              }
            });
          },
        ): 4}
      );
      widgets.addAll({
        GCWIntegerSpinner(
          focusNode: _minuteFocusNode,
          layout: SpinnerLayout.VERTICAL,
          value: _currentMinute,
          min: 0,
          max: 59,
          onChanged: (value) {
            setState(() {
              _currentMinute = value;
              _setCurrentValueAndEmitOnChange();

              if (_currentMinute
                  .toString()
                  .length == 2) {
                FocusScope.of(context).requestFocus(_secondFocusNode);
              }
            });
          },
        ): 4}
      );
      if (widget.config.contains(DateTimePickerConfig.TIME_MSEC)) {
        widgets.addAll({
          GCWIntegerSpinner(
            focusNode: _secondFocusNode,
            layout: SpinnerLayout.VERTICAL,
            value: _currentSecond.truncate(),
            min: 0,
            onChanged: (value) {
              setState(() {
                _currentSecond = value;
                _setCurrentValueAndEmitOnChange();
              });
            },
          ): 4}
        );
        widgets.addAll({
          GCWIntegerSpinner(
            focusNode: _msecondFocusNode,
            layout: SpinnerLayout.VERTICAL,
            value: _separateDecimalPlaces(_currentSecond),
            min: 0,
            onChanged: (value) {
              setState(() {
                _currentSecond = double.parse('$_currentSecond.$value');
                _setCurrentValueAndEmitOnChange();
              });
            },
          ): 4}
        );
      } else {
        widgets.addAll({
          GCWDoubleSpinner(
            focusNode: _secondFocusNode,
            layout: SpinnerLayout.VERTICAL,
            value: _currentSecond,
            numberDecimalDigits: 4,
            min: 0.0,
            max: 59.999,
            onChanged: (value) {
              setState(() {
                _currentSecond = value;
                _setCurrentValueAndEmitOnChange();
              });
            },
          ): 6}
        );
      }
    }
    
    return Column(
      children: <Widget>[
        GCWToolBar(
          children: widgets.keys.toList(),
          flexValues: widgets.values.toList(),
        ),
        widget.config.contains(DateTimePickerConfig.TIMEZONES) ? _buildTimeZonesDropdownButton() : Container()
      ],
    );
  }

  _indexToTimezoneOffset(int index) {
    return TIMEZONES[index].offset;
  }

  _timezoneOffsetToIndex(int offset) {
    return TIMEZONES.indexWhere((timezone) => timezone.offset == offset);
  }

  _buildTimeZonesDropdownButton() {
    return Row(
      children: [
        Expanded(child: GCWText(text: 'Timezone'), flex: 1),
        Expanded(
            child: GCWDropDownSpinner(
              index: _currentTimezoneOffsetIndex,
              items: TIMEZONES
                  .asMap()
                  .map((index, timeZone) {
                    return MapEntry(
                        index,
                      GCWDropDownMenuItem(
                          value: index, child: _buildTimeZoneItemText(timeZone), subtitle: timeZone.name ?? ''
                      ));
                  })
                  .values
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _currentTimezoneOffsetIndex = value;
                  _currentTimezoneOffset = _indexToTimezoneOffset(value);
                  _setCurrentValueAndEmitOnChange();
                });
              },
            ),
            flex: 3),
      ],
    );
  }

  _buildTimeZoneItemText(TimeZone timeZone) {
    var tzMinutes = timeZone.offset;
    var sign = tzMinutes < 0 ? -1 : 1;

    var tzHours = (tzMinutes.abs() / 60).floor() * sign;
    tzMinutes = tzMinutes.abs() % 60;

    var hoursStr = tzHours < 0 ? tzHours.toString() : '+$tzHours';
    var minutesStr = tzMinutes.toString().padLeft(2, '0');
    var out = '$hoursStr:${minutesStr} h';

    return out;
  }

  int _sign(DateTime datetime) {
    if (datetime == null) return 1;

    if ((datetime.hour <0) || (datetime.year <0)) {
      return -1;
    }

    return 1;
  }

  int _separateDecimalPlaces (double value) {
    var valueSplitted =  value.toString().split('.');

    if (valueSplitted.length < 2)
      return 0;
    else
      return int.parse(valueSplitted[0]);
  }

  _setCurrentValueAndEmitOnChange() {
    var seconds = _currentSecond.floor();
    var milliseconds = ((_currentSecond - seconds) * 1000).round();

    var output = {
      'datetime':
          DateTime(_currentYear, _currentMonth, _currentDay, _currentHour, _currentMinute, seconds, milliseconds),
      'timezone': Duration(minutes: _currentTimezoneOffset)
    };

    widget.onChanged(output);
  }
}
