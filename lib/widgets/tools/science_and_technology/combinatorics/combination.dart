import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/combinatorics/combination.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_standard_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

class Combination extends StatefulWidget {
  @override
  CombinationState createState() => CombinationState();
}

class CombinationState extends State<Combination> {
  var _currentInput = '';
  bool _currentShowDuplicates = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          maxLength: COMBINATION_MAX_LENGTH,
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
      return GCWStandardOutput(
          text: ''
      );
    }

    List out = generateCombinations(_currentInput, avoidDuplicates: !_currentShowDuplicates);

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWOutputText(
            text: '${i18n(context, 'common_count')}: ${out.length}'
          ),
          GCWOutputText(
            text: out.join(' ')
          )
        ],
      ),
    );
  }
}