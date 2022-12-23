import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/teletypewriter/punchtape/widget/punchtape.dart';

class TeletypewriterPunchTapeRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'punchtape';

  @override
  List<String> searchKeys = [
    'ccitt',
    'ccitt_1',
    'ccitt_2',
    'ccitt_3',
    'ccitt_4',
    'ccitt_5',
    'punchtape',
    'teletypewriter',
    'symbol_siemens',
    'symbol_westernunion',
    'symbol_murraybaudot',
    'symbol_baudot'
  ];

  @override
  Widget tool = TeletypewriterPunchTape();
}