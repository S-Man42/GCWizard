import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/enclosed_areas.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class EnclosedAreas extends StatefulWidget {
  @override
  EnclosedAreasState createState() => EnclosedAreasState();
}

class EnclosedAreasState extends State<EnclosedAreas> {
  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.left;

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
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'enclosedareas_with4'),
          rightValue: i18n(context, 'enclosedareas_without4'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          child: decodeEnclosedAreas(_currentInput, _currentMode == GCWSwitchPosition.left)
        )
      ],
    );
  }
}