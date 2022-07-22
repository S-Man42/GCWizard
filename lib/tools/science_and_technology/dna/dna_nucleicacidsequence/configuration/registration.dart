import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/dna/dna_nucleicacidsequence/widget/dna_nucleicacidsequence.dart';

class DNANucleicAcidSequenceRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'dna_nucleicacidsequence';

  @override
  List<String> searchKeys = [
    'dna',
    'dnanucleicacidsequence',
  ];

  @override
  Widget tool = DNANucleicAcidSequence();
}