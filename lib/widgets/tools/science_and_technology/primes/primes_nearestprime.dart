import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/primes/primes.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

class NearestPrime extends StatefulWidget {
  @override
  NearestPrimeState createState() => NearestPrimeState();
}

class NearestPrimeState extends State<NearestPrime> {
  var _currentPrimes = [2];

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
          onChanged: (value) {
            setState(() {
              _currentPrimes = getNearestPrime(value);
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    if (_currentPrimes == null)
      _currentPrimes = [];

    return GCWOutput(
      child: Column(
        children: _currentPrimes.map((prime) => GCWOutputText(
          text: prime.toString()
        )).toList(),
      )
    );
  }
}