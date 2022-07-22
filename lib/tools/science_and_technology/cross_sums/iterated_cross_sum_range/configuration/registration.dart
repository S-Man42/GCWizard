import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/cross_sums/iterated_cross_sum_range/widget/iterated_cross_sum_range.dart';

class IteratedCrossSumRangeRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'crosssum_range_iterated';

  @override
  List<String> searchKeys = [
    'crosssums',
    'iteratedcrosssumrange',
  ];

  @override
  Widget tool = IteratedCrossSumRange();
}