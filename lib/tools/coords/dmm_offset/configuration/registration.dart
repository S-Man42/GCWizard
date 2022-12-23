import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/dmm_offset/widget/dmm_offset.dart';

class DMMOffsetRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_dmmoffset';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_mapview',
  ];

  @override
  Widget tool = DMMOffset();
}