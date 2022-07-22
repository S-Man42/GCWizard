import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/whitespace_language/widget/whitespace_language.dart';

class WhitespaceLanguageRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'whitespace_language';

  @override
  List<String> searchKeys = [
    'esotericprogramminglanguage',
    'esoteric_whitespacelanguage',
  ];

  @override
  Widget tool = WhitespaceLanguage();
}