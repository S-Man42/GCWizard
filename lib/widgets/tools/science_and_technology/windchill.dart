import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/common_utils.dart';
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
  double _currentWindSpeed = 5.0;
  double _minWindSpeed = 5.0;
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
          min: _minWindSpeed,
          onChanged: (value) {
            setState(() {
              _currentWindSpeed = value;
            });
          }
        ),
        GCWTwoOptionsSwitch(
          title: 'System',
          leftValue: i18n(context, 'windchill_metric'),
          rightValue: i18n(context, 'windchill_imperial'),
          onChanged: (value) {
            setState(() {
              _isMetric = value == GCWSwitchPosition.left ? true : false;
              _minWindSpeed = value == GCWSwitchPosition.left ? 5.0 : 3.0;
              _currentWindSpeed = value == GCWSwitchPosition.left && _currentWindSpeed < 5.0 ? 5.0 : _currentWindSpeed;
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
    return '${calcWindchill(_currentTemperature, _currentWindSpeed, _isMetric)} ${String.fromCharCode(176)}${_isMetric ? 'C' : 'F'}';
  }
}
