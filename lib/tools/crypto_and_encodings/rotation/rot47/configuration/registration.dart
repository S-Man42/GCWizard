import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot47/widget/rot47.dart';

class Rot47Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'rotation_rot47';

  @override
  List<String> searchKeys = [
    'rotation',
    'rotation_rot47',
  ];

  @override
  Widget tool = Rot47();
}