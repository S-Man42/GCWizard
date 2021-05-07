import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class VanitySingleNumbers extends StatefulWidget {
  @override
  VanitySingleNumbersState createState() => VanitySingleNumbersState();
}

class VanitySingleNumbersState extends State<VanitySingleNumbers> {
  var _currentInput = '';

  PhoneModel _currentModel = NOKIA;

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
    return encodeVanitySingleNumbers(_currentInput, _currentModel);
  }
}

GCWDropDownButton buildVanityPhoneDropDownButton() {
  var modelList = [
    {
      'model': SIEMENS,
    }
  ];
}
