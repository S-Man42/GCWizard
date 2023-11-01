import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/settings/logic/preferences.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/science_and_technology/maya_calendar/logic/maya_calendar.dart';
import 'package:prefs/prefs.dart';

class ToolSettings extends StatefulWidget {
  const ToolSettings({Key? key}) : super(key: key);

  @override
  _ToolSettingsState createState() => _ToolSettingsState();
}

class _ToolSettingsState extends State<ToolSettings> {

  late TextEditingController _chatGPTAPIKeyController;
  String _chatgpt_api_key = Prefs.get(PREFERENCE_CHATGPT_API_KEY).toString();

  @override
  void initState() {
    super.initState();

    _chatGPTAPIKeyController = TextEditingController(text: _chatgpt_api_key);
  }

  @override
  void dispose() {
    _chatGPTAPIKeyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_mayacalendar_title'),
        ),
        GCWDropDown<String>(
          value: Prefs.getString(PREFERENCE_MAYACALENDAR_CORRELATION),
          onChanged: (String value) {
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
        GCWTextDivider(
          text: i18n(context, 'settings_chatgpt_title'),
        ),
        GCWTextField(
          controller: _chatGPTAPIKeyController,
          onChanged: (text) {
            setState(() {
              _chatgpt_api_key = text;
              Prefs.setString(PREFERENCE_CHATGPT_API_KEY, _chatgpt_api_key);
            });
          },
        ),
      ],
    );
  }
}
