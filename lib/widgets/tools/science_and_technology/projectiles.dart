import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
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
        } else {
          calculate = 'projectiles_error';
          result = '0';
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
  }
}