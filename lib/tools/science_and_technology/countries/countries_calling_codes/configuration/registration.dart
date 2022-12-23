import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_calling_codes/widget/countries_calling_codes.dart';

class CountriesCallingCodesRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'countries_callingcode';

  @override
  List<String> searchKeys = [
    'countries',
    'countries_callingcodes',
  ];

  @override
  Widget tool = CountriesCallingCodes();
}