import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_tables_examples_select/widget/symbol_tables_examples_select.dart';

class SymbolTableExamplesSelectRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'symboltablesexamples';

  @override
  List<String> searchKeys = [
    'symbol',
    'symboltablesexamples',
  ];

  @override
  Widget tool = SymbolTableExamplesSelect();
}