import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdhamming/widget/bcdhamming.dart';

class BCDHammingRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_hamming';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcdhamming',
  ];

  @override
  Widget tool = BCDHamming();
}