import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/vigenere_breaker/widget/vigenere_breaker.dart';

class VigenereBreakerRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GENERAL_CODEBREAKERS = [
    ToolCategory.GENERAL_CODEBREAKERS
  ];

  @override
  String i18nPrefix = 'vigenerebreaker';

  @override
  List<String> searchKeys = [
    'codebreaker',
    'vigenerebreaker',
    'vigenere',
    'rotation',
  ];

  @override
  Widget tool = VigenereBreaker();
}