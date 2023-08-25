import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_dropdown.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_input.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/windchill/logic/windchill.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/velocity.dart';
import 'package:intl/intl.dart';

class Windchill extends StatefulWidget {
  const Windchill({Key? key}) : super(key: key);

  @override
 _WindchillState createState() => _WindchillState();
}

class _WindchillState extends State<Windchill> {
  double _currentTemperature = 0.0;
  double _currentWindSpeed = 0.0;

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
          value: _currentWindSpeed,
          title: i18n(context, 'common_measure_windspeed'),
          initialUnit: VELOCITY_MS,
          min: 0.0,
          max: 100.0,
          unitList: velocities,
          onChanged: (value) {
            setState(() {
              _currentWindSpeed = VELOCITY_MS.fromReference(value);
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'common_outputunit')),
        GCWUnitDropDown(
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
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  Widget _buildOutput() {
    double windchill =   0.0;
    double windchill_c =   0.0;

    windchill_c = calcWindchill(_currentTemperature, _currentWindSpeed);

    windchill = TEMPERATURE_CELSIUS.toKelvin(windchill_c);
    windchill = _currentOutputUnit.fromReference(windchill);

    return GCWDefaultOutput(
        child: Row(children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(i18n(context, 'windchill_title')),
          ),
          Expanded(
            flex: 1,
            child: Text(_currentOutputUnit.symbol),
          ),
          Expanded(
            flex: 2,
            child: GCWOutput(
                child: NumberFormat('#.###').format(windchill)),
          ),
        ]
        )
    );
  }
}
