import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot123/widget/rot123.dart';

class Rot123Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'rotation_rot123';

  @override
  List<String> searchKeys = [
    'rotation',
    'rotation_rot123',
  ];

  @override
  Widget tool = Rot123();
}