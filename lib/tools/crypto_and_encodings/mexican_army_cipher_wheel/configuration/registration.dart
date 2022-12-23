import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/mexican_army_cipher_wheel/widget/mexican_army_cipher_wheel.dart';

class MexicanArmyCipherWheelRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'mexicanarmycipherwheel';

  @override
  List<String> searchKeys = [
    'cipherwheel',
    'mexicanarmycipherwheel',
  ];

  @override
  Widget tool = MexicanArmyCipherWheel();
}