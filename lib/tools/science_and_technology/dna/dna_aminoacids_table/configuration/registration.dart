import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_aminoacids_table/widget/dna_aminoacids_table.dart';

class DNAAminoAcidsTableRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'dna_aminoacids_table';

  @override
  List<String> searchKeys = [
    'dna',
    'dnaamonoacidstable',
  ];

  @override
  Widget tool = DNAAminoAcidsTable();
}