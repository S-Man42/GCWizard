import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum/widget/cross_sum.dart';

class CrossSumRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'crosssum_crosssum';

  @override
  List<String> searchKeys = [
    'crosssums',
  ];

  @override
  Widget tool = CrossSum();
}