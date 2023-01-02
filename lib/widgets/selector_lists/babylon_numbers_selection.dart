import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist/widget/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/babylon_numbers/widget/babylon_numbers.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_table/widget/symbol_table.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

class BabylonNumbersSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      if (className(element.tool) == className(SymbolTable()) &&
          (element.tool as SymbolTable).symbolKey == 'babylonian_numerals') return true;

      return [
        className(BabylonNumbers()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
