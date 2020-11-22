import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_nthnumber.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_range.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_digits.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/number_sequences/numbersequences_check.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceMersenneSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWToolWidget> _toolList =
    Registry.toolList.where((element) {
      return [
        className(NumberSequenceNthNumber()),
        className(NumberSequenceRange()),
        className(NumberSequenceDigits()),
        className(NumberSequenceCheckNumber()),
      ].contains(className(element.tool));
    }).toList();

    return Container(
        child: GCWToolList(
            toolList: _toolList
        )
    );
  }
}