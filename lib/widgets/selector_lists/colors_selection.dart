import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/color_tool.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/pantone_color_codes.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/colors/ral_color_codes.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class ColorsSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      if (className(element.tool) == className(SymbolTable()) &&
          (element.tool as SymbolTable).symbolKey.startsWith('color_code')) return true;

      return [className(ColorTool()), className(PantoneColorCodes()), className(RALColorCodes())]
          .contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
