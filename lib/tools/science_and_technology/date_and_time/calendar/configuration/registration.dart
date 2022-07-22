import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/calendar/widget/calendar.dart';

class CalendarRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'dates_calendar';

  @override
  List<String> searchKeys = [
    'dates',
    'dates_calendar',
  ];

  @override
  Widget tool = Calendar();
}