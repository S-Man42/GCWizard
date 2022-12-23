import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_rise_set/widget/sun_rise_set.dart';

class SunRiseSetRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'astronomy_sunriseset';

  @override
  List<String> searchKeys = [
    'astronomy',
    'astronomy_riseset',
    'astronomy_sun',
    'astronomy_sunriseset',
  ];

  @override
  Widget tool = SunRiseSet();
}