import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/geschoss.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_encrypt_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Geschoss extends StatefulWidget {
  @override
  GeschossState createState() => GeschossState();
}

class GeschossState extends State<Geschoss> {
  var _inputControllerEnergy;
  var _inputControllerMass;
  var _inputControllerSpeed;
  var _currentOutput = GeschossOutput('', '');

  String _currentInputEnergy = '';
  String _currentInputMass = '';
  String _currentInputSpeed = '';

  @override
  void initState() {
    super.initState();
    _inputControllerEnergy = TextEditingController(text: _currentInputEnergy);
    _inputControllerMass = TextEditingController(text: _currentInputMass);
    _inputControllerSpeed = TextEditingController(text: _currentInputSpeed);
  }

  @override
  void dispose() {
    _inputControllerEnergy.dispose();
    _inputControllerMass.dispose();
    _inputControllerSpeed.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputControllerEnergy,
          hintText: i18n(context, 'geschoss_energy'),
          onChanged: (text) {
            setState(() {
              _currentInputEnergy = text;
            });
          },
        ),
        GCWTextField(
          controller: _inputControllerMass,
          hintText: i18n(context, 'geschoss_mass'),
          onChanged: (text) {
            setState(() {
              _currentInputMass = text;
            });
          },
        ),
        GCWTextField(
          controller: _inputControllerSpeed,
          hintText: i18n(context, 'geschoss_speed'),
            onChanged: (text) {
              setState(() {
                _currentInputSpeed = text;
              });
            },
        ),

        GCWTextDivider(
            text: i18n(context, 'common_alphabet')
        ),

        GCWButton(
          text: i18n(context, 'geschoss_calculate'),
          onPressed: () {
            if (_currentInputEnergy == null || _currentInputEnergy.length == 0) {
              setState(() {
                _currentOutput = calculateEnergy(_currentInputMass, _currentInputSpeed);
              });
            } else {
              if (_currentInputMass == null || _currentInputMass.length == 0) {
                setState(() {
                  _currentOutput = calculateMass(_currentInputEnergy, _currentInputSpeed);
                });
              } else {
                setState(() {
                  _currentOutput = calculateSpeed(_currentInputEnergy, _currentInputMass);
                });
              }
            }
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentOutput.state == 'ERROR') {
      showToast(i18n(context, _currentOutput.output));
      return GCWDefaultOutput(
          text: '' //TODO: Exception
      );
    } else {
      return GCWOutput(
        child: Column(
          children: <Widget>[
            GCWOutputText(
                text: _currentOutput.output
            ),
          ],
        ),
      );
    }
  }
}
