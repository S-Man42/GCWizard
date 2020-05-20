import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/combinatorics/combination.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/combinatorics/permutation.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class CombinationPermutation extends StatefulWidget {
  @override
  CombinationPermutationState createState() => CombinationPermutationState();
}

class CombinationPermutationState extends State<CombinationPermutation> {
  var _currentInput = '';
  bool _currentShowDuplicates = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          maxLength: PERMUTATION_MAX_LENGTH - 1,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'combinatorics_showduplicates'),
          value: _currentShowDuplicates,
          onChanged: (value) {
            setState(() {
              _currentShowDuplicates = value;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  _buildOutput(BuildContext context) {
    if (_currentInput == null || _currentInput.length == 0) {
      return GCWDefaultOutput(
          text: ''
      );
    }

    List<String> combinations = generateCombinations(_currentInput, avoidDuplicates: !_currentShowDuplicates);

    List<List<dynamic>> outputData = combinations
        .map((combination) => [combination, generatePermutations(combination, avoidDuplicates: !_currentShowDuplicates).join(' ')])
        .toList();

    var rows = columnedMultiLineOutput(outputData, flexValues: [1, 3]);

    rows.insert(0,
      GCWTextDivider(
         text: i18n(context, 'common_output')
      )
    );

    return Column(
      children: rows
    );
  }
}