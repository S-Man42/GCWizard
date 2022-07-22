import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/astronomy/easter/easter_date/widget/easter_date.dart';

class EasterDateRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'astronomy_easter_easterdate';

  @override
  List<String> searchKeys = [
    'easter_date',
  ];

  @override
  Widget tool = EasterDate();
}