import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/center_two_points/widget/center_two_points.dart';

class CenterTwoPointsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_centertwopoints';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_centertwopoints',
  ];

  @override
  Widget tool = CenterTwoPoints();
}