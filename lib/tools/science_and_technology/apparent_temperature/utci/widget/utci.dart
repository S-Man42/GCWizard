import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';

import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/coordinates/gcw_coords/gcw_coords.dart';
import 'package:gc_wizard/common_widgets/dividers/gcw_divider.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_datetime_picker.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_columned_multiline_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_dropdown.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_input.dart';
import 'package:gc_wizard/tools/coords/_common/logic/coordinates.dart';
import 'package:gc_wizard/tools/coords/_common/logic/default_coord_getter.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/_common/logic/common.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/humidity.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/pressure.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/temperature.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/velocity.dart';
import 'package:gc_wizard/tools/science_and_technology/apparent_temperature/utci/logic/utci.dart';
import 'package:gc_wizard/utils/complex_return_types.dart';
import 'package:intl/intl.dart';

class UTCI extends StatefulWidget {
  const UTCI({Key? key}) : super(key: key);

  @override
  UTCIState createState() => UTCIState();
}

class UTCIState extends State<UTCI> {
  double _currentTemperature = 0.0;
  double _currentTemperatureMRT = 0.0;
  double _currentHumidity = 0.0;
  double _currentWindSpeed = 0.5;

  DateTimeTimezone _currentDateTime =
      DateTimeTimezone(datetime: DateTime.now(), timezone: DateTime.now().timeZoneOffset);
  BaseCoordinate _currentCoords = defaultBaseCoordinate;
  double _currentAirPressure = 1013.25;
  bool _currentAreaUrban = true;
  CLOUD_COVER _currentCloudCover = CLOUD_COVER.CLEAR_0;

  Temperature _currentOutputUnit = TEMPERATURE_CELSIUS;
  GCWSwitchPosition _currentTMRTmode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWUnitInput(
          value: _currentTemperature,
          title: i18n(context, 'common_measure_temperature'),
          initialUnit: TEMPERATURE_CELSIUS,
          min: -50.0,
          max: 50.0,
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
          max: 100.0,
          unitList: humidity,
          onChanged: (value) {
            setState(() {
              _currentHumidity = value;
            });
          },
        ),
        GCWUnitInput(
          value: _currentWindSpeed,
          title: i18n(context, 'common_measure_windspeed'),
          initialUnit: VELOCITY_MS,
          min: 0.0,
          max: 17.0,
          unitList: velocities,
          onChanged: (value) {
            setState(() {
              _currentWindSpeed = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
            title: i18n(context, 'utci_tmrt'),
            leftValue: i18n(context, 'utci_tmrt_known'),
            rightValue: i18n(context, 'utci_tmrt_calculate'),
            onChanged: (value) {
              setState(() {
                _currentTMRTmode = value;
              });
            },
            value: _currentTMRTmode),
        _currentTMRTmode == GCWSwitchPosition.left
            ? GCWUnitInput(
                value: _currentTemperatureMRT,
                title: i18n(context, 'common_measure_tmrt'),
                initialUnit: TEMPERATURE_CELSIUS,
                min: _currentTemperature - 30.0,
                max: _currentTemperature + 70.0,
                unitList: temperatures,
                onChanged: (value) {
                  setState(() {
                    _currentTemperatureMRT = TEMPERATURE_CELSIUS.fromKelvin(value);
                  });
                },
              )
            : Column(
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
                    value: _currentAirPressure,
                    title: i18n(context, 'common_measure_airpressure'),
                    initialUnit: PRESSURE_MBAR,
                    unitList: allPressures(),
                    onChanged: (value) {
                      setState(() {
                        _currentAirPressure = PRESSURE_MBAR.fromPascal(value);
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
                ],
              ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String hintUTCI = '';
    late UTCIOutput calculatedUTCI;

    if (_currentTMRTmode == GCWSwitchPosition.left) {
      calculatedUTCI = calculateUTCI(_currentTemperature, _currentHumidity, _currentWindSpeed, _currentTemperatureMRT,
          false,);
    } else {
      calculatedUTCI = calculateUTCI(
        _currentTemperature,
        _currentHumidity,
        _currentWindSpeed,
        _currentTemperatureMRT,
        true,
        dateTime: _currentDateTime,
        coords: _currentCoords.toLatLng()!,
        airPressure: _currentAirPressure,
        urban: _currentAreaUrban,
        cloudcover: _currentCloudCover,
      );
    }

    double UTCI_c = calculatedUTCI.UTCI;
    double UTCI = TEMPERATURE_CELSIUS.toKelvin(UTCI_c);
    UTCI = _currentOutputUnit.fromReference(UTCI);

    hintUTCI = _calculateHintUTCI(UTCI_c);

    return Column(
      children: [
        GCWDefaultOutput(
            child: Row(children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(i18n(context, 'utci_title')),
              ),
              Expanded(
                flex: 2,
                //child: Text(_currentOutputUnit.symbol),
                child: Container(
                    margin: const EdgeInsets.only(left: DEFAULT_MARGIN, right: DEFAULT_MARGIN),
                    child: GCWUnitDropDown(
                      value: _currentOutputUnit,
                      onlyShowSymbols: true,
                      unitList: temperatures,
                      unitCategory: UNITCATEGORY_TEMPERATURE,
                      onChanged: (value) {
                        setState(() {
                          _currentOutputUnit = value;
                        });
                      },
                    )),
              ),
              Expanded(
                flex: 2,
                child: Container(
                    margin: const EdgeInsets.only(left: DEFAULT_MARGIN),
                    child: GCWOutput(child: NumberFormat('#.##').format(UTCI))),
              ),
        ])),
        const GCWDivider(),
        Row(
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN),
              child: GCWIconButton(
                icon: Icons.wb_sunny,
                iconColor: _colorUTCI(UTCI),
                backgroundColor: const Color(0xFF4d4d4d),
                onPressed: () {},
              ),
            ),
            Expanded(
              child: GCWOutput(
                child: i18n(context, hintUTCI),
              ),
            )
          ],
        ),
        _currentTMRTmode == GCWSwitchPosition.right
        ? GCWExpandableTextDivider(
          expanded: false,
          text: i18n(context, 'common_further_information'),
          child: GCWColumnedMultilineOutput(
              flexValues: const [4, 2],
              data: [
            [i18n(context, 'common_measure_solar_irradiance'),calculatedUTCI.Solar.toStringAsFixed(2) + ' W/m²',],
            [
              i18n(context, 'common_measure_dewpoint'),
              _currentOutputUnit.fromReference(TEMPERATURE_CELSIUS.toKelvin(calculatedUTCI.Tdew)).toStringAsFixed(2) + ' ' + _currentOutputUnit.symbol
            ],
            [i18n(context, 'common_measure_tglobe'),
              _currentOutputUnit.fromReference(TEMPERATURE_CELSIUS.toKelvin(calculatedUTCI.Tg)).toStringAsFixed(2) + ' ' + _currentOutputUnit.symbol
              ],
            [i18n(context, 'common_measure_tmrt'),
              _currentOutputUnit.fromReference(TEMPERATURE_CELSIUS.toKelvin(calculatedUTCI.Tmrt)).toStringAsFixed(2) + ' ' + _currentOutputUnit.symbol
              ],
            [i18n(context, 'astronomy_sunposition_title'), ''],
            [i18n(context, 'astronomy_position_altitude'), calculatedUTCI.SunPos.altitude.toStringAsFixed(2) + ' °'],
            [i18n(context, 'astronomy_position_azimuth'), calculatedUTCI.SunPos.azimuth.toStringAsFixed(2) + ' °'],

          ]),
        )
            : Container(),
      ],
    );
  }

