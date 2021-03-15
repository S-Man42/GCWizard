import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rsa.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_textinputformatter.dart';

class RSADCalculator extends StatefulWidget {
  @override
  RSADCalculatorState createState() => RSADCalculatorState();
}

class RSADCalculatorState extends State<RSADCalculator> {
  String _currentE = '';
  String _currentP = '';
  String _currentQ = '';

  var _integerInputFormatter = IntegerTextInputFormatter(min: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          inputFormatters: [_integerInputFormatter],
          hintText: i18n(context, 'rsa_e'),
          onChanged: (text) {
            setState(() {
              _currentE = text;
            });
          },
        ),
        GCWTextField(
          inputFormatters: [_integerInputFormatter],
          hintText: i18n(context, 'rsa_primep'),
          onChanged: (text) {
            setState(() {
              _currentP = text;
            });
          },
        ),
        GCWTextField(
          inputFormatters: [_integerInputFormatter],
          hintText: i18n(context, 'rsa_primeq'),
          onChanged: (text) {
            setState(() {
              _currentQ = text;
            });
          },
        ),
        GCWSubmitButton(
          onPressed: () {
            setState(() {});
          },
        ),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  _calculateOutput() {
    if (_currentE == null ||
        _currentE.length == 0 ||
        _currentP == null ||
        _currentP.length == 0 ||
        _currentQ == null ||
        _currentQ.length == 0) {
      return '';
    }

    try {
      var e = BigInt.tryParse(_currentE);
      var p = BigInt.tryParse(_currentP);
      var q = BigInt.tryParse(_currentQ);

      return calculateD(e, p, q).toString();
    } catch (exception) {
      showToast(i18n(context, exception.message));
      return '';
    }
  }
}
