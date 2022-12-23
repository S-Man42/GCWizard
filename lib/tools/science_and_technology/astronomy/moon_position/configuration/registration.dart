import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/moon_position/widget/moon_position.dart';

class MoonPositionRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'astronomy_moonposition';

  @override
  List<String> searchKeys = [
    'astronomy',
    'astronomy_position',
    'astronomy_moon',
    'astronomy_moonposition',
  ];

  @override
  Widget tool = MoonPosition();
}