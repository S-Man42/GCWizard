import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/heat.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Heat extends StatefulWidget {
  @override
  HeatState createState() => HeatState();
}

class HeatState extends State<Heat> {

  double _currentTemperature = 0.0;
  double _currentHumidity = 0.0;
  String _currentOutput = '';

  var _isMetric = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDoubleSpinner(
            title: i18n(context, 'heat_temperature'),
            value: _currentTemperature,
            onChanged: (value) {
              setState(() {
                _currentTemperature = value;
              });
            }
        ),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'heat_degree'),
          leftValue: i18n(context, 'heat_degree_celsius'),
          rightValue: i18n(context, 'heat_degree_fahrenheit'),
          value: _isMetric ? GCWSwitchPosition.left : GCWSwitchPosition.right,
          onChanged: (value) {
            setState(() {
              _isMetric = value == GCWSwitchPosition.left;
            });
          },
        ),

        GCWDoubleSpinner(
            title: i18n(context, 'heat_humidity'),
            value: _currentHumidity,
            min: 0.0,
            onChanged: (value) {
              setState(() {
                _currentHumidity = value;
              });
            }
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String degree = '';
    String hint = '';
    String hintT = 'heat_hint_noHint';
    String hintH = 'heat_hint_noHint';
    String hintM = 'heat_hint_noHint';

    if (_isMetric) {
      _currentOutput = calculateHeat(_currentTemperature, _currentHumidity, HeatTemperatureMode.Celsius);
      degree = ' °C';
    } else {
      _currentOutput = calculateHeat(_currentTemperature, _currentHumidity, HeatTemperatureMode.Fahrenheit);
      degree = ' °F';
    }

    if (_isMetric && _currentTemperature < 27)
      hintT = 'heat_hint_temperature_C';
    else
    if (!_isMetric && _currentTemperature < 80)
      hintT = 'heat_hint_temperature_F';

    if (_currentHumidity < 40)
      hintH = 'heat_hint_humidity';

    if (hintT == 'heat_hint_noHint')
      hint = i18n(context, hintH) ;
    else
      hint = i18n(context, hintT) + '\n' + i18n(context, hintH);

    if (double.parse(_currentOutput) > 54)
      hintM = 'heat_index_54';
    else
      if (double.parse(_currentOutput) > 40)
        hintM = 'heat_index_40';
      else
        if (double.parse(_currentOutput) > 32)
          hintM = 'heat_index_32';
        else
          if (double.parse(_currentOutput) > 27)
            hintM = 'heat_index_27';

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWTextDivider(
              text: i18n(context, 'heat_output')
          ),

          GCWOutputText(
              text: _currentOutput + degree
          ),

          GCWTextDivider(
              text: i18n(context, 'heat_hint')
          ),

          GCWOutputText(
                text: hint
          ),

          GCWTextDivider(
              text: i18n(context, 'heat_meaning')
          ),

          GCWOutputText(
              text: i18n(context, hintM)
          ),
        ],
      ),
    );
  }
}
