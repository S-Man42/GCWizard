import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/combinatorics/combination_permutation/widget/combination_permutation.dart';

class CombinationPermutationRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'combinatorics_combinationpermutation';

  @override
  List<String> searchKeys = [
    'combinatorics',
    'combinatorics_combination',
    'combinatorics_permutation',
  ];

  @override
  Widget tool = CombinationPermutation();
}