import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/straddling_checkerboard/widget/straddling_checkerboard.dart';

class StraddlingCheckerboardRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'straddlingcheckerboard';

  @override
  List<String> searchKeys = [
    'straddlingcheckerboard',
  ];

  @override
  Widget tool = StraddlingCheckerboard();
}