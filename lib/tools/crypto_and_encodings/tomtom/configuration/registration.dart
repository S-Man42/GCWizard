import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/tomtom/widget/tomtom.dart';

class TomTomRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'tomtom';

  @override
  List<String> searchKeys = [
    'tomtom',
  ];

  @override
  Widget tool = TomTom();
}