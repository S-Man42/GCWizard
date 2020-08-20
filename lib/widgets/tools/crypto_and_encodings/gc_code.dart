import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gc_code.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_standard_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class GCCode extends StatefulWidget {
  @override
  GCCodeState createState() => GCCodeState();
}

class GCCodeState extends State<GCCode> {
  var _gcCodeInputController;

  String _currentGCCodeInput = 'GC';
  int _currentID = 1;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  var _maskFormatter = MaskTextInputFormatter(
    mask: 'GC############',
    filter: {"#": RegExp(r'[0-9A-Za-z]')}
  );

  @override
  void initState() {
    super.initState();
    _gcCodeInputController = TextEditingController(text: _currentGCCodeInput);
  }

  @override
  void dispose() {
    _gcCodeInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.right
          ? GCWTextField(
              controller: _gcCodeInputController,
              inputFormatters: [_maskFormatter],
              onChanged: (text) {
                setState(() {
                  _currentGCCodeInput = text;
                });
              },
            )
          : GCWIntegerSpinner(
              value: _currentID,
              min: 0,
              onChanged: (value) {
                setState(() {
                  _currentID = value;
                });
              },
            ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWStandardOutput(
          text: _buildOutput(context)
        )
      ],
    );
  }

  _buildOutput(BuildContext context) {
    var output = '';

    if (_currentMode == GCWSwitchPosition.right) {
      try {
        var id = gcCodeToID(_currentGCCodeInput);
        output = id == null ? '' : '$id';
      } on FormatException catch(e) {
        output = i18n(context, e.message);
      }
    } else {
      output = idToGCCode(_currentID);
    }

    return output;
  }
}