import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_lucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_fibonacci_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_mersenne_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_fermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_mersennefermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_factorial_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_pell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_jacobsthal_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_pelllucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_jacobsthallucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_recaman_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/numbersequence_catalan_selection.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumberSequenceSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWTool> _toolList =
    Registry.toolList.where((element) {
      return [
        className(NumberSequenceFactorialSelection()),
        className(NumberSequenceFibonacciSelection()),
        className(NumberSequenceLucasSelection()),
        className(NumberSequenceFermatSelection()),
        className(NumberSequenceMersenneSelection()),
        className(NumberSequenceMersenneFermatSelection()),
        className(NumberSequencePellSelection()),
        className(NumberSequenceJacobsthalSelection()),
        className(NumberSequencePellLucasSelection()),
        className(NumberSequenceJacobsthalLucasSelection()),
        className(NumberSequenceCatalanSelection()),
        className(NumberSequenceRecamanSelection()),
      ].contains(className(element.tool));
    }).toList();

    return Container(
        child: GCWToolList(
            toolList: _toolList
        )
    );
  }
}