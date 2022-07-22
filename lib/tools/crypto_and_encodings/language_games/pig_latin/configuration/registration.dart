import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/language_games/pig_latin/widget/pig_latin.dart';

class PigLatinRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'piglatin';

  @override
  List<String> searchKeys = [
    'languagegames',
    'languagegames_piglatin',
  ];

  @override
  Widget tool = PigLatin();
}