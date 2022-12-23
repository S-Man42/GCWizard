import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/resistor/resistor_colorcodecalculator/widget/resistor_colorcodecalculator.dart';

class ResistorColorCodeCalculatorRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'resistor_colorcodecalculator';

  @override
  List<String> searchKeys = [
    'resistor',
    'color',
    'resistor_colorcode',
  ];

  @override
  Widget tool = ResistorColorCodeCalculator();
}