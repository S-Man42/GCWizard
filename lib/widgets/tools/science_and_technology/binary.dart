import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/text_only01andspace_textinputformatter.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/text_onlydigitsandspace_textinputformatter.dart';

class Binary extends StatefulWidget {
  @override
  BinaryState createState() => BinaryState();
}

class BinaryState extends State<Binary> {
  var _currentDecimalValue = '';
  var _currentBinaryValue = '';
  var _binaryController;
  var _decimalController;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _binaryController = TextEditingController(text: _currentBinaryValue);
    _decimalController = TextEditingController(text: _currentDecimalValue);
  }

  @override
  void dispose() {
    _binaryController.dispose();
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
              inputFormatters: [TextOnly01AndSpaceInputFormatter()],
              controller: _binaryController,
              onChanged: (value) {
                setState(() {
                  _currentBinaryValue = value;
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
        GCWDefaultOutput(
          child: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return _currentDecimalValue.split(' ').map((value) => convertBase(value, 10, 2)).join(' ');
    } else {
      return _currentBinaryValue.split(' ').map((value) => convertBase(value, 2, 10)).join(' ');
    }
  }
}