import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/weather_symbols/widget/weather_symbols.dart';

class WeatherSymbolsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.SCIENCE_AND_TECHNOLOGY = [
    ToolCategory.SCIENCE_AND_TECHNOLOGY
  ];

  @override
  String i18nPrefix = 'weathersymbols';

  @override
  List<String> searchKeys = [
    'weather', 'weather_clouds', 'weather_a'
  ];

  @override
  Widget tool = WeatherSymbols();
}