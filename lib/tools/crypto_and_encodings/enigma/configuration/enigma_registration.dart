import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/configuration/reflectors/gcw_tool_reflector.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/enigma/widget/enigma.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';

class EnigmaRegistration implements AbstractToolRegistration {
  @override
  List<ToolCategory> categories = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'enigma';

  @override
  List<String> searchKeys = [
    'enigma',
  ];

  @override
  Widget tool = Enigma();
}