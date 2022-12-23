import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ccitt_teletypewriter/widget/ccitt_teletypewriter.dart';

class CCITTTeletypewriterRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'ccitt';

  @override
  List<String> searchKeys = [
    'ccitt',
    'ccitt_1',
    'ccitt_2',
    'ccitt_3',
    'ccitt_4',
    'ccitt_5',
    'ccitt_ccir_476',
    'teletypewriter',
    'symbol_baudot'
        'symbol_murraybaudot',
  ];

  @override
  Widget tool = CCITTTeletypewriter();
}