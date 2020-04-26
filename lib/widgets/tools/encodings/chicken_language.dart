import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/encodings/chicken_language.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class ChickenLanguage extends StatefulWidget {
  @override
  ChickenLanguageState createState() => ChickenLanguageState();
}

class ChickenLanguageState extends State<ChickenLanguage> {

  var _currentValue = {'text': '', 'value': ''};
  var _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerTextField(
          onChanged: (ret) {
            setState(() {
              _currentValue = ret;
            });
          }
        ),
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWOutputText(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentValue == null)
      return '';

    var calculated = _currentMode == GCWSwitchPosition.left
      ? encodeChickenLanguage(_currentValue['value'])
      : decodeChickenLanguage(_currentValue['value']);

    return calculated == null ? '' : calculated.toString();
  }
}