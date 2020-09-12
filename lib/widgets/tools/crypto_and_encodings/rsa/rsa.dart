import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/rsa.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_encrypt_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/integer_textinputformatter.dart';

enum _RSAEncryptState{NONE, ENCRYPT, DECRYPT}

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

  var _state = _RSAEncryptState.NONE;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            _currentInput = text;
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'rsa_rsa_key')
        ),
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
        GCWEncryptButtonBar(
          onPressedEncode: () {
            setState(() {
              _state = _RSAEncryptState.ENCRYPT;
            });
          },
          onPressedDecode: () {
            setState(() {
              _state = _RSAEncryptState.DECRYPT;
            });
          },
        ),
        _calculateOutput()
      ],
    );
  }

  _calculateOutput() {
    if (
         _state == _RSAEncryptState.NONE
      || _currentInput == null || _currentInput.length == 0
      || _currentED == null || _currentED.length == 0
      || _currentP == null || _currentP.length == 0
      || _currentQ == null || _currentQ.length == 0
    ) {
      return GCWDefaultOutput(child: '');
    }

    try {
      var outputText;
      var ed = BigInt.tryParse(_currentED);
      var p = BigInt.tryParse(_currentP);
      var q = BigInt.tryParse(_currentQ);

      var d;

      if (_state == _RSAEncryptState.ENCRYPT) {
        outputText = encryptRSA(_currentInput, ed, p, q);
        try {
          d = calculateD(ed, p, q).toString();
        } catch(e) {
          d = i18n(context, 'rsa_rsa_d.notcomputeable');
        }
      } else {
        outputText = decryptRSA(_currentInput, ed, p, q);
      }

      _state = _RSAEncryptState.NONE;

      var outputChildren = <Widget>[
        GCWDefaultOutput(
          child: outputText,
        ),
        GCWTextDivider(
          text: i18n(context, 'rsa_rsa_calculatedparameters')
        )
      ];

      outputChildren.addAll(columnedMultiLineOutput([
        [i18n(context, 'rsa_n'), N(p, q)],
        [i18n(context, 'rsa_phi'), phi(p, q)],
        d != null ? [i18n(context, 'rsa_d'), d] : null
      ], flexValues: [1, 2]));

      return Column(
        children: outputChildren
      );
    } catch(exception) {
      showToast(i18n(context, exception.message));

      _state = _RSAEncryptState.NONE;
      return GCWDefaultOutput(child: '');
    }
  }
}