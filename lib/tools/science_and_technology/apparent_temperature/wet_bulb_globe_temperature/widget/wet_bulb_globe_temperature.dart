import 'package:flutter/material.dart';

import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_text_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_input.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_dropdown.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/humidity.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/pressure.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/velocity.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/wet_bulb_globe_temperature/logic/wet_bulb_globe_temperature.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';

class WetBulbGlobeTemperature extends StatefulWidget {
  const WetBulbGlobeTemperature({Key? key}) : super(key: key);

  @override
  WetBulbGlobeTemperatureState createState() => WetBulbGlobeTemperatureState();
}

class WetBulbGlobeTemperatureState extends State<WetBulbGlobeTemperature> {
  DateTimeTimezone _currentDateTime = DateTimeTimezone(datetime: DateTime.now(), timezone: DateTime.now().timeZoneOffset);
  BaseCoordinate _currentCoords = defaultBaseCoordinate;

  double _currentTemperature = 0.0;
  double _currentHumidity = 0.0;
  double _currentWindSpeed = 1.0;
  final double _currentWindSpeedHeight = 2.0;
  double _currentAirPressure = 1013.25;
  bool _currentAreaUrban = true;
  CLOUD_COVER _currentCloudCover = CLOUD_COVER.CLEAR_0;

  Unit _currentOutputUnit = TEMPERATURE_CELSIUS;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWExpandableTextDivider(
          text: i18n(context, 'common_location'),
          child: GCWCoords(
            title: i18n(context, 'common_location'),
            coordsFormat: _currentCoords.format,
            onChanged: (BaseCoordinate ret) {
              setState(() {
                _currentCoords = ret;
              });
            },
          ),
        ),
        GCWExpandableTextDivider(
          text: i18n(context, 'astronomy_postion_datetime'),
          child: GCWDateTimePicker(
            config: const {
              DateTimePickerConfig.DATE,
              DateTimePickerConfig.TIME,
              DateTimePickerConfig.TIMEZONES,
              DateTimePickerConfig.SECOND_AS_INT
            },
            onChanged: (datetime) {
              setState(() {
                _currentDateTime = datetime;
              });
            },
          ),
        ),
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
          unitList: humidity,
          onChanged: (value) {
            setState(() {
              _currentHumidity = value;
            });
          },
        ),
        GCWUnitInput(
          value: _currentAirPressure,
          title: i18n(context, 'common_measure_airpressure'),
          initialUnit: PRESSURE_MBAR,
          unitList: allPressures(),
          onChanged: (value) {
            setState(() {
              _currentAirPressure = value;
            });
          },
        ),
        GCWUnitInput(
          value: _currentWindSpeed,
          title: i18n(context, 'common_measure_windspeed'),
          initialUnit: VELOCITY_MS,
          unitList: velocities,
          onChanged: (value) {
            setState(() {
              _currentWindSpeed = value;
            });
          },
        ),
        GCWDropDown(
          title: i18n(context, 'wet_bulb_globe_temperature_cloud'),
          value: _currentCloudCover,
          onChanged: (value) {
            setState(() {
              _currentCloudCover = value;
            });
          },
        items: CLOUD_COVER_LIST.entries.map((entry) {
          return GCWDropDownMenuItem(
            value: entry.key,
            child: i18n(context, entry.value),
          );
        }).toList(),
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'wet_bulb_globe_temperature_area'),
          leftValue: i18n(context, 'wet_bulb_globe_temperature_area_urban'),
          rightValue: i18n(context, 'wet_bulb_globe_temperature_area_rural'),
          value: _currentAreaUrban ? GCWSwitchPosition.left : GCWSwitchPosition.right,
          onChanged: (value) {
            setState(() {
              _currentAreaUrban = value == GCWSwitchPosition.left;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'common_outputunit')),
        GCWUnitDropDown<Unit>(
          value: _currentOutputUnit,
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
    WBGTOutput output = calculateWetBulbGlobeTemperature(
        _currentDateTime,
        _currentCoords.toLatLng()!,
        _currentWindSpeed,
        _currentWindSpeedHeight,
        _currentTemperature,
        _currentHumidity,
        _currentAirPressure,
        _currentAreaUrban,
        _currentCloudCover);
    if (output.Status == -1) {
      print('-1');
      return Container();
    }

    String unit = _currentOutputUnit.symbol;
    String hintWBGT = _calculateHintWBGT(output.Twbg);
    double WBGT = _currentOutputUnit.fromReference(TEMPERATURE_CELSIUS.toKelvin(output.Twbg));

    var _outputFurtherInformation = [
      [
        i18n(context, 'common_measure_solar_irradiance'),
        output.Solar.toStringAsFixed(2) + ' W/m²',
      ],
      [
        i18n(context, 'common_measure_dewpoint'),
        _currentOutputUnit.fromReference(TEMPERATURE_CELSIUS.toKelvin(output.Tdew)).toStringAsFixed(2) + ' ' + unit
      ],
      [i18n(context, 'astronomy_sunposition_title'), ''],
      [i18n(context, 'astronomy_position_altitude'), output.SunPos.altitude.toStringAsFixed(2) + ' °'],
      [i18n(context, 'astronomy_position_azimuth'), output.SunPos.azimuth.toStringAsFixed(2) + ' °'],
    ];

    return Column(
      children: [
        GCWDefaultOutput(
            child: GCWColumnedMultilineOutput(
              flexValues: [4, 2, 1],
                copyColumn: 1,
                data: [
                  ['WBGT', WBGT.toStringAsFixed(2), unit],
                  //[i18n(context, 'heatindex_title'), calculateHeatIndex(_currentTemperature, _currentHumidity, TEMPERATURE_FAHRENHEIT).toStringAsFixed(2), ''],
                  //[i18n(context, 'humidex_title'), '', ''],
                  //[i18n(context, 'summersimmerindex_title'), '', ''],
                  //[i18n(context, 'windchill_title'), '', ''],
                ]
            )
        ),
        //WBGT.toStringAsFixed(2) + ' ' + unit, copyText: WBGT.toString()),
        Row(
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
              child: GCWIconButton(
                icon: Icons.wb_sunny,
                iconColor: _colorWBGT(output.Twbg),
                backgroundColor: const Color(0xFF4d4d4d),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: GCWOutput(
                child: i18n(context, hintWBGT),
              ),
            )
          ],
        ),
        GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'common_further_information'),
          //child: Column(children: columnedMultiLineOutput(context, _outputFurtherInformation)),
          child: GCWColumnedMultilineOutput(data: _outputFurtherInformation),
        )
      ],
    );
  }

  String _calculateHintWBGT(double WBGT) {
    if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.WHITE]!) {
      if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.GREEN]!) {
        if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.YELLOW]!) {
          if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.RED]!) {
            return 'wet_bulb_globe_temperature_index_wbgt_black';
          } else {
            return 'wet_bulb_globe_temperature_index_wbgt_red';
          }
        } else {
          return 'wet_bulb_globe_temperature_index_wbgt_yellow';
        }
      } else {
        return 'wet_bulb_globe_temperature_index_wbgt_green';
      }
    } else {
      return 'wet_bulb_globe_temperature_index_wbgt_white';
    }
  }

  Color _colorWBGT(double WBGT) {
    if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.WHITE]!) {
      if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.GREEN]!) {
        if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.YELLOW]!) {
          if (WBGT > WBGT_HEAT_STRESS[WBGT_HEATSTRESS_CONDITION.RED]!) {
            return Colors.black;
          } else {
            return Colors.red;
          }
        } else {
          return Colors.yellow;
        }
      } else {
        return Colors.green;
      }
    } else {
      return Colors.white;
    }
  }
}
