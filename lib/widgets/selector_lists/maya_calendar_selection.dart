import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_tool/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist/gcw_toollist.dart';
import 'package:gc_wizard/tools/science_and_technology/maya_calendar/widget/maya_calendar.dart';
import 'package:gc_wizard/tools/symbol_tables/widget/symbol_table.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';

class MayaCalendarSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      if (className(element.tool) == className(SymbolTable()) &&
          (element.tool as SymbolTable).symbolKey == 'maya_calendar_longcount') return true;
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
