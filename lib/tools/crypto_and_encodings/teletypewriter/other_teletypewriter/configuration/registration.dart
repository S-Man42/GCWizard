import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/other_teletypewriter/widget/other_teletypewriter.dart';

class OtherTeletypewriterRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'ccitt_other';

  @override
  List<String> searchKeys = [
    'teletypewriter', 'z22', 'zc1', 'illiac', 'algol', 'tts'
  ];

  @override
  Widget tool = OtherTeletypewriter();
}