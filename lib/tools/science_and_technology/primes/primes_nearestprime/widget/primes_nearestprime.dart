import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/primes/logic/primes.dart';
import 'package:gc_wizard/tools/common/gcw_integer_spinner/widget/gcw_integer_spinner.dart';
import 'package:gc_wizard/tools/common/gcw_multiple_output/widget/gcw_multiple_output.dart';

class NearestPrime extends StatefulWidget {
  @override
  NearestPrimeState createState() => NearestPrimeState();
}

class NearestPrimeState extends State<NearestPrime> {
  var _currentNumber = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          value: _currentNumber,
          onChanged: (value) {
            setState(() {
              _currentNumber = value;
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    return GCWMultipleOutput(children: getNearestPrime(_currentNumber) ?? []);
  }
}
