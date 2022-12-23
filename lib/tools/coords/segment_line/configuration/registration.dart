import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/segment_line/widget/segment_line.dart';

class SegmentLineRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_segmentline';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_segmentline',
  ];

  @override
  Widget tool = SegmentLine();
}