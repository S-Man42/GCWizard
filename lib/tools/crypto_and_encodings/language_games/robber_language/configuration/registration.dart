import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/robber_language/widget/robber_language.dart';

class RobberLanguageRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'robberlanguage';

  @override
  List<String> searchKeys = [
    'languagegames',
    'languagegames_robberlanguage',
  ];

  @override
  Widget tool = RobberLanguage();
}