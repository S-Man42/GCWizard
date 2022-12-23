import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdbiquinary/widget/bcdbiquinary.dart';

class BCDBiquinaryRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_biquinary';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcd2of5',
    'bcdbiquinary',
  ];

  @override
  Widget tool = BCDBiquinary();
}