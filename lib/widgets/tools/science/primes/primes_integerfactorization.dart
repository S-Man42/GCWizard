import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto/rotator.dart';
import 'package:gc_wizard/logic/tools/science/primes/primes.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';

class IntegerFactorization extends StatefulWidget {
  @override
  IntegerFactorizationState createState() => IntegerFactorizationState();
}

class IntegerFactorizationState extends State<IntegerFactorization> {
  String _output = '1';

  List<BigInt> _currentFactors = [BigInt.one];

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
          onChanged: (value) {
            setState(() {
              _currentFactors = integerFactorization(value);
            });
          },
        ),
        _buildOutput()
      ],
    );
  }

  Widget _buildOutput() {
    return GCWOutput(
      child: Column(
        children: _currentFactors.map((prime) => GCWOutputText(
          text: prime.toString()
        )).toList(),
      )
    );
  }
}