import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/rsa/logic/rsa.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_submit_button/widget/gcw_submit_button.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/integer_textinputformatter/widget/integer_textinputformatter.dart';

class RSAEChecker extends StatefulWidget {
  @override
  RSAECheckerState createState() => RSAECheckerState();
}

class RSAECheckerState extends State<RSAEChecker> {
  String _currentE = '';
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
          hintText: i18n(context, 'rsa_e'),
          onChanged: (text) {
            _currentE = text;
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
    if (_currentE == null ||
        _currentE.length == 0 ||
        _currentP == null ||
        _currentP.length == 0 ||
        _currentQ == null ||
        _currentQ.length == 0) {
      _output = null;
    }

    try {
      var e = BigInt.tryParse(_currentE);
      var p = BigInt.tryParse(_currentP);
      var q = BigInt.tryParse(_currentQ);

      var validE = validateE(e, p, q);
      _output = GCWDefaultOutput(
          child: validE ? i18n(context, 'rsa_e.checker_valid') : i18n(context, 'rsa_e.checker_notvalid'));
    } catch (exception) {
      _output = GCWDefaultOutput(child: i18n(context, exception.message));
    }
  }
}
