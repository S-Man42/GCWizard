import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/day_of_the_year/widget/day_of_the_year.dart';

class DayOfTheYearRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'dates_day_of_the_year';

  @override
  List<String> searchKeys = [
    'dates',
    'dates_day_of_the_year',
  ];

  @override
  Widget tool = DayOfTheYear();
}