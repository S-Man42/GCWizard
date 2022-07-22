import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/vigenere/widget/vigenere.dart';

class VigenereRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'vigenere';

  @override
  List<String> searchKeys = [
    'vigenere',
    'rotation',
  ];

  @override
  Widget tool = Vigenere();
}