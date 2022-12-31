import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_tool/widget/gcw_tool.dart';
import 'package:gc_wizard/common_widgets/gcw_toollist/widget/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/mersennefermat/widget/mersennefermat.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

class NumberSequenceMersenneFermatSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {
    final List<GCWTool> _toolList = registeredTools.where((element) {
      return [
        className(NumberSequenceMersenneFermatNthNumber()),
        className(NumberSequenceMersenneFermatRange()),
        className(NumberSequenceMersenneFermatDigits()),
        className(NumberSequenceMersenneFermatCheckNumber()),
        className(NumberSequenceMersenneFermatContainsDigits()),
      ].contains(className(element.tool));
    }).toList();

    return Container(child: GCWToolList(toolList: _toolList));
  }
}
