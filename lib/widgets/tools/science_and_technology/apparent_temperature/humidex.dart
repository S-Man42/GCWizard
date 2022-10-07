import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/humidity.dart';
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/humidex.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_input.dart';

class Humidex extends StatefulWidget {
  @override
  HumidexState createState() => HumidexState();
}

class HumidexState extends State<Humidex> {
  double _currentTemperature = 0.0;
  double _currentHumidity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWUnitInput(
          value: _currentTemperature,
          title: i18n(context, 'common_measure_temperature'),
          initialUnit: TEMPERATURE_CELSIUS,
          min: 0.0,
          unitList: temperatures,
          onChanged: (value) {
            setState(() {
              _currentTemperature = TEMPERATURE_CELSIUS.fromKelvin(value);
            });
          },
        ),
        GCWUnitInput(
          value: _currentHumidity,
          title: i18n(context, 'common_measure_humidity'),
          initialUnit: HUMIDITY,
          min: 0.1,
          max:100.0,
          unitList: humidity,
          onChanged: (value) {
            setState(() {
              _currentHumidity = value;
            });
          },
        ),

        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    double humidex = calculateHumidex(_currentTemperature, _currentHumidity);

    String hintT;
    if (_currentTemperature < 21) {
      hintT = i18n(context, 'humidex_hint_temperature');
    }

    String hintH = '';
    if (_currentHumidity < 20) hintH = i18n(context, 'humidex_hint_humidity');

    var hint = [hintT, hintH].where((element) => element != null && element.length > 0).join('\n');

    String hintHumidex =  _calculateHintHumidex(humidex);

    return Column(
      children: [
        GCWDefaultOutput(
            child: humidex.toStringAsFixed(2),
            copyText: humidex.toString()
        ),
        Row(
          children: [
            Container(
                width: 50,
                child: GCWIconButton(
                    icon: Icons.wb_sunny,
                    iconColor: _colorHumidex(humidex),
                    backgroundColor: Color(0xFF4d4d4d)
                ),
                padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)
            ),
            Expanded(
              child: GCWOutput(
                child: hint != '' ? hint : i18n(context, hintHumidex),
              ),
            )
          ],
        )

      ],
    );
  }

  String _calculateHintHumidex(double humidex){
    if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.GREEN])
      if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.YELLOW])
        if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.ORANGE])
          if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.RED])
            return 'humidex_index_red';
          else
            return 'humidex_index_orange';
        else
          return 'humidex_index_yellow';
      else
        return 'humidex_index_green';
    else
      return 'humidex_index_white';
  }

  Color _colorHumidex(double humidex){
    if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.GREEN])
      if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.YELLOW])
        if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.ORANGE])
          if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.RED])
            return Colors.red;
          else
            return Colors.orange;
        else
          return Colors.yellow;
      else
        return Colors.green;
    else
      return Colors.lightBlueAccent;
  }

}
