import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/cross_sum.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class CrossSumRange extends StatefulWidget {
  @override
  CrossSumRangeState createState() => CrossSumRangeState();
}

class CrossSumRangeState extends State<CrossSumRange> {
  var _currentCrossSum = 1;
  var _currentRangeStart = 0;
  var _currentRangeEnd = 100;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextDivider(
          text: i18n(context, 'crosssum_range_expected')
        ),
        GCWIntegerSpinner(
          value: _currentCrossSum,
          onChanged: (value) {
            setState(() {
              _currentCrossSum = value;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'crosssum_range_range')
        ),
        GCWIntegerSpinner(
          value: _currentRangeStart,
          onChanged: (value) {
            setState(() {
              _currentRangeStart = value;
            });
          },
        ),
        GCWIntegerSpinner(
          value: _currentRangeEnd,
          onChanged: (value) {
            setState(() {
              _currentRangeEnd = value;
            });
          },
        ),
        GCWDefaultOutput(
          text: crossSumRange(_currentRangeStart, _currentRangeEnd, _currentCrossSum).join('\n')
        )
      ],
    );
  }
}