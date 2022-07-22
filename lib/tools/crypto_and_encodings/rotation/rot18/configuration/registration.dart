import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rotation/rot18/widget/rot18.dart';

class Rot18Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'rotation_rot18';

  @override
  List<String> searchKeys = [
    'rotation',
    'rotation_rot18',
  ];

  @override
  Widget tool = Rot18();
}