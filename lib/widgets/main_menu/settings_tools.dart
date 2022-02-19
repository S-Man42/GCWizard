import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/maya_calendar.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:prefs/prefs.dart';

class ToolSettings extends StatefulWidget {
  @override
  ToolSettingsState createState() => ToolSettingsState();
}

class ToolSettingsState extends State<ToolSettings> {

  GCWSwitchPosition _WherigoMode;

  @override
  Widget build(BuildContext context) {

    if (Prefs.get('wherigo_get_lua') == 'online')
      _WherigoMode = GCWSwitchPosition.left;
    else
      _WherigoMode = GCWSwitchPosition.right;

    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_mayacalendar_title'),
        ),
        GCWDropDownButton(
          value: Prefs.get('mayacalendar_correlation'),
          onChanged: (value) {
            setState(() {
              Prefs.setString('mayacalendar_correlation', value);
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
        GCWTextDivider(
          text: i18n(context, 'settings_wherigo_analyze_title'),
        ),
        GCWTwoOptionsSwitch(
            title: i18n(context, 'settings_wherigo_get_lua'),
            leftValue: i18n(context, 'settings_wherigo_online'),
            rightValue: i18n(context, 'settings_wherigo_offline'),
            value: _WherigoMode,
          onChanged: (value) {
            setState(() {
              _WherigoMode = value;
              if (_WherigoMode == GCWSwitchPosition.left)
                Prefs.setString('wherigo_get_lua', 'online');
              else
                Prefs.setString('wherigo_get_lua', 'offline');
            });
          },
        )
      ],
    );
  }
}
