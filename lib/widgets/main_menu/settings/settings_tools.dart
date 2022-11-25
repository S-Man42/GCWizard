import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/maya_calendar.dart';
import 'package:gc_wizard/utils/settings/preferences.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:prefs/prefs.dart';

class ToolSettings extends StatefulWidget {
  @override
  ToolSettingsState createState() => ToolSettingsState();
}

class ToolSettingsState extends State<ToolSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_mayacalendar_title'),
        ),
        GCWDropDownButton(
          value: Prefs.get(PREFERENCE_MAYACALENDAR_CORRELATION),
          onChanged: (value) {
            setState(() {
              Prefs.setString(PREFERENCE_MAYACALENDAR_CORRELATION, value);
            });
          },
          items: CORRELATION_SYSTEMS.entries.map((mode) {
            // Map<String, String> CORRELATION_SYSTEMS = {
            //   THOMPSON: 'Thompson (584283)',
            //   SMILEY: 'Smiley (482699)',
            //   WEITZEL: 'Weitzel (774078)',
            // };
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
