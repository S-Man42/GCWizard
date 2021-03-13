import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/combinatorics/permutation.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';

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
      return GCWDefaultOutput();
    }

    List out = generatePermutations(_currentInput, avoidDuplicates: !_currentShowDuplicates);

    return GCWMultipleOutput(
      children: [
        GCWOutputText(
          text: '${i18n(context, 'common_count')}: ${out.length}',
          copyText: out.length.toString(),
        ),
        out.join(' ')
      ],
    );
  }
}
