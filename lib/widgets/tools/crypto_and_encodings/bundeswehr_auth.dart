import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bundeswehr_auth.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/common/gcw_alphabetdropdown.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class BundeswehrAuth extends StatefulWidget {
  @override
  BundeswehrAuthState createState() => BundeswehrAuthState();
}

class BundeswehrAuthState extends State<BundeswehrAuth> {
  var _inputAuthController;
  var _callSignController;
  var _letterController;

  String _currentAuthInput = '';
  String _currentCallSign = '';
  String _currentLetter = '';

  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputAuthController = TextEditingController(text: _currentAuthInput);
    _callSignController = TextEditingController(text: _currentCallSign);
    _letterController = TextEditingController(text: _currentLetter);
  }

  @override
  void dispose() {
    _inputAuthController.dispose();
    _callSignController.dispose();
    _letterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
        ? Column(
          children: <Widget>[
            GCWTextField(
              controller: _inputAuthController,
              onChanged: (text) {
                setState(() {
                  _currentAuthInput = text;
                });
              },
            ),

          ],
        )
        : Column(
          children: <Widget>[

          ],
        ),
        GCWDefaultOutput(child: _calculateOutput() //_currentOutput == null ? '' : _currentOutput
        )
      ],
    );
  }

  _calculateOutput() {
    var output = '';

    if (_currentMode == GCWSwitchPosition.left) {
        output = buildAuthBundeswehr();
    } else {
        output = i18n(context, checkAuthBundeswehr());
    }

    return output ?? '';
  }
}
