import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/wet_bulb_temperature.dart';
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

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
                        min: -20.0,
                        max: 50.0,
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
            min: 5.0,
            max: 99.0,
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
    String hintWBGT = '';
    String hintWBT = '';

    WBOutput output;
    if (_isMetric) {
      output = calculateWetBulbTemperature(_currentTemperature, _currentHumidity, TEMPERATURE_CELSIUS);
      unit = TEMPERATURE_CELSIUS.symbol;
    } else {
      output = calculateWetBulbTemperature(_currentTemperature, _currentHumidity, TEMPERATURE_FAHRENHEIT);
      unit = TEMPERATURE_FAHRENHEIT.symbol;
    }

    hintWBT = _calculateHintWBT(output.WBT, unit);

    var outputs = [];

    outputs.add(
        GCWOutput(
            title: i18n(context, 'wet_bulb_temperature_wbt_output'),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    child: GCWText(
                      text: output.WBT.toStringAsFixed(2) + ' ' + unit,
                    ),
                    padding: EdgeInsets.only(right: 2)),
                  ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    child: GCWIconButton(
                      icon: Icons.wb_sunny,
                      iconColor: _colorWBT(output.WBT, unit),
                    ),
                  padding: EdgeInsets.only(left: 2, right: 2)),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                      child: GCWText(
                        text: i18n(context, hintWBT),
                      ),
                      padding: EdgeInsets.only(left: 8)),
                ),
              ]
            )
        )
    );
    return GCWMultipleOutput(
      children: outputs,
    );
  }

  String _calculateHintWBT(double WBT, String unit){
    if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.PURPLE])
      if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.BLUE])
        if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.LIGHT_BLUE])
          if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.GREEN])
            if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.ORANGE])
              if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.RED])
                if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.RED])
                  return 'wet_bulb_temperature_index_wbt_dark_red';
                else
                  return 'wet_bulb_temperature_index_wbt_red';
              else
                return 'wet_bulb_temperature_index_wbt_orange';
            else
              return 'wet_bulb_temperature_index_wbt_green';
          else
            return 'wet_bulb_temperature_index_wbt_light_blue';
        else
          return 'wet_bulb_temperature_index_wbt_blue';
      else
        return 'wet_bulb_temperature_index_wbt_purple';
    else
      return 'wet_bulb_temperature_index_wbt_black';
  }

  Color _colorWBT(double WBT, String unit){
    if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.PURPLE])
      if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.BLUE])
        if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.LIGHT_BLUE])
          if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.GREEN])
            if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.ORANGE])
              if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.RED])
                if (WBT > WBT_HEAT_STRESS[unit][WBT_HEATSTRESS_CONDITION.DARK_RED])
                  return Colors.red[900];
                else
                  return Colors.red;
              else
                return Colors.orange;
            else
              return Colors.green;
          else
            return Colors.lightBlue[200];
        else
          return Colors.blue;
      else
        return Colors.purple;
    else
      return Colors.white;
  }
}
