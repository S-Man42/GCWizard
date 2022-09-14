import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/maya_calendar_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/calendar.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/day_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/day_of_the_year.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/time_calculator.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/date_and_time/weekday.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class DatesSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(DayCalculator()),
        className(TimeCalculator()),
        className(Weekday()),
        className(DayOfTheYear()),
        className(Calendar()),
        className(MayaCalendarSelection()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
