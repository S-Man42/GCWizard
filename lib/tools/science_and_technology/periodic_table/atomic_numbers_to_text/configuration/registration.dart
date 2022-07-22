import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/periodic_table/atomic_numbers_to_text/widget/atomic_numbers_to_text.dart';

class AtomicNumbersToTextRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'atomicnumberstotext';

  @override
  List<String> searchKeys = [
    'periodictable_atomicnumbers',
  ];

  @override
  Widget tool = AtomicNumbersToText();
}