import 'package:flutter/material.dart';
import 'package:gc_wizard/configuration/abstract_tool_registration.dart';
import 'package:gc_wizard/tools/common/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/tools/science_and_technology/countries/countries_vehicle_codes/widget/countries_vehicle_codes.dart';

class CountriesVehicleCodesRegistration implements AbstractToolRegistration
{
  @override
  List<ToolCategory>  = [
    
  ];

  @override
  String i18nPrefix = 'countries_vehiclecode';

  @override
  List<String> searchKeys = [
    'countries',
    'countries_vehiclecodes',
  ];

  @override
  Widget tool = CountriesVehicleCodes();
}