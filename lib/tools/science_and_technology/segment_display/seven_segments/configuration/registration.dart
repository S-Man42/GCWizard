import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/seven_segments/widget/seven_segments.dart';

class SevenSegmentsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'segmentdisplay_7segments';

  @override
  List<String> searchKeys = [
    'segments',
        'segments_seven',
  ];

  @override
  Widget tool = SevenSegments();
}