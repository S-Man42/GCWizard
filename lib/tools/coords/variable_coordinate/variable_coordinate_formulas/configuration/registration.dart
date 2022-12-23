import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/coords/variable_coordinate/variable_coordinate_formulas/widget/variable_coordinate_formulas.dart';

class VariableCoordinateFormulasRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.COORDINATES = [
    ToolCategory.COORDINATES
  ];

  @override
  String i18nPrefix = 'coords_variablecoordinate';

  @override
  List<String> searchKeys = [
    'coordinates',
        'formulasolver',
        'coordinates_variablecoordinateformulas',
  ];

  @override
  Widget tool = VariableCoordinateFormulas();
}