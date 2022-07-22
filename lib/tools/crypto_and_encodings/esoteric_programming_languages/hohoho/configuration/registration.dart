import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/hohoho/widget/hohoho.dart';

class HohohoRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'hohoho';

  @override
  List<String> searchKeys = [
    'esotericprogramminglanguage', 'esoteric_hohoho', 'christmas'
  ];

  @override
  Widget tool = Hohoho();
}