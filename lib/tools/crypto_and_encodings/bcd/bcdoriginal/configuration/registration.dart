import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdoriginal/widget/bcdoriginal.dart';

class BCDOriginalRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_original';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcdoriginal',
  ];

  @override
  Widget tool = BCDOriginal();
}