import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencelucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencefibonacci_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencemersenne_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencefermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencepell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencejacobsthal_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencepelllucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencejacobsthallucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencerecaman_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequencecatalan_selection.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWTool> _toolList =
    Registry.toolList.where((element) {
      return [
        className(NumberSequenceLucasSelection()),
        className(NumberSequenceFibonacciSelection()),
        className(NumberSequenceFermatSelection()),
        className(NumberSequenceMersenneSelection()),
        className(NumberSequencePellSelection()),
        className(NumberSequenceJacobsthalSelection()),
        className(NumberSequencePellLucasSelection()),
        className(NumberSequenceJacobsthalLucasSelection()),
        className(NumberSequenceRecamanSelection()),
        className(NumberSequenceCatalanSelection()),
      ].contains(className(element.tool));
    }).toList();

    return Container(
        child: GCWToolList(
            toolList: _toolList
        )
    );
  }
}