import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/summer_simmer/widget/summer_simmer.dart';

class SummerSimmerIndexRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'summersimmerindex';

  @override
  List<String> searchKeys = [
    'apparenttemperature',
    'apparenttemperature_summersimmerindex',
  ];

  @override
  Widget tool = SummerSimmerIndex();
}