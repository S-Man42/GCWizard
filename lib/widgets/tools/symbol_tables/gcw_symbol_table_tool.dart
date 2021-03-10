import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';

class GCWSymbolTableTool extends GCWTool {
  final String symbolKey;
  final String searchStrings;

  GCWSymbolTableTool({
    Key key,
    this.symbolKey,
    this.searchStrings: '',
  }) : super(
    key: key,
    tool: SymbolTable(symbolKey: symbolKey),
    i18nPrefix: 'symboltables_' + symbolKey,
    iconPath: SYMBOLTABLES_ASSETPATH + symbolKey + '/logo.png',
    searchStrings: searchStrings
  );
}
