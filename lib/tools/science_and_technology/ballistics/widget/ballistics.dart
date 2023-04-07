import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';
import 'package:intl/intl.dart';

import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_expandable.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_output_text.dart';
import 'package:gc_wizard/common_widgets/units/gcw_unit_input.dart';
import 'package:gc_wizard/common_widgets/units/gcw_units.dart';

import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/density.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/mass.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_prefix.dart';

import 'package:gc_wizard/tools/science_and_technology/ballistics/logic/ballistics.dart';

class Ballistics extends StatefulWidget {
  const Ballistics({Key? key}) : super(key: key);

  @override
  BallisticsState createState() => BallisticsState();
}

class BallisticsState extends State<Ballistics> {
  double _currentInputVelocity = 0.0;
  double _currentInputAngle = 0.0;
  double _currentInputAcceleration = 9.81;
  double _currentInputHeight = 0.0;
  double _currentInputDensity = 0.0;
  double _currentInputDiameter = 0.0;
  double _currentInputDrag = 0.0;
  double _currentInputMass = 0.0;

  GCWUnitsValue<Unit> _currentOutputDistanceUnit = GCWUnitsValue<Unit>(UNITCATEGORY_LENGTH.defaultUnit, UNITPREFIX_NONE);
  GCWUnitsValue<Unit> _currentOutputTimeUnit = GCWUnitsValue<Unit>(UNITCATEGORY_TIME.defaultUnit, UNITPREFIX_NONE);
  GCWUnitsValue<Unit> _currentOutputMaxSpeedUnit = GCWUnitsValue<Unit>(UNITCATEGORY_VELOCITY.defaultUnit, UNITPREFIX_NONE);
  GCWUnitsValue<Unit> _currentOutputHeightUnit = GCWUnitsValue<Unit>(UNITCATEGORY_LENGTH.defaultUnit, UNITPREFIX_NONE);

