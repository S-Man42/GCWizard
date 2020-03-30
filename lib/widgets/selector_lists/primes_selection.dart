import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_tool.dart';
import 'package:gc_wizard/widgets/common/gcw_toollist.dart';
import 'package:gc_wizard/widgets/registry.dart';
import 'package:gc_wizard/widgets/selector_lists/gcw_selection.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_integerfactorization.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_isprime.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_nearestprime.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_nthprime.dart';
import 'package:gc_wizard/widgets/tools/science/primes/primes_primeindex.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class PrimesSelection extends GCWSelection {
  @override
  Widget build(BuildContext context) {

    final List<GCWToolWidget> _toolList =
      Registry.toolList.where((element) {
        return [
          className(NthPrime()),
          className(IsPrime()),
          className(NearestPrime()),
          className(PrimeIndex()),
          className(IntegerFactorization())
        ].contains(className(element.tool));
      }).toList();

    return Container(
      child: GCWToolList(
        toolList: _toolList
      )
    );
  }
}