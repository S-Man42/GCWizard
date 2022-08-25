import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/wet_bulb_temperature.dart';
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class WetBulbTemperature extends StatefulWidget {
  @override
  WetBulbTemperatureState createState() => WetBulbTemperatureState();
}

class WetBulbTemperatureState extends State<WetBulbTemperature> {
  double _currentTemperature = 0.0;
  double _currentHumidity = 0.0;

  var _isMetric = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(child: GCWText(text: i18n(context, 'common_measure_temperature')), flex: 1),
            Expanded(
                child: Column(
                  children: [
                    GCWTwoOptionsSwitch(
                      notitle: true,
                      leftValue: i18n(context, 'common_unit_temperature_degc_name'),
                      rightValue: i18n(context, 'common_unit_temperature_degf_name'),
                      value: _isMetric ? GCWSwitchPosition.left : GCWSwitchPosition.right,
                      onChanged: (value) {
                        setState(() {
                          _isMetric = value == GCWSwitchPosition.left;
                        });
                      },
                    ),
                    GCWDoubleSpinner(
                        value: _currentTemperature,
                        onChanged: (value) {
                          setState(() {
                            _currentTemperature = value;
                          });
                        }),
                  ],
                ),
                flex: 3)
          ],
        ),
        GCWDoubleSpinner(
            title: i18n(context, 'common_measure_humidity'),
            value: _currentHumidity,
            min: 0.0,
            max: 100.0,
            onChanged: (value) {
              setState(() {
                _currentHumidity = value;
              });
            }),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String unit = '';
    String hintT = '';
    String hintH = '';
    String hintM = '';

    double output;
    if (_isMetric) {
      output = calculateWetBulbTemperature(_currentTemperature, _currentHumidity, TEMPERATURE_CELSIUS);
      unit = TEMPERATURE_CELSIUS.symbol;
    } else {
      output = calculateWetBulbTemperature(_currentTemperature, _currentHumidity, TEMPERATURE_FAHRENHEIT);
      unit = TEMPERATURE_FAHRENHEIT.symbol;
    }

    if ((_isMetric && _currentTemperature < -20.0) || (!_isMetric && (_currentTemperature - 32) / 1.8 < -20.0)) {
      hintT = i18n(context, 'heatindex_hint_temperature_low', parameters: ['${_isMetric ? 27 : 80} $unit']);
    }
    if ((_isMetric && _currentTemperature > 50.0) || (!_isMetric && (_currentTemperature - 32) / 1.8 > 50.0)) {
      hintT = i18n(context, 'heatindex_hint_temperature_high', parameters: ['${_isMetric ? 27 : 80} $unit']);
    }

    if (_currentHumidity < 5) hintH = i18n(context, 'heatindex_hint_humidity_low');
    if (_currentHumidity > 99) hintH = i18n(context, 'heatindex_hint_humidity_high');

    var hint = [hintT, hintH].where((element) => element != null && element.length > 0).join('\n');

    if (output > HEAT_STRESS[unit][HEATSTRESS_CONDITION.WHITE]) if (output >
        HEAT_STRESS[unit]
            [HEATSTRESS_CONDITION.GREEN]) if (output > HEAT_STRESS[unit][HEATSTRESS_CONDITION.YELLOW]) if (output >
        HEAT_STRESS[unit][HEATSTRESS_CONDITION.RED])
      hintM = 'wet_bulb_temperature_index_black';
    else
      hintM = 'wet_bulb_temperature_index_red';
    else
      hintM = 'wet_bulb_temperature_index_yellow';
    else
      hintM = 'wet_bulb_temperature_index_green';
    else
      hintM = 'wet_bulb_temperature_index_white';

    var outputs = [
      GCWOutput(
        title: i18n(context, 'wet_bulb_temperature_output'),
        child: output.toStringAsFixed(2) + ' ' + unit,
      )
    ];

    if (hint != null && hint.length > 0)
      outputs.add(GCWOutput(title: i18n(context, 'wet_bulb_temperature_hint'), child: hint));

    if (hintM != null && hintM.length > 0)
      outputs.add(GCWOutput(title: i18n(context, 'wet_bulb_temperature_meaning'), child: i18n(context, hintM)));

    return GCWMultipleOutput(
      children: outputs,
    );
  }
}
