import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_divider.dart';
import 'package:gc_wizard/tools/miscellaneous/gcwizardscript/logic/gcwizard_script.dart';
import 'package:gc_wizard/utils/ui_dependent_utils/common_widget_utils.dart';

class GCWizardScriptHelp extends StatefulWidget {
  const GCWizardScriptHelp({Key? key}) : super(key: key);

  @override
  _GCWizardScriptHelpState createState() => _GCWizardScriptHelpState();
}

class _GCWizardScriptHelpState extends State<GCWizardScriptHelp> {

  @override
  void initState() {
    super.initState();
  }

  Container _buildUrl(int key) {
    return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: InkWell(
                child: Text(
                  i18n(context, GCW_SKRIPT_HELP_URLS[key]![0]),
                  style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                ),
                onTap: () {
                  launchUrl(Uri.parse(GCW_SKRIPT_HELP_URLS[key]![1]));
                },
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    var content = Column(
      children: <Widget>[
        _buildUrl(GCW_SKRIPT_HELP_EXAMPLES),
        GCWDivider(),
        _buildUrl(GCW_SKRIPT_HELP_VARIABLE),
        _buildUrl(GCW_SKRIPT_HELP_DATATYPES),
        _buildUrl(GCW_SKRIPT_HELP_OPERATORS),
        _buildUrl(GCW_SKRIPT_HELP_COMMANDS),
        _buildUrl(GCW_SKRIPT_HELP_CONTROLS),
        _buildUrl(GCW_SKRIPT_HELP_MATH),
        _buildUrl(GCW_SKRIPT_HELP_STRINGS),
        _buildUrl(GCW_SKRIPT_HELP_LISTS),
        _buildUrl(GCW_SKRIPT_HELP_FILES),
        _buildUrl(GCW_SKRIPT_HELP_DATE),
        _buildUrl(GCW_SKRIPT_HELP_GRAPHIC),
        _buildUrl(GCW_SKRIPT_HELP_WPTS),
        _buildUrl(GCW_SKRIPT_HELP_COORD),
      ],
    );

    return content;
    //return MainMenuEntryStub(content: content);
  }
}
