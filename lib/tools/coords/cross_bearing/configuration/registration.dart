import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/cross_bearing/widget/cross_bearing.dart';

class CrossBearingRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_crossbearing';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_crossbearing',
  ];

  @override
  Widget tool = CrossBearing();
}