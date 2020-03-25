import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
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
        Row(
          children: <Widget>[
            Expanded(
              child: GCWText(
                text: i18n(context, 'settings_general_text_size'),
              ),
              flex: 1
            ),
            Expanded(
              child: GCWIntegerSpinner(
                value: Prefs.getDouble('font_size').floor(),
                min: FONT_SIZE_MIN,
                max: FONT_SIZE_MAX,
                onChanged: (value) {
                  setState(() {
                    Prefs.setDouble('font_size', value.toDouble());
                  });
                },
              ),
              flex: 4
            )
          ],
        )
      ],
    );
  }
}