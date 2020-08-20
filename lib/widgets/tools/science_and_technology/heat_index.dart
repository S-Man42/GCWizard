import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/heat_index.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class HeatIndex extends StatefulWidget {
  @override
  HeatIndexState createState() => HeatIndexState();
}

class HeatIndexState extends State<HeatIndex> {

  double _currentTemperature = 0.0;
  double _currentHumidity = 0.0;
  String _currentOutput = '';

  var _isMetric = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWDoubleSpinner(
          title: i18n(context, 'heatindex_temperature'),
          value: _currentTemperature,
          onChanged: (value) {
            setState(() {
              _currentTemperature = value;
            });
          }
        ),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'heatindex_unit'),
          leftValue: i18n(context, 'heatindex_unit_celsius'),
          rightValue: i18n(context, 'heatindex_unit_fahrenheit'),
          value: _isMetric ? GCWSwitchPosition.left : GCWSwitchPosition.right,
          onChanged: (value) {
            setState(() {
              _isMetric = value == GCWSwitchPosition.left;
            });
          },
        ),

        GCWDoubleSpinner(
          title: i18n(context, 'heatindex_humidity'),
          value: _currentHumidity,
          min: 0.0,
          max: 100.0,
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
    String unit = '';
    String hintT;
    String hintH;
    String hintM;

    if (_isMetric) {
      _currentOutput = calculateHeatIndex(_currentTemperature, _currentHumidity, HeatTemperatureMode.CELSIUS);
      unit = ' °C';
    } else {
      _currentOutput = calculateHeatIndex(_currentTemperature, _currentHumidity, HeatTemperatureMode.FAHRENHEIT);
      unit = ' °F';
    }

    if (_isMetric && _currentTemperature < 27)
      hintT = 'heatindex_hint_temperature_c';
    else
    if (!_isMetric && _currentTemperature < 80)
      hintT = 'heatindex_hint_temperature_f';

    if (_currentHumidity < 40)
      hintH = 'heatindex_hint_humidity';

    String hint;
    if (hintT == null)
      hint = i18n(context, hintH) ;
    else
      hint = i18n(context, hintT) + '\n' + i18n(context, hintH);

    if (double.parse(_currentOutput) > 54)
      hintM = 'heatindex_index_54';
    else
      if (double.parse(_currentOutput) > 40)
        hintM = 'heatindex_index_40';
      else
        if (double.parse(_currentOutput) > 32)
          hintM = 'heatindex_index_32';
        else
          if (double.parse(_currentOutput) > 27)
            hintM = 'heatindex_index_27';

    var outputs = [
      GCWOutput(
        title: i18n(context, 'heatindex_output'),
        child: _currentOutput + unit,
      )
    ];

    if (hint != null && hint.length > 0)
      outputs.add(
        GCWOutput(
          title: i18n(context, 'heatindex_hint'),
          child: hint
        )
      );

    if (hintM != null && hintM.length > 0)
      outputs.add(
        GCWOutput(
          title: i18n(context, 'heatindex_meaning'),
          child: i18n(context, hintM)
        )
      );

    return GCWMultipleOutput(
      children: outputs,
    );
  }
}
