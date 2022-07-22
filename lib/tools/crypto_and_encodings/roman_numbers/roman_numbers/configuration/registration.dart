import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/roman_numbers/roman_numbers/widget/roman_numbers.dart';

class RomanNumbersRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'romannumbers';

  @override
  List<String> searchKeys = [
    'roman_numbers',
  ];

  @override
  Widget tool = RomanNumbers();
}