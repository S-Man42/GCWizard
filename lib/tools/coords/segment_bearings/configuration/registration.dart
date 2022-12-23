import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/segment_bearings/widget/segment_bearings.dart';

class SegmentBearingsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_segmentbearings';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_segmentbearing',
  ];

  @override
  Widget tool = SegmentBearings();
}