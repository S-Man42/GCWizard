import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/ook/widget/ook.dart';

class OokRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'ook';

  @override
  List<String> searchKeys = [
    'esotericprogramminglanguage',
    'esoteric_brainfk',
    'esoteric_ook',
  ];

  @override
  Widget tool = Ook();
}