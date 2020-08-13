import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/AppBuilder.dart';
import 'package:prefs/prefs.dart';

class GeneralSettings extends StatefulWidget {
  @override
  GeneralSettingsState createState() => GeneralSettingsState();
}

class GeneralSettingsState extends State<GeneralSettings> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'settings_general_text')
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_text_size'),
          value: Prefs.getDouble('font_size').floor(),
          min: 10,
          max: 30,
          onChanged: (value) {
            setState(() {
              Prefs.setDouble('font_size', value.toDouble());

              // source: https://hillel.dev/2018/08/15/flutter-how-to-rebuild-the-entire-app-to-change-the-theme-or-locale/
              AppBuilder.of(context).rebuild();
            });
          },
        ),

        GCWTextDivider(
          text: i18n(context, 'settings_general_toollist')
        ),
        GCWOnOffSwitch(
          value: Prefs.getBool('toollist_show_descriptions'),
          title: i18n(context, 'settings_general_toollist_showdescriptions'),
          onChanged: (value) {
            Prefs.setBool('toollist_show_descriptions', value);
            AppBuilder.of(context).rebuild();
          },
        ),
        GCWOnOffSwitch(
          value: Prefs.getBool('toollist_show_examples'),
          title: i18n(context, 'settings_general_toollist_showexamples'),
          onChanged: (value) {
            Prefs.setBool('toollist_show_examples', value);
            AppBuilder.of(context).rebuild();
          },
        ),

        GCWTextDivider(
          text: i18n(context, 'settings_general_defaulttab')
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'settings_general_defaulttab_atstart'),
          value: Prefs.getBool('tabs_use_default_tab') ? GCWSwitchPosition.right : GCWSwitchPosition.left,
          leftValue: i18n(context, 'settings_general_defaulttab_uselasttab'),
          rightValue: i18n(context, 'settings_general_defaulttab_usedefaulttab'),
          onChanged: (value) {
            setState(() {
              Prefs.setBool('tabs_use_default_tab', value == GCWSwitchPosition.right);
            });
          },
        ),
        Prefs.getBool('tabs_use_default_tab')
          ? GCWDropDownButton(
              value: Prefs.get('tabs_default_tab'),
              items: [
                  {'index': 0, 'text': i18n(context, 'common_tabs_categories')},
                  {'index': 1, 'text': i18n(context, 'common_tabs_all')},
                  {'index': 2, 'text': i18n(context, 'common_tabs_favorites')}
                ].map((item) {
                  return DropdownMenuItem(
                    value: item['index'],
                    child: Text(item['text']),
                  );
                }).toList(),
              onChanged: (value) {
                setState(() {
                  Prefs.setInt('tabs_default_tab', value);
                });
              },
            )
          : Container(),
        GCWTextDivider(
          text: i18n(context, 'settings_general_clipboard')
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_clipboard_maxitems'),
          value: Prefs.getInt('clipboard_max_items'),
          min: 1,
          max: 100,
          onChanged: (value) {
            setState(() {
              Prefs.setInt('clipboard_max_items', value);
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_clipboard_keep.entries.in.days'),
          value: Prefs.getInt('clipboard_keep_entries_in_days'),
          min: 1,
          max: 1000,
          onChanged: (value) {
            setState(() {
              Prefs.setInt('clipboard_keep_entries_in_days', value);
            });
          },
        )
      ],
    );
  }
}