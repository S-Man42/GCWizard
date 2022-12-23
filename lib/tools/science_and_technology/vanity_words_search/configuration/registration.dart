import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity_words_search/widget/vanity_words_search.dart';

class VanityWordsTextSearchRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'vanity_words_search';

  @override
  List<String> searchKeys = [
    'vanity',
    'vanitytextsearch',
  ];

  @override
  Widget tool = VanityWordsTextSearch();
}