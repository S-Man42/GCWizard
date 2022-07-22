import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/charsets/ascii_values/widget/ascii_values.dart';

class ASCIIValuesRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'asciivalues';

  @override
  List<String> searchKeys = [
    'asciivalues',
    'binary',
  ];

  @override
  Widget tool = ASCIIValues();
}