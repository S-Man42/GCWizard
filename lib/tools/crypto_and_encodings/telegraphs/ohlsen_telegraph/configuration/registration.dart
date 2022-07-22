import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/ohlsen_telegraph/widget/ohlsen_telegraph.dart';

class OhlsenTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_ohlsen';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_ohlsen',
  ];

  @override
  Widget tool = OhlsenTelegraph();
}