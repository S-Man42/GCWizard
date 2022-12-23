import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/symbol_tables/symbol_replacer/symbol_replacer/widget/symbol_replacer.dart';

class SymbolReplacerRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory> ToolCategory.GENERAL_CODEBREAKERS = [
    ToolCategory.GENERAL_CODEBREAKERS
  ];

  @override
  String i18nPrefix = 'symbol_replacer';

  @override
  List<String> searchKeys = [
    'symbol_replacer',
  ];

  @override
  Widget tool = SymbolReplacer();
}