import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/maya_calendar.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class MayaCalendarSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = Registry.toolList.where((element) {
      if (className(element.tool) == className(SymbolTable()) &&
          (element.tool as SymbolTable).symbolKey == 'maya_calendar_haab_codices') return true;
      if (className(element.tool) == className(SymbolTable()) &&
          (element.tool as SymbolTable).symbolKey == 'maya_calendar_haab_inscripts') return true;
      if (className(element.tool) == className(SymbolTable()) &&
          (element.tool as SymbolTable).symbolKey == 'maya_calendar_tzolkin_codices') return true;
      if (className(element.tool) == className(SymbolTable()) &&
          (element.tool as SymbolTable).symbolKey == 'maya_calendar_tzolkin_inscripts') return true;

      return [
        className(MayaCalendar()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
