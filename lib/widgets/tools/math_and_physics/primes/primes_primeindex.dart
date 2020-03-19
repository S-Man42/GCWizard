import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto/rotator.dart';
import 'package:gc_wizard/logic/tools/math_and_physics/primes/primes.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class PrimeIndex extends StatefulWidget {
  @override
  PrimeIndexState createState() => PrimeIndexState();
}

class PrimeIndexState extends State<PrimeIndex> {
  String _output = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          value: 1,
          min: 1,
          max: 1000003,
          onChanged: (value) {
            setState(() {
              var index = getPrimeIndex(value);
              _output = index >= 1 ? index.toString() : i18n(context, 'primes_noprime');
            });
          },
        ),
        GCWDefaultOutput(
          text: _output
        )
      ],
    );
  }
}