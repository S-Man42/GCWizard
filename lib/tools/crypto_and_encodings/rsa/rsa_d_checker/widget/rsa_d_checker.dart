import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/logic/rsa.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/tools/common/gcw_submit_button/widget/gcw_submit_button.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/integer_textinputformatter/widget/integer_textinputformatter.dart';

class RSADChecker extends StatefulWidget {
  @override
  RSADCheckerState createState() => RSADCheckerState();
}

class RSADCheckerState extends State<RSADChecker> {
  String _currentD = '';
  String _currentP = '';
  String _currentQ = '';

  var _integerInputFormatter = IntegerTextInputFormatter(min: 0);
  Widget _output;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          inputFormatters: [_integerInputFormatter],
          hintText: i18n(context, 'rsa_d'),
          onChanged: (text) {
            _currentD = text;
          },
        ),
        GCWTextField(
          inputFormatters: [_integerInputFormatter],
          hintText: i18n(context, 'rsa_primep'),
          onChanged: (text) {
            _currentP = text;
          },
        ),
        GCWTextField(
          inputFormatters: [_integerInputFormatter],
          hintText: i18n(context, 'rsa_primeq'),
          onChanged: (text) {
            _currentQ = text;
          },
        ),
        GCWSubmitButton(
          onPressed: () {
            setState(() {
              _calculateOutput();
            });
          },
        ),
        _output ?? GCWDefaultOutput(),
      ],
    );
  }

  _calculateOutput() {
    if (_currentD == null ||
        _currentD.length == 0 ||
        _currentP == null ||
        _currentP.length == 0 ||
        _currentQ == null ||
        _currentQ.length == 0) {
      _output = null;
    }

    try {
      var e = BigInt.tryParse(_currentD);
      var p = BigInt.tryParse(_currentP);
      var q = BigInt.tryParse(_currentQ);

      var validD = validateD(e, p, q);
      _output = GCWDefaultOutput(
          child: validD ? i18n(context, 'rsa_d.checker_valid') : i18n(context, 'rsa_d.checker_notvalid'));
    } catch (exception) {
      _output = GCWDefaultOutput(child: i18n(context, exception.message));
    }
  }
}
