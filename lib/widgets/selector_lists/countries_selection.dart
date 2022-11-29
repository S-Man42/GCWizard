import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/countries/countries_calling_codes.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/countries/countries_ioc_codes.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/countries/countries_iso_codes.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/countries/countries_vehicle_codes.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/countries/country_flags.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CountriesSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(CountriesCallingCodes()),
        className(CountriesIOCCodes()),
        className(CountriesISOCodes()),
        className(CountriesVehicleCodes()),
        className(CountriesFlags()),
      ].contains(className(element.tool));
    }).toList();

    _toolList.sort((a, b) => sortToolList(a, b));

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
