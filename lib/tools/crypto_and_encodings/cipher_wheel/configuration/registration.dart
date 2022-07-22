import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/cipher_wheel/widget/cipher_wheel.dart';

class CipherWheelRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'cipherwheel';

  @override
  List<String> searchKeys = [
    'cipherwheel',
  ];

  @override
  Widget tool = CipherWheel();
}