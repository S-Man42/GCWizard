import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/math_utils.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_integer_spinner.dart';

class LCM extends StatefulWidget {
  const LCM({Key? key}) : super(key: key);

  @override
  LCMState createState() => LCMState();
}

class LCMState extends State<LCM> {
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
      child: GCWColumnedMultilineOutput(
        data: [
          [i18n(context, 'gcd_lcm_lcm'), lcm(_currentInputA, _currentInputB).toString()]],
      ),
    );
  }
}