import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdstibitz/widget/bcdstibitz.dart';

class BCDStibitzRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_stibitz';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcdstibitz',
  ];

  @override
  Widget tool = BCDStibitz();
}