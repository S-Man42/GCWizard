import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/solitaire/widget/solitaire.dart';

class SolitaireRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'solitaire';

  @override
  List<String> searchKeys = [
    'solitaire',
  ];

  @override
  Widget tool = Solitaire();
}