import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/humidity.dart';
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/summer_simmer.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_input.dart';

class SummerSimmerIndex extends StatefulWidget {
  @override
  SummerSimmerIndexState createState() => SummerSimmerIndexState();
}

class SummerSimmerIndexState extends State<SummerSimmerIndex> {
  double _currentTemperature = 0.0;
  double _currentHumidity = 0.0;

  var _isMetric = true;

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
    String unit = '';

    double summersimmer = calculateSummerSimmerIndex(_currentTemperature, _currentHumidity);

    String hintT;
    if (_currentTemperature < 18) {
      hintT = i18n(context, 'summersimmer_hint_temperature');
    }

    String hintH;
    if (_currentHumidity < 40) hintH = i18n(context, 'summersimmer_hint_humidity');

    var hint = [hintT, hintH].where((element) => element != null && element.length > 0).join('\n');

    String hintSummerSimmer = _calculateHintSummerSimmer(summersimmer);

    return Column(
      children: [
        GCWDefaultOutput(
            child: summersimmer.toStringAsFixed(2),
            copyText: summersimmer.toString()
        ),
        Row(
          children: [
            Container(
                width: 50,
                child: GCWIconButton(
                    icon: Icons.wb_sunny,
                    iconColor: _colorSummerSimmer(summersimmer),
                    backgroundColor: Color(0xFF4d4d4d)
                ),
                padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)
            ),
            Expanded(
              child: GCWOutput(
                child: hint != '' ? hint : i18n(context, hintSummerSimmer),
              ),
            )
          ],
        )

      ],
    );

    var outputs = [
      GCWOutput(
        title: i18n(context, 'heatindex_output'),
        child: summersimmer.toStringAsFixed(3) + ' ' + unit,
      )
    ];

    if (hint != null && hint.length > 0) outputs.add(GCWOutput(title: i18n(context, 'heatindex_hint'), child: hint));

    if (hintSummerSimmer != null && hintSummerSimmer.length > 0)
      outputs.add(GCWOutput(title: i18n(context, 'heatindex_meaning'), child: i18n(context, hintSummerSimmer)));

    return GCWMultipleOutput(
      children: outputs,
    );
  }

  String _calculateHintSummerSimmer(double summersimmer){
    if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.LIGHT_BLUE])
      if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.WHITE])
        if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.LIGHT_YELLOW])
          if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.YELLOW])
            if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.ORANGE])
              if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.RED])
                  return 'summersimmerindex_index_red';
                else
                  return 'summersimmerindex_index_orange';
              else
                return 'summersimmerindex_index_yellow';
            else
              return 'summersimmerindex_index_light_yellow';
          else
            return 'summersimmerindex_index_white';
        else
          return 'summersimmerindex_index_light_blue';
      else
        return 'summersimmerindex_index_blue';
  }

  Color _colorSummerSimmer(double summersimmer){
      if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.LIGHT_BLUE])
        if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.WHITE])
          if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.LIGHT_YELLOW])
            if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.YELLOW])
              if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.ORANGE])
                if (summersimmer > SUMMERSIMMER_HEAT_STRESS[SUMMERSIMMER_HEATSTRESS_CONDITION.RED])
                  return Colors.red;
                else
                  return Colors.orange;
              else
                return Colors.yellow;
            else
              return Colors.yellowAccent;
          else
            return Colors.white;
        else
          return Colors.lightBlueAccent;
      else
        return Colors.blue;
  }
}
