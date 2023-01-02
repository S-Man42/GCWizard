import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/gc_code/logic/gc_code.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_integer_spinner/widget/gcw_integer_spinner.dart';
import 'package:gc_wizard/common_widgets/gcw_twooptions_switch/widget/gcw_twooptions_switch.dart';

class GCCode extends StatefulWidget {
  @override
  GCCodeState createState() => GCCodeState();
}

class GCCodeState extends State<GCCode> {
  var _gcCodeInputController;

  String _currentGCCodeInput = 'GC';
  int _currentID = 1;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

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
        GCWDefaultOutput(child: _buildOutput(context))
      ],
    );
  }

  _buildOutput(BuildContext context) {
    var output = '';

    if (_currentMode == GCWSwitchPosition.right) {
      try {
        var id = gcCodeToID(_currentGCCodeInput);
        output = id == null ? '' : '$id';
      } on FormatException catch (e) {
        output = i18n(context, e.message);
      }
    } else {
      output = idToGCCode(_currentID);
    }

    return output;
  }
}
