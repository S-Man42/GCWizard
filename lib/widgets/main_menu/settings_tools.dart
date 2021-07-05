import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/maya_calendar.dart';
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
          value: Prefs.get('mayacalendar_correlation'),
          onChanged: (value) {
            setState(() {
              Prefs.setString('mayacalendar_correlation', value);
            });
          },
          items: CORRELATION_SYSTEMS.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_imagecolorcorrections_title'),
        ),
        GCWDropDownButton(
          value: Prefs.get('imagecolorcorrections_maxpreviewheight'),
          onChanged: (value) {
            setState(() {
              Prefs.setInt('imagecolorcorrections_maxpreviewheight', value);
            });
          },
          items: {
            100: i18n(context, 'settings_imagecolorcorrections_previewsize_tiny'),
            250: i18n(context, 'settings_imagecolorcorrections_previewsize_small'),
            500: i18n(context, 'settings_imagecolorcorrections_previewsize_medium'),
            1000: i18n(context, 'settings_imagecolorcorrections_previewsize_big'),
            50000: i18n(context, 'settings_imagecolorcorrections_previewsize_original'),
          }.entries.map((mode) {
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
