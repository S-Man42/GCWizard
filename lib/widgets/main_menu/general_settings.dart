import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
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
          text: i18n(context, 'settings_general_defaulttab')
        ),
        GCWTwoOptionsSwitch(
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
          text: i18n(context, 'settings_general_symboltables')
        ),
        Container(
          child: GCWText(
              text: i18n(context, 'settings_general_symboltables_countcolumns') + ':'
          ),
          padding: EdgeInsets.only(
            top: 10.0,
            bottom: 10.0
          ),
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_portrait'),
          value: Prefs.getInt('symboltables_countcolumns_portrait'),
          min: 2,
          max: 15,
          onChanged: (value) {
            setState(() {
              Prefs.setInt('symboltables_countcolumns_portrait', value);
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_landscape'),
          value: Prefs.getInt('symboltables_countcolumns_landscape'),
          min: 2,
          max: 30,
          onChanged: (value) {
            setState(() {
              Prefs.setInt('symboltables_countcolumns_landscape', value);
            });
          },
        )
      ],
    );
  }
}