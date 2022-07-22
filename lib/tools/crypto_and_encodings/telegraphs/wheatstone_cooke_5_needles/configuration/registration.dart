import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/telegraphs/wheatstone_cooke_5_needles/widget/wheatstone_cooke_5_needles.dart';

class WheatstoneCookeNeedleTelegraphRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'telegraph_wheatstonecooke_needle';

  @override
  List<String> searchKeys = [
    'telegraph',
    'telegraph_wheatstonecooke_needle',
  ];

  @override
  Widget tool = WheatstoneCookeNeedleTelegraph();
}