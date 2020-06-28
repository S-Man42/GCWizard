import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

enum DateTimePickerType {DATETIME, DATE_ONLY, TIME_ONLY}

class TimeZone {
  final int offset;
  final String name;

  TimeZone(this.offset, this.name);
}

final timeZones =  [
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
  final DateTimePickerType type;
  final bool withTimezones;
  final Duration timezoneOffset;

  const GCWDateTimePicker({
    Key key,
    this.onChanged,
    this.datetime,
    this.type: DateTimePickerType.DATETIME,
    this.withTimezones: false,
    this.timezoneOffset: const Duration(hours: 0)
  }) : super(key: key);

  @override
  GCWDateTimePickerState createState() => GCWDateTimePickerState();
}

class GCWDateTimePickerState extends State<GCWDateTimePicker> {
  var _currentYear = 0;
  var _currentMonth = 1;
  var _currentDay = 1;
  var _currentHour = 0;
  var _currentMinute = 0;
  var _currentSecond = 0.0;
  var _currentTimezoneOffset = 0;

  var _monthFocusNode;
  var _dayFocusNode;
  var _hourFocusNode;
  var _minuteFocusNode;
  var _secondFocusNode;

  @override
  void initState() {
    super.initState();

    DateTime date = widget.datetime ?? DateTime.now();

    print(date);
    print(DateTime.now());
    print(date.timeZoneName);

    if (widget.type != DateTimePickerType.TIME_ONLY) {
      _currentYear = date.year;
      _currentMonth = date.month;
      _currentDay = date.day;
    }

    if (widget.type != DateTimePickerType.DATE_ONLY) {
      _currentHour = date.hour;
      _currentMinute = date.minute;
      _currentSecond = date.second.toDouble();
    }

    if (widget.withTimezones) {
      _currentTimezoneOffset = date.timeZoneOffset.inMinutes;
    }

    _monthFocusNode = FocusNode();
    _dayFocusNode = FocusNode();
    _hourFocusNode = FocusNode();
    _minuteFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _monthFocusNode.dispose();
    _dayFocusNode.dispose();
    _hourFocusNode.dispose();
    _minuteFocusNode.dispose();
    _secondFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var datePart;
    if (widget.type != DateTimePickerType.TIME_ONLY) {
      datePart = <Widget>[
        Expanded(
          child: Padding(
            child: GCWIntegerSpinner(
              layout: SpinnerLayout.vertical,
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
            ),
            padding: EdgeInsets.only (
              right: 2
            )
          ),
          flex: 5
        ),
        Expanded(
          child: Padding(
            child: GCWIntegerSpinner(
              focusNode: _monthFocusNode,
              layout: SpinnerLayout.vertical,
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
            ),
            padding: EdgeInsets.only(
              left: 2,
              right: 2
            )
          ),
          flex: 4
        ),
        Expanded(
          child: Padding(
            child: GCWIntegerSpinner(
              focusNode: _dayFocusNode,
              layout: SpinnerLayout.vertical,
              value: _currentDay,
              min: 1,
              max: 31,
              onChanged: (value) {
                setState(() {
                  _currentDay = value;
                  _setCurrentValueAndEmitOnChange();
                });
              },
            ),
            padding: EdgeInsets.only(
              left: 2,
              right: widget.type == DateTimePickerType.DATETIME ? 2 : 0
            ),
          ),
          flex: 4
        )
      ];
    }

    var timePart;
    if (widget.type != DateTimePickerType.DATE_ONLY) {
      timePart = <Widget>[
        Expanded(
          child: Padding(
            child: GCWIntegerSpinner(
              layout: SpinnerLayout.vertical,
              value: _currentHour,
              min: 0,
              max: 23,
              onChanged: (value) {
                setState(() {
                  _currentHour = value;
                  _setCurrentValueAndEmitOnChange();

                  if (_currentHour.toString().length == 2) {
                    FocusScope.of(context).requestFocus(_minuteFocusNode);
                  }
                });
              },
            ),
            padding: EdgeInsets.only (
              left: widget.type == DateTimePickerType.DATETIME ? 2 : 0,
              right: 2
            )
          ),
          flex: 4
        ),
        Expanded(
          child: Padding(
            child: GCWIntegerSpinner(
              focusNode: _minuteFocusNode,
              layout: SpinnerLayout.vertical,
              value: _currentMinute,
              min: 0,
              max: 59,
              onChanged: (value) {
                setState(() {
                  _currentMinute = value;
                  _setCurrentValueAndEmitOnChange();

                  if (_currentMinute.toString().length == 2) {
                    FocusScope.of(context).requestFocus(_secondFocusNode);
                  }
                });
              },
            ),
            padding: EdgeInsets.only(
              left: 2,
              right: 2
            )
          ),
          flex: 4
        ),
        Expanded(
          child: Padding(
            child: GCWDoubleSpinner(
              focusNode: _secondFocusNode,
              layout: SpinnerLayout.vertical,
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
            ),
            padding: EdgeInsets.only(
              left: 2,
            ),
          ),
          flex: 6
        )
      ];
    }

    var datetimeChildren = <Widget>[];
    if (datePart != null)
      datetimeChildren.addAll(datePart);

    if (widget.type == DateTimePickerType.DATETIME) {
      datetimeChildren.add(
        Expanded(
          child: Text(
            '-',
            textAlign: TextAlign.center,
          ),
          flex: 1
        )
      );
    }

    if (timePart != null)
      datetimeChildren.addAll(timePart);


    return Column(
      children: <Widget>[
        Row(
          children: datetimeChildren,
        ),
        widget.withTimezones
          ? _buildTimeZonesDropdownButton()
          : Container()
      ],
    );
  }

  _findFittingTimeZone() {
    var offset = 0;

    try {
      offset = timeZones.firstWhere((timezone) => timezone.offset == _currentTimezoneOffset).offset;
    } catch(e) {}

    return offset;
  }

  _buildTimeZonesDropdownButton() {
    var tzHours = (_currentTimezoneOffset / 60).floor();
    var tzMinutes = _currentTimezoneOffset - tzHours;

    return Row(
      children: [
        Expanded(
          child: Text('Timezone'),
          flex: 1
        ),
        Expanded(
          child: GCWDropDownButton(
            value: _findFittingTimeZone(),
            items: timeZones.map((timeZone) {
              return DropdownMenuItem(
                value: timeZone.offset,
                child: Text(
                  _buildTimeZoneItemText(timeZone)
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _currentTimezoneOffset = value;
              });
            },
          ),
          flex: 3
        )
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
    var out = '$hoursStr:${minutesStr}h';

    if (timeZone.name != null && timeZone.name.length > 0)
      out += ' (${timeZone.name})';

    return out;
  }

  _setCurrentValueAndEmitOnChange() {
    var seconds = _currentSecond.floor();
    var milliseconds = ((_currentSecond - seconds) * 1000).round();

    widget.onChanged(DateTime(_currentYear, _currentMonth, _currentDay, _currentHour, _currentMinute, seconds, milliseconds));
  }
}