import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chronogram.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';

class Chronogram extends StatefulWidget {
  @override
  ChronogramState createState() => ChronogramState();
}

class ChronogramState extends State<Chronogram> {
  var _currentInput = '';
  var _currentValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
            onChanged: (text) {
              setState(() {
                _currentInput = text;
              });
            }
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'chronogram_modus'),
          value: _currentValue,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
          },
        ),
        GCWDefaultOutput(
            child: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentInput == null)
      return '';

    var out = decodeChronogram(_currentInput, _currentValue) ;

    return out;
  }
}