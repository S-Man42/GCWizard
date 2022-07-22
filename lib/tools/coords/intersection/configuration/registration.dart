import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/intersection/widget/intersection.dart';

class IntersectionRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_intersection';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_intersection',
  ];

  @override
  Widget tool = Intersection();
}