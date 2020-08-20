import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class VanityMultipleNumbers extends StatefulWidget {
  @override
  VanityMultipleNumbersState createState() => VanityMultipleNumbersState();
}

class VanityMultipleNumbersState extends State<VanityMultipleNumbers> {
  var _controller;

  var _currentInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentNumberForSpaceMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput['text']);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
          ? GCWTextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  _currentInput = {'text': text, 'values' : []};
                });
              },
            )
          : GCWIntegerListTextField(
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  _currentInput = text;
                });
              },
            ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;

              if (_currentMode == GCWSwitchPosition.right) {
                var text = _currentInput['text'];
                _currentInput = {'text': text, 'values': textToIntList(text)};
              }
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
          ? GCWTwoOptionsSwitch(
              title: i18n(context, 'vanity_numberforspace'),
              leftValue: '0',
              rightValue: '1',
              value: _currentNumberForSpaceMode,
              onChanged: (value) {
                setState(() {
                  _currentNumberForSpaceMode = value;
                });
              },
            )
          : Container(),
        GCWDefaultOutput(
          child: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encodeVanityMultipleNumbers(_currentInput['text'], numberForSpace: _currentNumberForSpaceMode == GCWSwitchPosition.right ? '1' : '0');
    } else {
      return decodeVanityMultipleNumbers(_currentInput['values']);
    }
  }
}