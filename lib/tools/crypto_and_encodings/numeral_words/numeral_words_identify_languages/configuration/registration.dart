import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_identify_languages/widget/numeral_words_identify_languages.dart';

class NumeralWordsIdentifyLanguagesRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'numeralwords_identify_languages';

  @override
  List<String> searchKeys = [
    'numeralwords',
    'numeralwords_identifylanguages',
  ];

  @override
  Widget tool = NumeralWordsIdentifyLanguages();
}