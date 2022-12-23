import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/keyboard_layout/widget/keyboard_layout.dart';

class KeyboardLayoutRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'keyboard_layout';

  @override
  List<String> searchKeys = [
    'keyboard',
  ];

  @override
  Widget tool = KeyboardLayout();
}