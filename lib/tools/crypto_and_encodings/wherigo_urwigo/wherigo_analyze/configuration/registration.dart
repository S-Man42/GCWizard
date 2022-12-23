import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/wherigo_analyze/widget/wherigo_analyze.dart';

class WherigoAnalyzeRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.IMAGES_AND_FILES,
    ToolCategory.GENERAL_CODEBREAKERS = [
    ToolCategory.IMAGES_AND_FILES,
    ToolCategory.GENERAL_CODEBREAKERS
  ];

  @override
  String i18nPrefix = 'wherigo';

  @override
  List<String> searchKeys = [
    'wherigo',
    'wherigourwigo',
  ];

  @override
  Widget tool = WherigoAnalyze();
}