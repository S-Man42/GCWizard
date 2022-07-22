import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/beghilos/widget/beghilos.dart';

class BeghilosRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.CRYPTOGRAPHY = [
    ToolCategory.CRYPTOGRAPHY
  ];

  @override
  String i18nPrefix = 'beghilos';

  @override
  List<String> searchKeys = [
    'beghilos',
    'segments',
    'segements_seven',
  ];

  @override
  Widget tool = Beghilos();
}