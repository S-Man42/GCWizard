import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enclosed_areas/widget/enclosed_areas.dart';

class EnclosedAreasRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'enclosedareas';

  @override
  List<String> searchKeys = [
    'enclosedareas',
  ];

  @override
  Widget tool = EnclosedAreas();
}