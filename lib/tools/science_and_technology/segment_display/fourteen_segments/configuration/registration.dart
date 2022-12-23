import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/segment_display/fourteen_segments/widget/fourteen_segments.dart';

class FourteenSegmentsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'segmentdisplay_14segments';

  @override
  List<String> searchKeys = [
    'segments',
        'segments_fourteen',
  ];

  @override
  Widget tool = FourteenSegments();
}