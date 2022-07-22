import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/spoon_language/widget/spoon_language.dart';

class SpoonLanguageRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'spoonlanguage';

  @override
  List<String> searchKeys = [
    'languagegames',
    'languagegames_spoonlanguage',
  ];

  @override
  Widget tool = SpoonLanguage();
}