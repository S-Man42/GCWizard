import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/primes/primes.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';

class IsPrime extends StatefulWidget {
  @override
  IsPrimeState createState() => IsPrimeState();
}

class IsPrimeState extends State<IsPrime> {
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
          onChanged: (value) {
            setState(() {
              _output = isPrime(BigInt.from(value)) ? i18n(context, 'primes_isprime_isprime') : i18n(context, 'primes_noprime');
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