import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/humidity.dart';
import 'package:gc_wizard/logic/common/units/temperature.dart';
import 'package:gc_wizard/logic/common/units/unit.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/apparent_temperature/heat_index.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_input.dart';

class HeatIndex extends StatefulWidget {
  @override
  HeatIndexState createState() => HeatIndexState();
}

class HeatIndexState extends State<HeatIndex> {
  double _currentTemperature = 1.0;
  double _currentHumidity = 0.0;

  //Map<String, dynamic> _currentOutputUnit = {'unit': TEMPERATURE_CELSIUS, 'prefix': UNITPREFIX_NONE};
  Unit _currentOutputUnit = TEMPERATURE_CELSIUS;

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
          min: 0.0,
          max:100.0,
          unitList: humidity,
          onChanged: (value) {
            setState(() {
              _currentHumidity = value;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'common_outputunit')),
        GCWUnitDropDownButton(
          value: _currentOutputUnit,
          onlyShowSymbols: false,
          unitList: temperatures,
          unitCategory: UNITCATEGORY_TEMPERATURE,
          onChanged: (value) {
            setState(() {
              _currentOutputUnit = value;
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String unit = '';
    String hintHeatIndex = '';
    double HeatIndex_C = 0.0;
    double HeatIndex = 0.0;

    HeatIndex_C = calculateHeatIndex(_currentTemperature, _currentHumidity);
    hintHeatIndex = _calculateHintHeatIndex(HeatIndex_C);

    HeatIndex = TEMPERATURE_CELSIUS.toKelvin(HeatIndex_C);
    HeatIndex = _currentOutputUnit.fromReference(HeatIndex);

    unit = _currentOutputUnit.symbol;

    String hintT = '';
    if (_currentTemperature < 27) {
      hintT = i18n(context, 'heatindex_hint_temperature');
    }

    String hintH = '';
    if (_currentHumidity < 40) hintH = i18n(context, 'heatindex_hint_humidity');

    var hint = [hintT, hintH].where((element) => element != null && element.length > 0).join('\n');

    return Column(
      children: [
        GCWDefaultOutput(
            child: HeatIndex.toStringAsFixed(2) + ' ' + unit,
            copyText: HeatIndex.toString()
        ),
        Row(
          children: [
            Container(
                width: 50,
                child: GCWIconButton(
                    icon: Icons.wb_sunny,
                    iconColor: _colorHeatIndex(HeatIndex_C),
                    backgroundColor: Color(0xFF4d4d4d)
                ),
                padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)
            ),
            Expanded(
              child: GCWOutput(
                child: hint != '' ? hint : i18n(context, hintHeatIndex),
              ),
            )
          ],
        )

      ],
    );
  }

  String _calculateHintHeatIndex(double HeatIndex){
    if (HeatIndex > HEATINDEX_HEAT_STRESS[HEATINDEX_HEATSTRESS_CONDITION.LIGHT_YELLOW])
      if (HeatIndex > HEATINDEX_HEAT_STRESS[HEATINDEX_HEATSTRESS_CONDITION.YELLOW])
        if (HeatIndex > HEATINDEX_HEAT_STRESS[HEATINDEX_HEATSTRESS_CONDITION.ORANGE])
          if (HeatIndex > HEATINDEX_HEAT_STRESS[HEATINDEX_HEATSTRESS_CONDITION.RED])
            return 'heatindex_index_red';
          else
            return 'heatindex_index_orange';
        else
          return 'heatindex_index_yellow';
      else
        return 'heatindex_index_light_yellow';
    else
      return 'heatindex_index_white';
  }

  Color _colorHeatIndex(double HeatIndex){
        if (HeatIndex > HEATINDEX_HEAT_STRESS[HEATINDEX_HEATSTRESS_CONDITION.LIGHT_YELLOW])
          if (HeatIndex > HEATINDEX_HEAT_STRESS[HEATINDEX_HEATSTRESS_CONDITION.YELLOW])
            if (HeatIndex > HEATINDEX_HEAT_STRESS[HEATINDEX_HEATSTRESS_CONDITION.ORANGE])
              if (HeatIndex > HEATINDEX_HEAT_STRESS[HEATINDEX_HEATSTRESS_CONDITION.RED])
                  return Colors.red;
              else
                return Colors.orange;
            else
              return Colors.yellow;
          else
            return Colors.yellowAccent;
        else
          return Colors.white;
  }
}
