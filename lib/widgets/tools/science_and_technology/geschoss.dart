import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/geschoss.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_encrypt_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Geschoss extends StatefulWidget {
  @override
  GeschossState createState() => GeschossState();
}

class GeschossState extends State<Geschoss> {
  var _inputController;
  var _currentOutput = GeschossOutput('', '');

  String _currentInput = '';

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'common_alphabet')
        ),


        GCWCalculateButtonBar(
          onPressedCalculate: () {
            if (_currentInput == null || _currentInput.length == 0) {
              showToast(i18n(context, 'bifid_error_no_encrypt_input'));
            } else {
              if (_currentMatrixMode == GCWSwitchPosition.left) {
                _currentKey = "12345";
              } else {
                _currentKey = "123456";
              }
              setState(() {
                _currentOutput = encryptBifid(
                    _currentInput, _currentKey, mode: _currentBifidMode,
                    alphabet: _currentAlphabet,
                    alphabetMode: _currentBifidAlphabetMode);
              });
            }
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentOutput.state == 'ERROR') {
      showToast(i18n(context, _currentOutput.output));
      return GCWDefaultOutput(
          text: '' //TODO: Exception
      );
    } else {
      return GCWOutput(
        child: Column(
          children: <Widget>[
            GCWOutputText(
                text: _currentOutput.output
            ),
          ],
        ),
      );
    }
  }
}
