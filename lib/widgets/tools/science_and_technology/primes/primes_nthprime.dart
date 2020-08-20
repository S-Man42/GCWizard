import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/primes/primes.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';

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
          child: _output
        )
      ],
    );
  }
}