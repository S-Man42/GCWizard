import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class VanitySingleNumbers extends StatefulWidget {
  @override
  VanitySingleNumbersState createState() => VanitySingleNumbersState();
}

class VanitySingleNumbersState extends State<VanitySingleNumbers> {
  var _currentInput = '';
  var _currentNumberForSpaceMode = GCWSwitchPosition.right;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'vanity_numberforspace'),
          leftValue: '0',
          rightValue: '1',
          value: _currentNumberForSpaceMode,
          onChanged: (value) {
            setState(() {
              _currentNumberForSpaceMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    return encryptVanitySingleNumbers(_currentInput, numberForSpace: _currentNumberForSpaceMode == GCWSwitchPosition.right ? '1' : '0');
  }
}