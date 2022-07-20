import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/common/gcw_toollist/widget/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ancient_teletypewriter/widget/ancient_teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt_teletypewriter/widget/ccitt_teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/other_teletypewriter/widget/other_teletypewriter.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/punchtape/widget/punchtape.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_table/widget/symbol_table.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

class TeletypewriterSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      if (className(element.tool) == className(SymbolTable())) if ((element.tool as SymbolTable).symbolKey ==
              'baudot_1888' ||
          (element.tool as SymbolTable).symbolKey == 'baudot_54123' ||
          (element.tool as SymbolTable).symbolKey == 'murraybaudot' ||
          (element.tool as SymbolTable).symbolKey == 'siemens' ||
          (element.tool as SymbolTable).symbolKey == 'westernunion' ||
          (element.tool as SymbolTable).symbolKey == 'ita1_1926' ||
          (element.tool as SymbolTable).symbolKey == 'ita1_1929' ||
          (element.tool as SymbolTable).symbolKey == 'ita2_1929' ||
          (element.tool as SymbolTable).symbolKey == 'ita3_1931') return true;

      return [
        className(AncientTeletypewriter()),
        className(OtherTeletypewriter()),
        className(CCITTTeletypewriter()),
        className(TeletypewriterPunchTape()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
