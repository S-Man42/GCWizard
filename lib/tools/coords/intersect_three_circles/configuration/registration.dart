import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/intersect_three_circles/widget/intersect_three_circles.dart';

class IntersectThreeCirclesRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_intersectthreecircles';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_intersectthreecircles',
  ];

  @override
  Widget tool = IntersectThreeCircles();
}