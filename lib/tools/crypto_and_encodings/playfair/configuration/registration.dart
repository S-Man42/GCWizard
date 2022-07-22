import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/playfair/widget/playfair.dart';

class PlayfairRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'playfair';

  @override
  List<String> searchKeys = [
    'playfair',
  ];

  @override
  Widget tool = Playfair();
}