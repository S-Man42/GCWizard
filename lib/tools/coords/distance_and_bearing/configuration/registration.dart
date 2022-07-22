import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/distance_and_bearing/widget/distance_and_bearing.dart';

class DistanceBearingRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_distancebearing';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_distancebearing',
  ];

  @override
  Widget tool = DistanceBearing();
}