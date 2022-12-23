import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/cross_sum_range_frequency/widget/cross_sum_range_frequency.dart';

class CrossSumRangeFrequencyRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'crosssum_range_frequency';

  @override
  List<String> searchKeys = [
    'crosssums',
    'crossumrange',
    'iteratedcrossumrangefrequency',
  ];

  @override
  Widget tool = CrossSumRangeFrequency();
}