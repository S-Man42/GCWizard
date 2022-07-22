import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdgrayexcess/widget/bcdgrayexcess.dart';

class BCDGrayExcessRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_grayexcess';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcdgrayexcess',
  ];

  @override
  Widget tool = BCDGrayExcess();
}