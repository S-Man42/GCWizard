import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity_singletap/widget/vanity_singletap.dart';

class VanitySingletapRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'vanity_singletap';

  @override
  List<String> searchKeys = [
    'vanity',
    'vanitysingletap',
  ];

  @override
  Widget tool = VanitySingletap();
}