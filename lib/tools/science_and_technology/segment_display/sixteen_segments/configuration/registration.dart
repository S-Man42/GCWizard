import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/sixteen_segments/widget/sixteen_segments.dart';

class SixteenSegmentsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'segmentdisplay_16segments';

  @override
  List<String> searchKeys = [
    'segments',
        'segments_sixteen',
  ];

  @override
  Widget tool = SixteenSegments();
}