import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_temperature/widget/wet_bulb_temperature.dart';

class WetBulbTemperatureRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'wet_bulb_temperature';

  @override
  List<String> searchKeys = [
    'apparenttemperature',
    'apparenttemperature_wet_bulb_temperature',
  ];

  @override
  Widget tool = WetBulbTemperature();
}