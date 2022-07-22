import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/date_and_time/time_calculator/widget/time_calculator.dart';

class TimeCalculatorRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'dates_timecalculator';

  @override
  List<String> searchKeys = [
    'dates',
    'dates_timecalculator',
  ];

  @override
  Widget tool = TimeCalculator();
}