  String _calculateHintUTCI(double UTCI) {
    if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.BLUE_ACCENT]!) {
      if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.BLUE]!) {
        if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE]!) {
          if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE_ACCENT]!) {
            if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.GREEN]!) {
              if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.ORANGE]!) {
                if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.RED]!) {
                  if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.RED_ACCENT]!) {
                    if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.DARK_RED]!) {
                      return 'utci_index_dark_red';
                    } else {
                      return 'utci_index_red_accent';
                    }
                  } else {
                    return 'utci_index_red';
                  }
                } else {
                  return 'utci_index_orange';
                }
              } else {
                return 'utci_index_green';
              }
            } else {
              return 'utci_index_light_blue_accent';
            }
          } else {
            return 'utci_index_light_blue';
          }
        } else {
          return 'utci_index_blue';
        }
      } else {
        return 'utci_index_blue_accent';
      }
    } else {
      return 'utci_index_dark_blue';
    }
  }

  Color _colorUTCI(double UTCI) {
    if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.BLUE_ACCENT]!) {
      if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.BLUE]!) {
        if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE]!) {
          if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.LIGHT_BLUE_ACCENT]!) {
            if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.GREEN]!) {
              if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.ORANGE]!) {
                if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.RED]!) {
                  if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.RED_ACCENT]!) {
                    if (UTCI > UTCI_HEAT_STRESS[UTCI_HEATSTRESS_CONDITION.DARK_RED]!) {
                      return Colors.red.shade900;
                    } else {
                      return Colors.red.shade600;
                    }
                  } else {
                    return Colors.red;
                  }
                } else {
                  return Colors.orange;
                }
              } else {
                return Colors.green;
              }
            } else {
              return Colors.lightBlue.shade200;
            }
          } else {
            return Colors.lightBlue.shade400;
          }
        } else {
          return Colors.blue;
        }
      } else {
        return Colors.blue.shade700;
      }
    } else {
      return Colors.blue.shade900;
    }
  }
}
