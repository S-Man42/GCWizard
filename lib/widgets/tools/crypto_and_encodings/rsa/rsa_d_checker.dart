import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rsa.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_textinputformatter.dart';

class RSADChecker extends StatefulWidget {
  @override
  RSADCheckerState createState() => RSADCheckerState();
}

class RSADCheckerState extends State<RSADChecker> {
  String _currentD = '';
  String _currentP = '';
  String _currentQ = '';

  var _integerInputFormatter = IntegerTextInputFormatter(min: 0);

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
            setState(() {});
          },
        ),
        GCWDefaultOutput(child: _calculateOutput())
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
      return '';
    }

    try {
      var e = BigInt.tryParse(_currentD);
      var p = BigInt.tryParse(_currentP);
      var q = BigInt.tryParse(_currentQ);

      var validD = validateD(e, p, q);
      return validD ? i18n(context, 'rsa_d.checker_valid') : i18n(context, 'rsa_d.checker_notvalid');
    } catch (exception) {
      return i18n(context, exception.message);
    }
  }
}
