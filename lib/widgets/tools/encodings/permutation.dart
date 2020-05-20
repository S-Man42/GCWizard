import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/permutation.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';

class Permutation extends StatefulWidget {
  @override
  PermutationState createState() => PermutationState();
}

class PermutationState extends State<Permutation> {
  var _currentInput = '';
  bool _avoidDouble = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'permutation_avoiddouble'),
          value: _avoidDouble,
          onChanged: (value) {
            setState(() {
                _avoidDouble = value;
            });
          },
        ),
        GCWDefaultOutput(
          text: _calculateOutput()
        ),
      ],
    );
  }

  _calculateOutput() {
    List out = buildPermutation(_currentInput, _avoidDouble);
    return '${i18n(context, 'permutation_count')}: ${out.length}\n${out.join(' ')}';
  }
}
