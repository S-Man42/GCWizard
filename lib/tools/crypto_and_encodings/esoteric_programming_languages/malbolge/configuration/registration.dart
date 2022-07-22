import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/esoteric_programming_languages/malbolge/widget/malbolge.dart';

class MalbolgeRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'malbolge';

  @override
  List<String> searchKeys = [
    'esotericprogramminglanguage',
    'esoteric_malbolge',
  ];

  @override
  Widget tool = Malbolge();
}