import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/intersect_four_points/widget/intersect_four_points.dart';

class IntersectFourPointsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_intersectfourpoints';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_intersectfourpoints',
  ];

  @override
  Widget tool = IntersectFourPoints();
}