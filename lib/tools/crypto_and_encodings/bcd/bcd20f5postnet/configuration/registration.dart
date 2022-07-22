import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcd20f5postnet/widget/bcd20f5postnet.dart';

class BCD2of5PostnetRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_2of5postnet';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcd2of5',
    'bcd2of5postnet',
  ];

  @override
  Widget tool = BCD2of5Postnet();
}