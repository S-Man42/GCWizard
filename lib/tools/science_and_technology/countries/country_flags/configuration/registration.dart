import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/country_flags/widget/country_flags.dart';

class CountriesFlagsRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'countries_flags';

  @override
  List<String> searchKeys = [
    'countries',
    'symbol_flags',
    'countries_flags',
  ];

  @override
  Widget tool = CountriesFlags();
}