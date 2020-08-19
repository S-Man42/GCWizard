import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/utils/units/velocity.dart';
import 'package:gc_wizard/widgets/common/base/gcw_button.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_encrypt_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Projectiles extends StatefulWidget {
  @override
  ProjectilesState createState() => ProjectilesState();
}

class ProjectilesState extends State<Projectiles> {
  double _currentEnergy = 0.0;
  double _currentMass = 0.0;
  double _currentSpeed = 0.0;
  GCWSwitchPosition _currentSpeedUnit = GCWSwitchPosition.left;
  var _isMetric = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDoubleSpinner(
            title: i18n(context, 'projectiles_energy'),
            min: 0.0,
            value: _currentEnergy,
            onChanged: (value) {
              setState(() {
                _currentEnergy = value;
              });
            }
        ),
        GCWDoubleSpinner(
            title: i18n(context, 'projectiles_mass'),
            min: 0.0,
            value: _currentMass,
            onChanged: (value) {
              setState(() {
                _currentMass = value;
              });
            }
        ),
        GCWDoubleSpinner(
            title: i18n(context, 'projectiles_speed'),
            value: _currentSpeed,
            min: 0.0,
            onChanged: (value) {
              setState(() {
                _currentSpeed = value;
              });
            }
        ),
            _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String calculate = '';
    String result = '';

    if (_currentEnergy == 0) {
      calculate = 'projectiles_energy';
      result = calculateEnergy(_currentMass, _currentSpeed).toStringAsFixed(3);
    } else
      if (_currentMass == 0) {
        calculate = 'projectiles_mass';
        result = calculateMass(_currentEnergy, _currentSpeed).toStringAsFixed(3);
      } else
        if (_currentSpeed == 0) {
          calculate = 'projectiles_speed';
          result = calculateSpeed(_currentEnergy, _currentMass).toStringAsFixed(3);
        }

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWTextDivider(
              text: i18n(context, calculate)
          ),

          GCWOutputText(
              text: result
          ),
        ],
      ),
    );

/*

    var windchill;
    var temperature;

    if (_isMetric) {
      windchill = _currentSpeedUnit == GCWSwitchPosition.left
          ? calcWindchillMetric(_currentTemperature, _currentWindSpeed)
          : calcWindchillMetricMS(_currentTemperature, _currentWindSpeed);

      temperature = TEMPERATURE_CELSIUS;
    } else {
      windchill = calcWindchillImperial(_currentTemperature, _currentWindSpeed);
      temperature = TEMPERATURE_FAHRENHEIT;
    }

    return '${NumberFormat('#.###').format(windchill)} ${temperature.symbol}';
  }
*/
  }


/*
  var _inputControllerEnergy;
  var _inputControllerMass;
  var _inputControllerSpeed;
  var _currentOutput = ProjectilesOutput('', '', '');

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
        GCWTextDivider(
            text: i18n(context, 'Projectiles_energy')
        ),
        GCWTextField(
          controller: _inputControllerEnergy,
          hintText: i18n(context, 'Projectiles_energy'),
          onChanged: (text) {
            setState(() {
              _currentInputEnergy = text;
            });
          },
        ),
        GCWTextDivider(
            text: i18n(context, 'Projectiles_mass')
        ),
        GCWTextField(
          controller: _inputControllerMass,
          hintText: i18n(context, 'Projectiles_mass'),
          onChanged: (text) {
            setState(() {
              _currentInputMass = text;
            });
          },
        ),
        GCWTextDivider(
            text: i18n(context, 'Projectiles_speed')
        ),
        GCWTextField(
          controller: _inputControllerSpeed,
          hintText: i18n(context, 'Projectiles_speed'),
            onChanged: (text) {
              setState(() {
                _currentInputSpeed = text;
              });
            },
        ),

        GCWButton(
          text: i18n(context, 'Projectiles_calculate'),
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
            GCWTextDivider(
                text: i18n(context, _currentOutput.formula)
            ),
            GCWOutputText(
                text: _currentOutput.output
            ),
          ],
        ),
      );
    }
  }
*/
}