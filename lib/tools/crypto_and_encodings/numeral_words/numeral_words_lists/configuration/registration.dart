import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/numeral_words/numeral_words_lists/widget/numeral_words_lists.dart';

class NumeralWordsListsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'numeralwords_lists';

  @override
  List<String> searchKeys = [
    'numeralwords',
    'numeralwords_lang',
    'numeralwordslists',
  ];

  @override
  Widget tool = NumeralWordsLists();
}