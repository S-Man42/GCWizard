import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/logic/numeral_bases.dart';
import 'package:gc_wizard/common_widgets/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/common_widgets/gcw_default_output/widget/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/gcw_twooptions_switch/widget/gcw_twooptions_switch.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/text_onlydigitsandspace_textinputformatter/widget/text_onlydigitsandspace_textinputformatter.dart';
import 'package:gc_wizard/tools/utils/textinputformatter/text_onlyhexdigitsandspace_textinputformatter/widget/text_onlyhexdigitsandspace_textinputformatter.dart';

class Hexadecimal extends StatefulWidget {
  @override
  HexadecimalState createState() => HexadecimalState();
}

class HexadecimalState extends State<Hexadecimal> {
  var _currentDecimalValue = '';
  var _currentHexValue = '';
  var _hexController;
  var _decimalController;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _hexController = TextEditingController(text: _currentHexValue);
    _decimalController = TextEditingController(text: _currentDecimalValue);
  }

  @override
  void dispose() {
    _hexController.dispose();
    _decimalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                inputFormatters: [TextOnlyDigitsAndSpaceInputFormatter()],
                controller: _decimalController,
                onChanged: (value) {
                  setState(() {
                    _currentDecimalValue = value;
                  });
                },
              )
            : GCWTextField(
                inputFormatters: [TextOnlyHexDigitsAndSpaceInputFormatter()],
                controller: _hexController,
                onChanged: (value) {
                  setState(() {
                    _currentHexValue = value;
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
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return _currentDecimalValue.split(' ').map((value) => convertBase(value, 10, 16)).join(' ');
    } else {
      return _currentHexValue.split(' ').map((value) => convertBase(value, 16, 10)).join(' ');
    }
  }
}
