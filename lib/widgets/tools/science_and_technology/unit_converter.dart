import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/logic/units/angle.dart';
import 'package:gc_wizard/logic/units/area.dart';
import 'package:gc_wizard/logic/units/density.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/logic/units/force.dart';
import 'package:gc_wizard/logic/units/length.dart';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/power.dart';
import 'package:gc_wizard/logic/units/pressure.dart';
import 'package:gc_wizard/logic/units/temperature.dart';
import 'package:gc_wizard/logic/units/time.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/velocity.dart';
import 'package:gc_wizard/logic/units/volume.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:intl/intl.dart';

class UnitConverter extends StatefulWidget {
  @override
  UnitConverterState createState() => UnitConverterState();
}

class UnitConverterState extends State<UnitConverter> {
  var _currentValue = 1.0;
  Unit _currentFromUnit;
  Unit _currentToUnit;

  var _categories = [
    {'key' : 'unitconverter_category_angle', 'units' : angles, 'default_from_unit': ANGLE_DEGREE, 'default_to_unit': ANGLE_RADIAN},
    {'key' : 'unitconverter_category_area', 'units' : areas, 'default_from_unit': AREA_SQUAREMETER, 'default_to_unit': AREA_SQUAREKILOMETER, 'suppress_prefixes': true},
    {'key' : 'unitconverter_category_density', 'units' : densities, 'default_from_unit': DENSITY_KILOGRAMPERCUBICMETER, 'default_to_unit': DENSITY_GRAMPERLITER, 'suppress_prefixes': true},
    {'key' : 'unitconverter_category_energy', 'units' : energies, 'default_from_unit': ENERGY_JOULE, 'default_to_unit': ENERGY_CALORIE},
    {'key' : 'unitconverter_category_force', 'units' : forces, 'default_from_unit': FORCE_NEWTON, 'default_to_unit': FORCE_POUND},
    {'key' : 'unitconverter_category_length', 'units' : lengths, 'default_from_unit': LENGTH_M, 'default_to_unit': LENGTH_FT},
    {'key' : 'unitconverter_category_mass', 'units' : masses, 'default_from_unit': MASS_GRAM, 'default_to_unit': MASS_POUND},
    {'key' : 'unitconverter_category_power', 'units' : powers, 'default_from_unit': POWER_WATT, 'default_to_unit': POWER_METRICHORSEPOWER},
    {'key' : 'unitconverter_category_pressure', 'units' : pressures, 'default_from_unit': PRESSURE_PASCAL, 'default_to_unit': PRESSURE_BAR},
    {'key' : 'unitconverter_category_temperature', 'units' : temperatures, 'default_from_unit': TEMPERATURE_CELSIUS, 'default_to_unit': TEMPERATURE_FAHRENHEIT},
    {'key' : 'unitconverter_category_time', 'units' : times, 'default_from_unit': TIME_HOUR, 'default_to_unit': TIME_MINUTE},
    {'key' : 'unitconverter_category_velocity', 'units' : velocities, 'default_from_unit': VELOCITY_KMH, 'default_to_unit': VELOCITY_MS, 'suppress_prefixes': true},
    {'key' : 'unitconverter_category_volume', 'units' : volumes, 'default_from_unit': VOLUME_CUBICMETER, 'default_to_unit': VOLUME_LITER, 'suppress_prefixes': true},
  ];

  var _prefixes = [
    {'name': 'common_unit_prefix_exa', 'symbol' : 'E', 'value': 1.0e18},
    {'name': 'common_unit_prefix_peta', 'symbol' : 'P', 'value': 1.0e15},
    {'name': 'common_unit_prefix_tera', 'symbol' : 'T', 'value': 1.0e12},
    {'name': 'common_unit_prefix_giga', 'symbol' : 'G', 'value': 1.0e9},
    {'name': 'common_unit_prefix_mega', 'symbol' : 'M', 'value': 1.0e6},
    {'name': 'common_unit_prefix_kilo', 'symbol' : 'k', 'value': 1.0e3},
    {'name': 'common_unit_prefix_hecto', 'symbol' : 'h', 'value': 1.0e2},
    {'name': 'common_unit_prefix_deca', 'symbol' : 'da', 'value': 1.0e1},
    {'name': null, 'symbol' : null, 'value': 1.0},
    {'name': 'common_unit_prefix_deci', 'symbol' : 'd', 'value': 1.0e-1},
    {'name': 'common_unit_prefix_centi', 'symbol' : 'c', 'value': 1.0e-2},
    {'name': 'common_unit_prefix_milli', 'symbol' : 'm', 'value': 1.0e-3},
    {'name': 'common_unit_prefix_micro', 'symbol' : '\u00B5', 'value': 1.0e-6},
    {'name': 'common_unit_prefix_nano', 'symbol' : 'n', 'value': 1.0e-9},
    {'name': 'common_unit_prefix_pico', 'symbol' : 'p', 'value': 1.0e-12},
    {'name': 'common_unit_prefix_femto', 'symbol' : 'f', 'value': 1.0e-15},
    {'name': 'common_unit_prefix_atto', 'symbol' : 'a', 'value': 1.0e-18},
  ];

