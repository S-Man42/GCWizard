import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt2/widget/ccitt2.dart';

class CCITT2Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'ccitt_2';

  @override
  List<String> searchKeys = [
    'ccitt',
    'ccitt_2',
    'teletypewriter',
    'symbol_murraybaudot',
  ];

  @override
  Widget tool = CCITT2();
}