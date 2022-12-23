import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/heat_index/widget/heat_index.dart';

class HeatIndexRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'heatindex';

  @override
  List<String> searchKeys = [
    'apparenttemperature',
    'apparenttemperature_heatindex',
  ];

  @override
  Widget tool = HeatIndex();
}