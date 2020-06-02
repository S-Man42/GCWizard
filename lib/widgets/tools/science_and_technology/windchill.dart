import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/windchill.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Windchill extends StatefulWidget {
  @override
  WindchillState createState() => WindchillState();
}

class WindchillState extends State<Windchill> {
  double _currentTemperature = 0.0;
  double _currentWindSpeed = 0.0;
  GCWSwitchPosition _currentSpeedUnit = GCWSwitchPosition.left;
  var _isMetric = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDoubleSpinner(
          title: i18n(context, 'windchill_temperature'),
          value: _currentTemperature,
          onChanged: (value) {
            setState(() {
              _currentTemperature = value;
            });
          }
        ),
        GCWDoubleSpinner(
          title: i18n(context, 'windchill_windspeed'),
          value: _currentWindSpeed,
          min: 0.0,
          onChanged: (value) {
            setState(() {
              _currentWindSpeed = value;
            });
          }
        ),
        _isMetric
          ? GCWTwoOptionsSwitch(
            leftValue: 'km/h',
            rightValue: 'm/s',
            onChanged: (value) {
              setState(() {
                _currentSpeedUnit = value;
                _currentWindSpeed = value == GCWSwitchPosition.left ? _currentWindSpeed * 3.6 : _currentWindSpeed / 3.6;
              });
            },
          )
          : Container(),
        GCWTwoOptionsSwitch(
          title: 'System',
          leftValue: i18n(context, 'windchill_metric'),
          rightValue: i18n(context, 'windchill_imperial'),
          onChanged: (value) {
            setState(() {
              _isMetric = value == GCWSwitchPosition.left;
              _currentTemperature  = _isMetric ? (_currentTemperature - 32) * 5/9 : _currentTemperature * 9/5 + 32;
              double windSpeed = _currentSpeedUnit == GCWSwitchPosition.left ? _currentWindSpeed : _currentWindSpeed * 3.6;
              _currentWindSpeed = value == GCWSwitchPosition.left ? windSpeed * 1.609 : windSpeed / 1.609;
            });
          },
        ),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    double windSpeed = _currentSpeedUnit == GCWSwitchPosition.left ? _currentWindSpeed : _currentWindSpeed * 3.6;
    return '${calcWindchill(_currentTemperature, windSpeed, _isMetric)} ${String.fromCharCode(176)}${_isMetric ? 'C' : 'F'}';
  }
}
