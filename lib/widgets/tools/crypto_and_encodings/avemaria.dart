import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/avemaria.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class AveMaria extends StatefulWidget {
  @override
  AveMariaState createState() => AveMariaState();
}

class AveMariaState extends State<AveMaria> {
  var _decodeController;
  var _encodeController;

  String _currentEncodeInput = '';
  String _currentDecodeInput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  GCWSwitchPosition _currentSource = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentEncodeInput);
    _encodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _decodeController.dispose();
    _encodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
          controller: _encodeController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
          ],
          onChanged: (text) {
            setState(() {
              _currentEncodeInput = text;
              _calculateOutput();
            });
          },
        )
            : GCWTextField(
          controller: _decodeController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
          ],
          onChanged: (text) {
            setState(() {
              _currentDecodeInput = text;
              _calculateOutput();
            });
          },
        ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
              _calculateOutput();
            });
          },
        ),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  String _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left)
      return encodeAveMaria(_currentEncodeInput);
    else
      return decodeAveMaria(_currentDecodeInput);
  }
}
