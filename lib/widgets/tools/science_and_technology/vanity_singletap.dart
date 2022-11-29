import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/vanity/phone_models.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/vanity/vanity.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class VanitySingletap extends StatefulWidget {
  @override
  VanitySingletapState createState() => VanitySingletapState();
}

class VanitySingletapState extends State<VanitySingletap> {
  var _currentInput = '';

  PhoneModel _currentModel = PHONEMODEL_SIMPLE_SPACE_0;

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
            items: [
              PHONEMODEL_SIMPLE_SPACE_0,
              PHONEMODEL_SIMPLE_SPACE_1,
              PHONEMODEL_SIMPLE_SPACE_HASH,
              PHONEMODEL_SIMPLE_SPACE_ASTERISK,
            ].map((model) {
              return GCWDropDownMenuItem(value: model, child: i18n(context, model.name));
            }).toList()),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    return encodeVanitySingletap(_currentInput.toUpperCase(), _currentModel);
  }
}
