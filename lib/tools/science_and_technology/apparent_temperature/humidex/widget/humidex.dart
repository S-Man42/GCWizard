import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_input.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/humidex/logic/humidex.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/humidity.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/temperature.dart';
import 'package:intl/intl.dart';

class Humidex extends StatefulWidget {
  const Humidex({Key? key}) : super(key: key);

  @override
  _HumidexState createState() => _HumidexState();
}

class _HumidexState extends State<Humidex> {
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
          max: 100.0,
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

    String hintT = '';
    if (_currentTemperature < 21) {
      hintT = i18n(context, 'humidex_hint_temperature');
    }

    String hintH = '';
    if (_currentHumidity < 20) hintH = i18n(context, 'humidex_hint_humidity');

    var hint = [hintT, hintH].where((element) => element.isNotEmpty).join('\n');

    String hintHumidex = _calculateHintHumidex(humidex);

    return Column(
      children: [
        GCWDefaultOutput(
            child: Row(children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(i18n(context, 'humidex_title')),
              ),
              Expanded(
                flex: 1,
                child: Text(''),
              ),
              Expanded(
                flex: 2,
                child: GCWOutput(
                    child: NumberFormat('#.###').format(humidex)),
              ),
            ]
            )
        ),
        Row(
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
              child: GCWIconButton(
                icon: Icons.wb_sunny,
                iconColor: _colorHumidex(humidex),
                backgroundColor: const Color(0xFF4d4d4d),
                onPressed: () {},
              ),
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

  String _calculateHintHumidex(double humidex) {
    if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.GREEN]!) {
      if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.YELLOW]!) {
        if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.ORANGE]!) {
          if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.RED]!) {
            return 'humidex_index_red';
          } else {
            return 'humidex_index_orange';
          }
        } else {
          return 'humidex_index_yellow';
        }
      } else {
        return 'humidex_index_green';
      }
    } else {
      return 'humidex_index_white';
    }
  }

  Color _colorHumidex(double humidex) {
    if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.GREEN]!) {
      if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.YELLOW]!) {
        if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.ORANGE]!) {
          if (humidex > HUMIDEX_HEAT_STRESS[HUMIDEX_HEATSTRESS_CONDITION.RED]!) {
            return Colors.red;
          } else {
            return Colors.orange;
          }
        } else {
          return Colors.yellow;
        }
      } else {
        return Colors.green;
      }
    } else {
      return Colors.lightBlueAccent;
    }
  }
}
