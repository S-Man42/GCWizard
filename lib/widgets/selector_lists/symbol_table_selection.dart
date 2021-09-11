import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class SymbolTableSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    List<GCWTool> _toolList = Registry.toolList.where((element) {
      return [
        className(SymbolTable()),
      ].contains(className(element.tool));
    }).toList();

    _toolList.sort((a, b) => sortToolListAlphabetically(a, b));

    return Container(child: GCWToolList(toolList: _toolList));
  }
}

String symboltablesDownloadLink(BuildContext context) {
  final _SUPPORTED_LANGUAGES = ['de', 'en', 'fr', 'ko'];
  var locale = Localizations.localeOf(context).languageCode;

  var usedLocale = 'en';
  if (_SUPPORTED_LANGUAGES.contains(locale))
    usedLocale = locale;

  return 'https://misc.gcwizard.net/symboltables_$usedLocale.pdf';
}
