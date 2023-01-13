import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_tool/gcw_tool.dart';
import 'package:gc_wizard/tools/symbol_tables/logic/symbol_table_data.dart';
import 'package:gc_wizard/tools/symbol_tables/widget/symbol_table.dart';

class GCWSymbolTableTool extends GCWTool {
  final String symbolKey;
  final List<String> symbolSearchStrings;

  GCWSymbolTableTool({
    Key key,
    this.symbolKey,
    this.symbolSearchStrings,
  }) : super(
            key: key,
            tool: SymbolTable(symbolKey: symbolKey),
            i18nPrefix: 'symboltables_' + symbolKey,
            autoScroll: false,
            iconPath: SYMBOLTABLES_ASSETPATH + symbolKey + '/logo.png',
            helpSearchString: 'symboltables_selection_title',
            searchKeys: ['symbol'] + (symbolSearchStrings == null ? [] : symbolSearchStrings));
}