  var _currentFromPrefix = 1.0;
  var _currentToPrefix = 1.0;
  var _currentCategory;

  @override
  void initState() {
    super.initState();

    _currentCategory = _categories.firstWhere((category) => category['key'] == 'unitconverter_category_length');
    _currentFromUnit = _currentCategory['default_from_unit'];
    _currentToUnit = _currentCategory['default_to_unit'];
  }

  @override
  Widget build(BuildContext context) {
    _categories.sort((a, b) {
      return i18n(context, a['key']).compareTo(i18n(context, b['key']));
    });

    return Column(
      children: <Widget>[
        GCWDoubleSpinner(
          value: _currentValue,
          numberDecimalDigits: 5,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
          }
        ),
        GCWTextDivider(
          text: i18n(context, 'unitconverter_unit'),
        ),
        GCWDropDownButton(
          value: _currentCategory,
          items: _categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(
                i18n(context, category['key'])
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              if (value['key'] != _currentCategory['key']) {
                _currentCategory = value;

                _currentFromUnit = _currentCategory['default_from_unit'];
                _currentToUnit = _currentCategory['default_to_unit'];
                _currentFromPrefix = 1.0;
                _currentToPrefix = 1.0;
              }
            });
          },
        ),
        Row(
          children: [
            Expanded(
              child: GCWText(text: i18n(context, 'unitconverter_from')),
              flex: 1
            ),
            _currentCategory['suppress_prefixes'] != null ? Container() :
            Expanded(
              child: GCWDropDownButton(
                value: _currentFromPrefix,
                items: _prefixes.map((prefix) {
                  return DropdownMenuItem(
                    value: prefix['value'],
                    child: Text(prefix['name'] == null ? '' : i18n(context, prefix['name']) + ' (${prefix['symbol']})'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _currentFromPrefix = value;
                  });
                },
                selectedItemBuilder: (context) {
                  return _prefixes.map((prefix) {
                    return Align(
                      child: Text(
                        prefix['symbol'] == null ? '' : prefix['symbol']
                      ),
                      alignment: Alignment.centerLeft,
                    );
                  }).toList();
                }
              ),
              flex: 2
            ),
            Expanded(
              child: Container(
                child: GCWDropDownButton(
                  value: _currentFromUnit,
                  items: (_currentCategory['units'] as List<Unit>).map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text(i18n(context, unit.name) + (unit.symbol == null ? '' : ' (${unit.symbol})')),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentFromUnit = value;
                    });
                  },
                ) ,
                padding: EdgeInsets.only(left: 2 * DEFAULT_MARGIN),
              ),
              flex: 4
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GCWText(text: i18n(context, 'unitconverter_to')),
              flex: 1
            ),
            _currentCategory['suppress_prefixes'] != null ? Container() :
            Expanded(
              child: GCWDropDownButton(
                value: _currentToPrefix,
                items: _prefixes.map((prefix) {
                  return DropdownMenuItem(
                    value: prefix['value'],
                    child:  Text(prefix['name'] == null ? '' : i18n(context, prefix['name']) + ' (${prefix['symbol']})'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _currentToPrefix = value;
                  });
                },
                selectedItemBuilder: (context) {
                  return _prefixes.map((prefix) {
                    return Align(
                      child: Text(
                        prefix['symbol'] == null ? '' : prefix['symbol']
                      ),
                      alignment: Alignment.centerLeft,
                    );
                  }).toList();
                }
              ),
              flex: 2
            ),
            Expanded(
              child: Container(
                child: GCWDropDownButton(
                  value: _currentToUnit,
                  items: (_currentCategory['units'] as List<Unit>).map((unit) {
                    return DropdownMenuItem(
                      value: unit,
                      child: Text(i18n(context, unit.name) + (unit.symbol == null ? '' : ' (${unit.symbol})')),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentToUnit = value;
                    });
                  },
                ),
                padding: EdgeInsets.only(left: 2 * DEFAULT_MARGIN),
              ),
              flex: 4
            ),
          ],
        ),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    return NumberFormat('0.' + '#' * 8).format(
      convert(_currentValue * _currentFromPrefix, _currentFromUnit, _currentToUnit) / _currentToPrefix
    );
  }
}
