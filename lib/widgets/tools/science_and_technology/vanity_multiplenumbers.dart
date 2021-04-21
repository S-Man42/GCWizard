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
  var _encodeController;
  var _decodeController;

  var _currentDecodeInput = '';
  var _currentEncodeInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  PhoneModel _currentModel = NOKIA;

  bool _currentEncodeCaseSensitive = false;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _encodeController,
                onChanged: (text) {
                  setState(() {
                    _currentEncodeInput = text;
                  });
                },
              )
            : GCWTextField(
                controller: _decodeController,
                onChanged: (text) {
                  setState(() {
                    _currentDecodeInput = text;
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
        // if (_currentMode == GCWSwitchPosition.left)
        //   GCWOnOffSwitch(
        //     title: i18n(context, 'vanity_multiplenumbers_case_sensitive'),
        //     value: _currentEncodeCaseSensitive,
        //     onChanged: (value) {
        //       setState(() {
        //         _currentEncodeCaseSensitive = value;
        //       });
        //     },
        //   ),
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
      return encodeVanityMultipleNumbers(_currentEncodeInput, _currentModel,
          caseSensitive: _currentEncodeCaseSensitive);
    } else {
      return decodeVanityMultipleNumbers(_currentDecodeInput, _currentModel).output;
    }
  }
}
