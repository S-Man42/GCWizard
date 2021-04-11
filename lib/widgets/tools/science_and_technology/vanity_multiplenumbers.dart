import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class VanityMultipleNumbers extends StatefulWidget {
  @override
  VanityMultipleNumbersState createState() => VanityMultipleNumbersState();
}

class VanityMultipleNumbersState extends State<VanityMultipleNumbers> {
  var _controller;

  var _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  PhoneModel _currentModel = NOKIA;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput);
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
        GCWTextField(
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
            });
          },
        ),
        GCWDropDownButton(
            value: _currentModel,
            onChanged: (newValue) {
              setState(() {
                _currentModel = newValue;
              });
            },
            items: PHONE_MODELS.map((model) {
              var spaceText;
              switch (model.keySpace) {
                case PhoneKeySpace.SPACE_ON_KEY_0:
                  spaceText = i18n(context, 'vanity_numberforspace_0');
                  break;
                case PhoneKeySpace.SPACE_ON_KEY_1:
                  spaceText = i18n(context, 'vanity_numberforspace_1');
                  break;
              }

              return GCWDropDownMenuItem(value: model, child: '$spaceText (${model.name})');
            }).toList()),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encodeVanityMultipleNumbers(_currentInput, _currentModel);
    } else {
      return decodeVanityMultipleNumbers(_currentInput, _currentModel);
    }
  }
}
