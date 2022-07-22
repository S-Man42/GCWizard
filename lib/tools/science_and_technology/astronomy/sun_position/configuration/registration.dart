import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/sun_position/widget/sun_position.dart';

class SunPositionRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'astronomy_sunposition';

  @override
  List<String> searchKeys = [
    'astronomy',
    'astronomy_position',
    'astronomy_sun',
  ];

  @override
  Widget tool = SunPosition();
}