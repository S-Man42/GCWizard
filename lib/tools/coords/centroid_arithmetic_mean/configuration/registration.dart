import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/centroid_arithmetic_mean/widget/centroid_arithmetic_mean.dart';

class CentroidArithmeticMeanRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_centroid';

  @override
  List<String> searchKeys = [
    'coordinates',
        'coordinates_centroid',
        'coordinates_arithmeticmean',
  ];

  @override
  Widget tool = CentroidArithmeticMean();
}