  AIR_RESISTANCE _currentAirResistanceMode = AIR_RESISTANCE.NONE;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWUnitInput(
          value: _currentInputVelocity,
          title: i18n(context, 'unitconverter_category_velocity'),
          unitCategory: UNITCATEGORY_VELOCITY,
          onChanged: (value) {
            setState(() {
              _currentInputVelocity = value;
            });
          },
        ),
        GCWUnitInput(
          value: _currentInputAngle,
          title: i18n(context, 'unitconverter_category_angle'),
          unitCategory: UNITCATEGORY_ANGLE,
          onChanged: (value) {
            setState(() {
              _currentInputAngle = value;
            });
          },
        ),
        GCWUnitInput(
          value: _currentInputHeight,
          title: i18n(context, 'ballistics_height'),
          unitCategory: UNITCATEGORY_LENGTH,
          onChanged: (value) {
            setState(() {
              _currentInputHeight = value;
            });
          },
        ),
        GCWUnitInput(
          value: _currentInputAcceleration,
          title: i18n(context, 'unitconverter_category_acceleration'),
          unitCategory: UNITCATEGORY_ACCELERATION,
          onChanged: (value) {
            setState(() {
              _currentInputAcceleration = value;
            });
          },
        ),
        GCWDropDown(
          title: i18n(context, 'ballistics_drag'),
          value: _currentAirResistanceMode,
          onChanged: (value) {
            setState(() {
              _currentAirResistanceMode = value as AIR_RESISTANCE;
            });
          },
          items: SplayTreeMap.from(
                  AIR_RESISTANCE_LIST).map((key, value) => MapEntry(i18n(context, key), value))
              .entries
              .map((mode) {
            return GCWDropDownMenuItem(
              value: mode.value,
              child: mode.key,
            );
          }).toList(),
        ),
        _currentAirResistanceMode != AIR_RESISTANCE.NONE
            ? Column(
                children: <Widget>[
                  GCWUnitInput(
                    value: _currentInputMass,
                    title: i18n(context, 'unitconverter_category_mass'),
                    unitCategory: UNITCATEGORY_MASS,
                    unitList: allMasses(),
                    onChanged: (value) {
                      setState(() {
                        _currentInputMass = MASS_KILOGRAM.fromGram(value);
                      });
                    },
                  ),
                  GCWUnitInput(
                    value: _currentInputDiameter,
                    title: i18n(context, 'ballistics_diameter'),
                    unitCategory: UNITCATEGORY_LENGTH,
                    onChanged: (value) {
                      setState(() {
                        _currentInputDiameter = value;
                      });
                    },
                  ),
                  GCWUnitInput(
                    value: _currentInputDensity,
                    title: i18n(context, 'unitconverter_category_density'),
                    unitCategory: UNITCATEGORY_DENSITY,
                    onChanged: (value) {
                      setState(() {
                        _currentInputDensity = DENSITY_KILOGRAMPERCUBICMETER.fromGramPerCubicMeter(value);
                      });
                    },
                  ),
                  GCWUnitInput(
                    value: _currentInputDrag,
                    title: i18n(context, 'ballistics_cw'),
                    onChanged: (value) {
                      setState(() {
                        _currentInputDrag = value;
                      });
                    },
                  ),
                ],
              )
            : Container(),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  Widget _calculateOutput() {
    OutputBallistics output;

    switch (_currentAirResistanceMode) {
      case AIR_RESISTANCE.NONE:
        output = calculateBallisticsNoDrag(
            _currentInputVelocity, _currentInputAngle, _currentInputAcceleration, _currentInputHeight);
        break;
      case AIR_RESISTANCE.STOKES:
      // output = calculateBallisticsNewton(_currentInputVelocity, _currentInputAngle, _currentInputAcceleration, _currentInputHeight, _currentInputMass, _currentInputDiameter, _currentInputDrag, _currentInputDensity);
      // break;
      case AIR_RESISTANCE.NEWTON:
        output = calculateBallisticsNewton(_currentInputVelocity, _currentInputAngle, _currentInputAcceleration,
            _currentInputHeight, _currentInputMass, _currentInputDiameter, _currentInputDrag, _currentInputDensity);
    }

    double outputDistanceValue =
        _currentOutputDistanceUnit['unit'].fromReference(output.Distance) / _currentOutputDistanceUnit['prefix'].value;
    double outputTimeValue =
        _currentOutputTimeUnit['unit'].fromReference(output.Time) / _currentOutputTimeUnit['prefix'].value;
    double outputMaxSpeedValue =
        _currentOutputMaxSpeedUnit['unit'].fromReference(output.maxSpeed) / _currentOutputMaxSpeedUnit['prefix'].value;
    double outputHeightValue =
        _currentOutputHeightUnit['unit'].fromReference(output.Height) / _currentOutputHeightUnit['prefix'].value;

    return Column(
      children: <Widget>[
        GCWExpandableTextDivider(
            text: i18n(context, 'ballistics_distance'),
            expanded: false,
            child: GCWUnits(
              value: _currentOutputDistanceUnit,
              unitCategory: UNITCATEGORY_LENGTH,
              onlyShowPrefixSymbols: false,
              onlyShowUnitSymbols: false,
              onChanged: (GCWUnitsValue value) {
                setState(() {
                  _currentOutputDistanceUnit = value ;
                  outputDistanceValue = _currentOutputDistanceUnit['unit'].fromReference(output.Distance) /
                      _currentOutputDistanceUnit['prefix'].value;
                });
              },
            )),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  right: DOUBLE_DEFAULT_MARGIN,
                ),
              ),
              flex: 2,
            ),
            Expanded(
                child: Container(
                  child: GCWOutputText(
                    text: NumberFormat('0.0' + '#').format(outputDistanceValue),
                  ),
                  padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN, left: DOUBLE_DEFAULT_MARGIN),
                ),
                flex: 6),
            Expanded(
                child: Container(
                  child: GCWOutputText(
                    text: _currentOutputDistanceUnit.prefix.symbol,
                    suppressCopyButton: true,
                  ),
                  padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                ),
                flex: 2),
          ],
        ),
        GCWExpandableTextDivider(
            text: i18n(context, 'ballistics_time'),
            expanded: false,
            child: GCWUnits(
              value: _currentOutputTimeUnit,
              unitCategory: UNITCATEGORY_TIME,
              onlyShowPrefixSymbols: false,
              onlyShowUnitSymbols: false,
              onChanged: (value) {
                setState(() {
                  _currentOutputTimeUnit = value;
                  outputDistanceValue = _currentOutputTimeUnit['unit'].fromReference(output.Time) /
                      _currentOutputTimeUnit['prefix'].value;
                });
              },
            )),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  right: DOUBLE_DEFAULT_MARGIN,
                ),
              ),
              flex: 2,
            ),
            Expanded(
                child: Container(
                  child: GCWOutputText(
                    text: NumberFormat('0.0' + '#').format(outputTimeValue),
                  ),
                  padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN, left: DOUBLE_DEFAULT_MARGIN),
                ),
                flex: 6),
            Expanded(
                child: Container(
                  child: GCWOutputText(
                    text: _currentOutputTimeUnit.prefix.symbol,
                    suppressCopyButton: true,
                  ),
                  padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                ),
                flex: 2),
          ],
        ),
        GCWExpandableTextDivider(
            text: i18n(context, 'ballistics_height'),
            expanded: false,
            child: GCWUnits(
              value: _currentOutputHeightUnit,
              unitCategory: UNITCATEGORY_LENGTH,
              onlyShowPrefixSymbols: false,
              onlyShowUnitSymbols: false,
              onChanged: (value) {
                setState(() {
                  _currentOutputHeightUnit = value;
                  outputHeightValue = _currentOutputHeightUnit['unit'].fromReference(output.Height) /
                      _currentOutputHeightUnit['prefix'].value;
                });
              },
            )),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  right: DOUBLE_DEFAULT_MARGIN,
                ),
              ),
              flex: 2,
            ),
            Expanded(
                child: Container(
                  child: GCWOutputText(
                    text: NumberFormat('0.0' + '#').format(outputHeightValue),
                  ),
                  padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN, left: DOUBLE_DEFAULT_MARGIN),
                ),
                flex: 6),
            Expanded(
                child: Container(
                  child: GCWOutputText(
                    text: _currentOutputHeightUnit.prefix.symbol,
                    suppressCopyButton: true,
                  ),
                  padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                ),
                flex: 2),
          ],
        ),
        GCWExpandableTextDivider(
            text: i18n(context, 'ballistics_maxspeed'),
            expanded: false,
            child: GCWUnits(
              value: _currentOutputMaxSpeedUnit,
              unitCategory: UNITCATEGORY_VELOCITY,
              onlyShowPrefixSymbols: false,
              onlyShowUnitSymbols: false,
              onChanged: (value) {
                setState(() {
                  _currentOutputMaxSpeedUnit = value;
                  outputMaxSpeedValue = _currentOutputMaxSpeedUnit['unit'].fromReference(output.maxSpeed) /
                      _currentOutputMaxSpeedUnit['prefix'].value;
                });
              },
            )),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  right: DOUBLE_DEFAULT_MARGIN,
                ),
              ),
              flex: 2,
            ),
            Expanded(
                child: Container(
                  child: GCWOutputText(
                    text: (outputMaxSpeedValue > 0)
                        ? NumberFormat('0.0' + '#').format(outputMaxSpeedValue)
                        : i18n(context, 'ballistics_not_implemented_yet'),
                  ),
                  padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN, left: DOUBLE_DEFAULT_MARGIN),
                ),
                flex: 6),
            Expanded(
                child: (outputMaxSpeedValue > 0)
                    ? Container(
                        child: GCWOutputText(
                          text: _currentOutputMaxSpeedUnit.prefix.symbol,
                          suppressCopyButton: true,
                        ),
                        padding: EdgeInsets.only(left: DOUBLE_DEFAULT_MARGIN),
                      )
                    : Container(),
                flex: 2),
          ],
        ),
      ],
    );
  }
}
