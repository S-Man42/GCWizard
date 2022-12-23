import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/chicken_language/widget/chicken_language.dart';

class ChickenLanguageRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'chickenlanguage';

  @override
  List<String> searchKeys = [
    'languagegames',
    'languagegames_chickenlanguage',
  ];

  @override
  Widget tool = ChickenLanguage();
}