import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/waypoint_projection/widget/waypoint_projection.dart';

class WaypointProjectionRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_waypointprojection';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_compassrose',
        'coordinates_waypointprojection',
  ];

  @override
  Widget tool = WaypointProjection();
}