import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/ccitt.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/telegraphs/punchtape.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CCITTSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      if (className(element.tool) == className(SymbolTable()) )
          if ((element.tool as SymbolTable).symbolKey == 'baudot_1888' ||
              (element.tool as SymbolTable).symbolKey == 'baudot_54123' ||
              (element.tool as SymbolTable).symbolKey == 'murraybaudot' ||
              (element.tool as SymbolTable).symbolKey == 'siemens' ||
              (element.tool as SymbolTable).symbolKey == 'westernunion' ||
              (element.tool as SymbolTable).symbolKey == 'ita1_1926' ||
              (element.tool as SymbolTable).symbolKey == 'ita1_1929' ||
              (element.tool as SymbolTable).symbolKey == 'ita2_1929' ||
              (element.tool as SymbolTable).symbolKey == 'ita3_1931')
        return true;

      return [
        className(CCITT()),
        className(CCITTPunchTape()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
