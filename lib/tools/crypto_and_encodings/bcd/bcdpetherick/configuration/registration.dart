import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdpetherick/widget/bcdpetherick.dart';

class BCDPetherickRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_petherick';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcdpetherick',
  ];

  @override
  Widget tool = BCDPetherick();
}