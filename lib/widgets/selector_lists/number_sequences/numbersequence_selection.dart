import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_lucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_fibonacci_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenne_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_fermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersennefermat_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_factorial_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_bell_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthal_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthaloblong_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pelllucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_jacobsthallucas_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_recaman_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_catalan_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenneprimes_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_mersenneexponents_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_weirdnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_sublimenumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_perfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_superperfectnumbers_selection.dart';
import 'package:gc_wizard/widgets/selector_lists/number_sequences/numbersequence_pseudoperfectnumbers_selection.dart';
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
        className(NumberSequencePellLucasSelection()),
        className(NumberSequenceJacobsthalSelection()),
        className(NumberSequenceJacobsthalLucasSelection()),
        className(NumberSequenceJacobsthalOblongSelection()),
        className(NumberSequenceCatalanSelection()),
        className(NumberSequenceRecamanSelection()),
        className(NumberSequenceBellSelection()),
        className(NumberSequenceMersennePrimesSelection()),
        className(NumberSequenceMersenneExponentsSelection()),
        className(NumberSequencePerfectNumbersSelection()),
        className(NumberSequenceSuperPerfectNumbersSelection()),
        className(NumberSequencePseudoPerfectNumbersSelection()),
        className(NumberSequenceWeirdNumbersSelection()),
        className(NumberSequenceSublimeNumbersSelection()),
      ].contains(className(element.tool));
    }).toList();

    return Container(
        child: GCWToolList(
            toolList: _toolList
        )
    );
  }
}