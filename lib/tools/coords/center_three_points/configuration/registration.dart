import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/center_three_points/widget/center_three_points.dart';

class CenterThreePointsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_centerthreepoints';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_centerthreepoints',
  ];

  @override
  Widget tool = CenterThreePoints();
}