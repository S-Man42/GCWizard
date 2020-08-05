import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/astronomy/easter.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class EasterYears extends StatefulWidget {
  @override
  EasterYearsState createState() => EasterYearsState();
}

class EasterYearsState extends State<EasterYears> {
  int _currentMonth = 3;
  int _currentDay = 22;

  var _listDaysForMarch = <int>[22, 23, 24, 25, 26, 27, 28, 29, 30, 31];
  var _listDaysForApril = List<int>.generate(25, (index) => index + 1);

  List<int> _currentDayList;

  @override
  void initState() {
    super.initState();

    _currentDayList = _listDaysForMarch;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'common_month') + '/' + i18n(context, 'common_day'),
        ),
        Row(
          children: [
            Expanded(
              child: GCWDropDownButton(
                value: _currentMonth,
                items: [
                  DropdownMenuItem(
                    value: 3,
                    child: Text(i18n(context, 'common_month_march')),
                  ),
                  DropdownMenuItem(
                    value: 4,
                    child: Text(i18n(context, 'common_month_april')),
                  )
                ],
                onChanged: (value) {
                  if (_currentMonth != value) {
                    setState(() {
                      _currentMonth = value;

                      if (_currentMonth == 3) {
                        _currentDayList = _listDaysForMarch;
                        if (_currentDay < 22)
                          _currentDay = 22;
                      } else {
                        _currentDayList = _listDaysForApril;
                        if (_currentDay > 25)
                          _currentDay = 25;
                      }
                    });
                  }
                },
              ),
            ),
            Expanded(
              child: GCWDropDownButton(
                value: _currentDay,
                items: _currentDayList.map((day) {
                  return DropdownMenuItem(
                    value: day,
                    child: Text(day.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _currentDay = value;
                  });
                },
              ),
            )
          ],
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var years = gregorianEasterYears(_currentMonth, _currentDay);

    return GCWDefaultOutput(
      text: years.join('\n')
    );
  }
}