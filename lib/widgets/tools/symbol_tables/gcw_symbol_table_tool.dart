import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_common.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_de.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_en.dart';
import 'package:gc_wizard/widgets/searchstrings/searchstrings_fr.dart';

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
            iconPath: SYMBOLTABLES_ASSETPATH + symbolKey + '/logo.png',
            searchStrings: [
                  SEARCHSTRING_COMMON_SYMBOL,
                  SEARCHSTRING_DE_SYMBOL,
                  SEARCHSTRING_EN_SYMBOL,
                  SEARCHSTRING_FR_SYMBOL
                ] +
                symbolSearchStrings);
}
