import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/maya_calendar.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:prefs/prefs.dart';

class MayaCalendarSettings extends StatefulWidget {
  @override
  MayaCalendarSettingsState createState() => MayaCalendarSettingsState();
}

class MayaCalendarSettingsState extends State<MayaCalendarSettings> {
  var _currentCorrelation = Prefs.getString('mayacalendar_correlation');
  @override
  Widget build(BuildContext context) {
    if (_currentCorrelation == null || _currentCorrelation == '') _currentCorrelation = THOMPSON;
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_mayacalendar_correlation_number'),
        ),
        GCWDropDownButton(
          value: _currentCorrelation,
          onChanged: (value) {
            setState(() {
              _currentCorrelation = value;
              Prefs.setString('mayacalendar_correlation', _currentCorrelation);
            });
          },
          items: CORRELATION_SYSTEMS.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
        ),
      ],
    );
  }
}
