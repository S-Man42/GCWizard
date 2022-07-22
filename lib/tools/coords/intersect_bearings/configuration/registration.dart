import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/intersect_bearings/widget/intersect_bearings.dart';

class IntersectBearingsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_intersectbearings';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_compassrose',
        'coordinates_intersectbearing',
  ];

  @override
  Widget tool = IntersectBearings();
}