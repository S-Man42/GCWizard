import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/moon_rise_set/widget/moon_rise_set.dart';

class MoonRiseSetRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'astronomy_moonriseset';

  @override
  List<String> searchKeys = [
    'astronomy',
    'astronomy_riseset',
    'astronomy_moon',
  ];

  @override
  Widget tool = MoonRiseSet();
}