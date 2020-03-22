import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto/lemon.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Lemon extends StatefulWidget {
  @override
  LemonState createState() => LemonState();
}

class LemonState extends State<Lemon> {
  var _inputController;

  String _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _direction = GCWSwitchPosition.left;

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
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'lemon_mode'),
          leftValue: i18n(context, 'lemon_clockwise'),
          rightValue: i18n(context, 'lemon_counter_clockwise'),
          onChanged: (value) {
            setState(() {
              _direction = value;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';

    if (_currentMode == GCWSwitchPosition.left) {
      output = encryptLemon(_currentInput, counterClockWise: (_direction != GCWSwitchPosition.left));
    } else {
      output = decryptLemon(_currentInput, counterClockWise: (_direction != GCWSwitchPosition.left));
    }

    return GCWDefaultOutput(
      text: output
    );

  }
}