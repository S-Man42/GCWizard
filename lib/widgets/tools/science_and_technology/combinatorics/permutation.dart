import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/combinatorics/permutation.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

class Permutation extends StatefulWidget {
  @override
  PermutationState createState() => PermutationState();
}

class PermutationState extends State<Permutation> {
  var _currentInput = '';
  bool _currentShowDuplicates = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          maxLength: PERMUTATION_MAX_LENGTH,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'permutation_showduplicates'),
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

    List out = generatePermutations(_currentInput, avoidDuplicates: !_currentShowDuplicates);

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWOutputText(
            text: '${i18n(context, 'permutation_count')}: ${out.length}'
          ),
          GCWOutputText(
            text: out.join(' ')
          )
        ],
      ),
    );
  }
}
