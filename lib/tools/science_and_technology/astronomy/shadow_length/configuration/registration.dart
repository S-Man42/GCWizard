import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/shadow_length/widget/shadow_length.dart';

class ShadowLengthRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'shadowlength';

  @override
  List<String> searchKeys = [
    'astronomy',
    'astronomy_shadow_length',
  ];

  @override
  Widget tool = ShadowLength();
}