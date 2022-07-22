import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/vanity_words_list/widget/vanity_words_list.dart';

class VanityWordsListRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'vanity_words_list';

  @override
  List<String> searchKeys = [
    'vanity',
    'vanitywordslist',
  ];

  @override
  Widget tool = VanityWordsList();
}