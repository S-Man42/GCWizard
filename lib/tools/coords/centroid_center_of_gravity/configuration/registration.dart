import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/centroid_center_of_gravity/widget/centroid_center_of_gravity.dart';

class CentroidCenterOfGravityRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_centroid_centerofgravity';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_centroid',
        'coordinates_centerofgravity',
  ];

  @override
  Widget tool = CentroidCenterOfGravity();
}