import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/countries.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CountriesCallingCodes extends StatefulWidget {
  @override
  CountriesCallingCodesState createState() => CountriesCallingCodesState();
}

class CountriesCallingCodesState extends State<CountriesCallingCodes> {
  var _currentSort = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentSort,
          title: i18n(context, 'countries_callingcodes_sort'),
          leftValue: i18n(context, 'common_countries'),
          rightValue: i18n(context, 'countries_callingcodes_sort_callingcodes'),
          onChanged: (value) {
            setState(() {
              _currentSort = value;
            });
          },
        ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    var data = [];
    var output;

    if (_currentSort == GCWSwitchPosition.left) {
      data = COUNTRIES.values.where((e) => e['calling_code'] != null && e['calling_code'].length > 0).map((e) {
        return [i18n(context, e['name']), e['calling_code']];
      }).toList();

      data.sort((a, b) {
        return a[0].compareTo(b[0]);
      });

      output = columnedMultiLineOutput(context, data, flexValues: [2, 1]);
    } else {
      data = COUNTRIES.values.where((e) => e['calling_code'] != null && e['calling_code'].length > 0).map((e) {
        return [e['calling_code'], i18n(context, e['name'])];
      }).toList();

      data.sort((a, b) {
        var result = a[0].compareTo(b[0]);
        if (result != 0) return result;

        return a[1].compareTo(b[1]);
      });

      output = columnedMultiLineOutput(context, data, flexValues: [1, 2]);
    }

    return Column(
      children: output,
    );
  }
}
