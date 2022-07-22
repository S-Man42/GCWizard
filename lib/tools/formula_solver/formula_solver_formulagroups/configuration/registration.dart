import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/formula_solver/formula_solver_formulagroups/widget/formula_solver_formulagroups.dart';

class FormulaSolverFormulaGroupsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'formulasolver';

  @override
  List<String> searchKeys = [
    'formulasolver',
  ];

  @override
  Widget tool = FormulaSolverFormulaGroups();
}