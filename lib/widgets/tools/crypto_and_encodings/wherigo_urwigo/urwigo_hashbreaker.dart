import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/urwigo_tools.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';

class UrwigoHashBreaker extends StatefulWidget {
  @override
  UrwigoHashBreakerState createState() => UrwigoHashBreakerState();
}

class UrwigoHashBreakerState extends State<UrwigoHashBreaker> {
  var _currentInput = 0;
  var _currentOutput = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          title: i18n(context, 'urwigo_hashbreaker_input'),
          value: _currentInput,
          min: 0,
          max: 65535,
          onChanged: (value) {
            setState(() {
              _currentInput = value;
            });
          },
        ),
        GCWButton(
          text: i18n(context, 'common_submit_button_text'),
          onPressed: () {
            setState(() {
              _currentOutput = breakUrwigoHash(_currentInput);
            });
          },
        ),
        GCWDefaultOutput(child: _currentOutput)
      ],
    );
  }
}
