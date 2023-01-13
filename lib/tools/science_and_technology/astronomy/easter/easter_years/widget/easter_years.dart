import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/gcw_dropdownbutton.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_text_divider/gcw_text_divider.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/logic/easter.dart';

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
                child: Container(
              child: GCWDropDownButton(
                value: _currentMonth,
                items: [
                  GCWDropDownMenuItem(
                    value: 3,
                    child: i18n(context, 'common_month_march'),
                  ),
                  GCWDropDownMenuItem(
                    value: 4,
                    child: i18n(context, 'common_month_april'),
                  )
                ],
                onChanged: (value) {
                  if (_currentMonth != value) {
                    setState(() {
                      _currentMonth = value;

                      if (_currentMonth == 3) {
                        _currentDayList = _listDaysForMarch;
                        if (_currentDay < 22) _currentDay = 22;
                      } else {
                        _currentDayList = _listDaysForApril;
                        if (_currentDay > 25) _currentDay = 25;
                      }
                    });
                  }
                },
              ),
              padding: EdgeInsets.only(right: DEFAULT_MARGIN),
            )),
            Expanded(
              child: Container(
                child: GCWDropDownButton(
                  value: _currentDay,
                  items: _currentDayList.map((day) {
                    return GCWDropDownMenuItem(
                      value: day,
                      child: day.toString(),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentDay = value;
                    });
                  },
                ),
                padding: EdgeInsets.only(left: DEFAULT_MARGIN),
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

    return GCWDefaultOutput(child: years.join('\n'));
  }
}
