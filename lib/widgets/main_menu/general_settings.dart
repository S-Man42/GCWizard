import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
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
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'settings_general_symboltables')
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_portrait'),
          value: Prefs.getInt('symbol_tables_countcolumns_portrait'),
          min: 2,
          max: 15,
          onChanged: (value) {
            setState(() {
              Prefs.setInt('symbol_tables_countcolumns_portrait', value);
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'common_landscape'),
          value: Prefs.getInt('symbol_tables_countcolumns_landscape'),
          min: 2,
          max: 30,
          onChanged: (value) {
            setState(() {
              Prefs.setInt('symbol_tables_countcolumns_landscape', value);
            });
          },
        )
      ],
    );
  }
}