import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/affine.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Affine extends StatefulWidget {
  @override
  AffineState createState() => AffineState();
}

class AffineState extends State<Affine> {

  TextEditingController _encodeController;
  TextEditingController _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  String _currentOutput ='';
  String _currentInput = '';

  int _currentKeyA = 1;
  int _currentKeyB = 0;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),

        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encodeController,
                onChanged: (text) {
                  setState(() {
                    _currentEncodeInput = text;
                  });
                },
        )
            : GCWTextField(
                controller: _decodeController,
                  onChanged: (text) {
                    setState(() {
                      _currentDecodeInput = text;
                    });
                  },
            ),

          GCWIntegerSpinner(
          title: i18n(context, 'affine_key_a'),
          min: 1,
          max: 12,
          step: 1,
          items: {1 : 1, 2 : 3, 3 : 5, 4 : 7, 5 : 9, 6 : 11, 7 : 15, 8 : 17, 9 : 19, 10 : 21, 11 : 23, 12: 25},
          value: _currentKeyA,
          onChanged: (value) {
            setState(() {
              _currentKeyA = value;
            });
          },
        ),

        GCWIntegerSpinner(
          title: i18n(context, 'affine_key_b'),
          min: 0,
          max: 25,
          value: _currentKeyB,
          onChanged: (value) {
            setState(() {
              _currentKeyB = value;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'common_output')
        ),

        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    if (_currentKeyA % 2 == 0)
      showToast(i18n(context, 'affine_error_wrong_key_a'));
    else
    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeAffine(_currentEncodeInput, _currentKeyA, _currentKeyB);
    } else
      output = decodeAffine(_currentDecodeInput, _currentKeyA, _currentKeyB);

    return GCWOutputText(
        text: output,
    );
  }
}