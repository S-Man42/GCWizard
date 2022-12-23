import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt1/widget/ccitt1.dart';

class CCITT1Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'ccitt_1';

  @override
  List<String> searchKeys = [
    'ccitt', 'ccitt_1', 'symbol_baudot'
  ];

  @override
  Widget tool = CCITT1();
}