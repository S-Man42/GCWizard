import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto/rotator.dart';
import 'package:gc_wizard/logic/tools/science/primes/primes.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class NthPrime extends StatefulWidget {
  @override
  NthPrimeState createState() => NthPrimeState();
}

class NthPrimeState extends State<NthPrime> {
  String _output = '2';

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
          max: 78499,
          onChanged: (value) {
            setState(() {
              _output = getNthPrime(value).toString();
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