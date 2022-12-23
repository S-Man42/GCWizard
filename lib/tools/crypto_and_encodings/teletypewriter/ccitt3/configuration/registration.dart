import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt3/widget/ccitt3.dart';

class CCITT3Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'ccitt_3';

  @override
  List<String> searchKeys = [
    'ccitt',
    'ccitt_3',
    'teletypewriter',
  ];

  @override
  Widget tool = CCITT3();
}