import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dialog.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SymbolTableSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    List<GCWTool> _toolList = Registry.toolList.where((element) {
      return [
        className(SymbolTable()),
      ].contains(className(element.tool));
    }).toList();

    _toolList.sort((a, b) {
      return a.toolName.toLowerCase().compareTo(b.toolName.toLowerCase());
    });

    return Container(child: GCWToolList(toolList: _toolList));
  }
}

Widget symboltablesDownloadButton(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.file_download),
    onPressed: () {
      showGCWAlertDialog(
        context,
        i18n(context, 'symboltables_selection_download_dialog_title'),
        i18n(context, 'symboltables_selection_download_dialog_text'),
        () {
          launch(i18n(context, 'symboltables_selection_download_link'));
        },
      );
    },
  );
}
