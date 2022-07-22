import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot5/widget/rot5.dart';

class Rot5Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'rotation_rot5';

  @override
  List<String> searchKeys = [
    'rotation',
    'rotation_rot5',
  ];

  @override
  Widget tool = Rot5();
}