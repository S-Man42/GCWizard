import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/bcd/bcdgray/widget/bcdgray.dart';

class BCDGrayRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'bcd_gray';

  @override
  List<String> searchKeys = [
    'bcd',
    'bcdgray',
  ];

  @override
  Widget tool = BCDGray();
}