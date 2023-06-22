import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';

class GCD extends StatefulWidget {
  const GCD({Key? key}) : super(key: key);

  @override
  GCDState createState() => GCDState();
}

class GCDState extends State<GCD> {
  int _currentInputA = 0;
  int _currentInputB = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          min: 0,
          value: _currentInputA,
          onChanged: (value) {
            setState(() {
              _currentInputA = value;
            });
          },
        ),
        GCWIntegerSpinner(
          min: 0,
          value: _currentInputB,
          onChanged: (value) {
            setState(() {
              _currentInputB = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    return GCWDefaultOutput(
      child: GCWColumnedMultilineOutput(data: [
        [i18n(context, 'gcd_lcm_gcd'), gcd(_currentInputA, _currentInputB).toString()],
      ]),
    );
  }
}
