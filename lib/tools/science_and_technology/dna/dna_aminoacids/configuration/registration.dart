import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_aminoacids/widget/dna_aminoacids.dart';

class DNAAminoAcidsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'dna_aminoacids';

  @override
  List<String> searchKeys = [
    'dna',
    'dnaaminoacids',
  ];

  @override
  Widget tool = DNAAminoAcids();
}