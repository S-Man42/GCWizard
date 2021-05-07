import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rsa.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_submit_button.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_textinputformatter.dart';

class RSA extends StatefulWidget {
  @override
  RSAState createState() => RSAState();
}

class RSAState extends State<RSA> {
  String _currentInput = '';
  String _currentED = '';
  String _currentP = '';
  String _currentQ = '';

  var _integerInputFormatter = IntegerTextInputFormatter(min: 0);
  var _currentMode = GCWSwitchPosition.right;
  Widget _output;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            _currentInput = text;
          },
        ),
        GCWTextDivider(text: i18n(context, 'rsa_rsa_key')),
        GCWTextField(
          inputFormatters: [_integerInputFormatter],
          hintText: i18n(context, 'rsa_rsa_eq'),
          onChanged: (text) {
            _currentED = text;
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
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
              _output = null;
            });
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
    try {
      var outputText;
      var ed = BigInt.tryParse(_currentED);
      var p = BigInt.tryParse(_currentP);
      var q = BigInt.tryParse(_currentQ);

      var d;

      if (_currentMode == GCWSwitchPosition.left) {
        outputText = encryptRSA(_currentInput, ed, p, q);
        try {
          d = calculateD(ed, p, q).toString();
        } catch (e) {
          d = i18n(context, 'rsa_rsa_d.notcomputeable');
        }
      } else {
        outputText = decryptRSA(_currentInput, ed, p, q);
      }

      var outputChildren = <Widget>[
        GCWDefaultOutput(
          child: outputText,
        ),
        GCWTextDivider(text: i18n(context, 'rsa_rsa_calculatedparameters'))
      ];

      outputChildren.addAll(columnedMultiLineOutput(context, [
        [i18n(context, 'rsa_n'), N(p, q)],
        [i18n(context, 'rsa_phi'), phi(p, q)],
        d != null ? [i18n(context, 'rsa_d'), d] : null
      ], flexValues: [
        1,
        2
      ]));

      _output = Column(children: outputChildren);
    } catch (exception) {
      _output = null;
      showToast(i18n(context, exception.message));
    }
  }
}
