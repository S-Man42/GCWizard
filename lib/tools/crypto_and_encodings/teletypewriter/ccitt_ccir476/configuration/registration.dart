import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt_ccir476/widget/ccitt_ccir476.dart';

class CCIR476Registration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'ccitt_ccir476';

  @override
  List<String> searchKeys = [
    'ccitt',
    'ccitt_ccir_476',
    'teletypewriter',
  ];

  @override
  Widget tool = CCIR476();
}