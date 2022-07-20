import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/divisor/logic/divisor.dart';
import 'package:gc_wizard/tools/science_and_technology/recycling/logic/recycling.dart';
import 'package:gc_wizard/tools/common/gcw_crosstotal_output/widget/gcw_crosstotal_output.dart';
import 'package:gc_wizard/tools/common/gcw_crosstotal_switch/widget/gcw_crosstotal_switch.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_integer_spinner/widget/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

class Recycling extends StatefulWidget {
  @override
  RecyclingState createState() => RecyclingState();
}

class RecyclingState extends State<Recycling> {
  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> data = RECYCLING_CODES.entries.map((entry) {
      return <dynamic>[
        entry.key.replaceAll(RegExp(r'[^0-9]'), ''),
        entry.value['short'],
        i18n(context, entry.value['name'])
      ];
    }).toList();

    data.insert(
        0, [i18n(context, 'recycling_code'), i18n(context, 'recycling_short'), i18n(context, 'recycling_name')]);

    return Column(
        children: columnedMultiLineOutput(context, data, flexValues: [1, 2, 4], hasHeader: true, copyColumn: 1));
  }
}
