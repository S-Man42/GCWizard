import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/beatnik_language/widget/beatnik_language.dart';

class BeatnikRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'beatnik';

  @override
  List<String> searchKeys = [
    'esotericprogramminglanguage',
    'esoteric_beatnik',
  ];

  @override
  Widget tool = Beatnik();
}