import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/ancient_teletypewriter/widget/ancient_teletypewriter.dart';

class AncientTeletypewriterRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'ccitt_ancient';

  @override
  List<String> searchKeys = [
    'ccitt',
    'ccitt_ancient',
    'teletypewriter',
    'symbol_siemens',
    'symbol_westernunion',
    'symbol_murraybaudot',
    'symbol_baudot'
  ];

  @override
  Widget tool = AncientTeletypewriter();
}