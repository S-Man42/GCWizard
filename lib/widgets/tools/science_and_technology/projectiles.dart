import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/logic/units/velocity.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_energy_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_mass_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_velocity_dropdownbutton.dart';

class Projectiles extends StatefulWidget {
  @override
  ProjectilesState createState() => ProjectilesState();
}

class ProjectilesState extends State<Projectiles> {
  CalculateProjectilesMode _currentCalculateMode = CalculateProjectilesMode.ENERGY;

  var _currentVelocityUnit = defaultVelocity;
  var _currentMassUnit = defaultMass;
  var _currentEnergyUnit = defaultEnergy;

  var _currentOutputVelocityUnit = VELOCITY_MS;
  var _currentOutputMassUnit = MASS_GRAM;
  var _currentOutputEnergyUnit = ENERGY_JOULE;

  double _currentInput1 = 0.0;
  double _currentInput2 = 0.0;

  String titleInput1 = 'projectiles_mass';
  String titleInput2 = 'projectiles_speed';

  @override
  Widget build(BuildContext context) {
    var calculateProjectilesModeItems = {
      CalculateProjectilesMode.ENERGY : i18n(context, 'projectiles_energy'),
      CalculateProjectilesMode.MASS : i18n(context, 'projectiles_mass'),
      CalculateProjectilesMode.SPEED : i18n(context, 'projectiles_speed'),
    };

    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded (
              child: Container(
                child: GCWDropDownButton(
                  value: _currentCalculateMode,
                  onChanged: (value) {
                    setState(() {
                      _currentCalculateMode = value;
                    });
                    switch (_currentCalculateMode){
                      case CalculateProjectilesMode.ENERGY:
                        titleInput1 = 'projectiles_mass';
                        titleInput2 = 'projectiles_speed';
                        break;
                      case CalculateProjectilesMode.MASS:
                        titleInput1 = 'projectiles_energy';
                        titleInput2 = 'projectiles_speed';
                        break;
                      case CalculateProjectilesMode.SPEED:
                        titleInput1 = 'projectiles_energy';
                        titleInput2 = 'projectiles_mass';
                        break;
                    }
                  },
                  items: calculateProjectilesModeItems.entries.map((mode) {
                    return DropdownMenuItem(
                      value: mode.key,
                      child: Text(mode.value),
                    );
                  }).toList(),
                ),
                  padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
              ),
              flex: 3
            ),
            _currentCalculateMode == CalculateProjectilesMode.ENERGY
            ? Expanded(
                child: GCWEnergyDropDownButton(
                  value: _currentOutputEnergyUnit,
                    onChanged: (value) {
                      setState(() {
                        _currentOutputEnergyUnit = value;
                      });
                    },
                ),
                flex: 1
              )
            : _currentCalculateMode == CalculateProjectilesMode.MASS
              ? Expanded(
                child: GCWMassDropDownButton(
                  value: _currentOutputMassUnit,
                  onChanged: (value) {
                    setState(() {
                      _currentOutputMassUnit = value;
                    });
                  },
                ),
                flex: 1
                )
              : _currentCalculateMode == CalculateProjectilesMode.SPEED
                ? Expanded(
                child: GCWVelocityDropDownButton(
                  value: _currentOutputVelocityUnit,
                  onChanged: (value) {
                    setState(() {
                      _currentOutputVelocityUnit = value;
                    });
                  },
                ),
                flex: 1
                  )
                : null,
          ]
        ),
/*
        GCWDropDownButton(
          value: _currentCalculateMode,
          onChanged: (value) {
            setState(() {
              _currentCalculateMode = value;
            });
            switch (_currentCalculateMode){
              case CalculateProjectilesMode.ENERGY:
                titleInput1 = 'projectiles_mass';
                titleInput2 = 'projectiles_speed';
                break;
              case CalculateProjectilesMode.MASS:
                titleInput1 = 'projectiles_energy';
                titleInput2 = 'projectiles_speed';
                break;
              case CalculateProjectilesMode.SPEED:
                titleInput1 = 'projectiles_energy';
                titleInput2 = 'projectiles_mass';
                break;
            }
          },
          items: calculateProjectilesModeItems.entries.map((mode) {
            return DropdownMenuItem(
              value: mode.key,
              child: Text(mode.value),
            );
          }).toList(),
        ),
*/

        _currentCalculateMode == CalculateProjectilesMode.ENERGY
          ? Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: GCWDoubleSpinner(
                        title: i18n(context, titleInput1),
                        min: 0.0,
                        value: _currentInput1,
                        onChanged: (value) {
                          setState(() {
                            _currentInput1 = value;
                          });
                        },
                      ),
                      padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                    ),
                    flex: 3
                  ),
                  Expanded(
                    child: GCWMassDropDownButton(
                      value: _currentMassUnit,
                      onChanged: (value) {
                        setState(() {
                          _currentMassUnit = value;
                        });
                      },
                    ),
                    flex: 1
                  )
                ], // children
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: GCWDoubleSpinner(
                        title: i18n(context, titleInput2),
                        min: 0.0,
                        value: _currentInput2,
                        onChanged: (value) {
                          setState(() {
                            _currentInput2 = value;
                          });
                        },
                      ),
                      padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                    ),
                    flex: 3
                  ),
                  Expanded(
                  child: GCWVelocityDropDownButton(
                    value: _currentVelocityUnit,
                    onChanged: (value) {
                      setState(() {
                        _currentVelocityUnit = value;
                      });
                      },
                  ),
                  flex: 1
                  )
                ], //children
              ),
            ]
          )
          : _currentCalculateMode == CalculateProjectilesMode.MASS
          ? Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: GCWDoubleSpinner(
                          title: i18n(context, titleInput1),
                          min: 0.0,
                          value: _currentInput1,
                          onChanged: (value) {
                            setState(() {
                              _currentInput1 = value;
                            });
                          },
                        ),
                        padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                      ),
                      flex: 3
                  ),
                  Expanded(
                      child: GCWEnergyDropDownButton(
                        value: _currentEnergyUnit,
                        onChanged: (value) {
                          setState(() {
                            _currentEnergyUnit = value;
                          });
                        },
                      ),
                      flex: 1
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: GCWDoubleSpinner(
                          title: i18n(context, titleInput2),
                          min: 0.0,
                          value: _currentInput2,
                          onChanged: (value) {
                            setState(() {
                              _currentInput2 = value;
                            });
                          },
                        ),
                        padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                      ),
                      flex: 3
                  ),
                  Expanded(
                      child: GCWVelocityDropDownButton(
                        value: _currentVelocityUnit,
                        onChanged: (value) {
                          setState(() {
                            _currentVelocityUnit = value;
                          });
                        },
                      ),
                      flex: 1
                  )
                ],
              ),
            ]
        )
          : _currentCalculateMode == CalculateProjectilesMode.SPEED
          ? Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: GCWDoubleSpinner(
                          title: i18n(context, titleInput1),
                          min: 0.0,
                          value: _currentInput1,
                          onChanged: (value) {
                            setState(() {
                              _currentInput1 = value;
                            });
                          },
                        ),
                        padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                      ),
                      flex: 3
                  ),
                  Expanded(
                      child: GCWEnergyDropDownButton(
                        value: _currentEnergyUnit,
                        onChanged: (value) {
                          setState(() {
                            _currentEnergyUnit = value;
                          });
                        },
                      ),
                      flex: 1
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: GCWDoubleSpinner(
                          title: i18n(context, titleInput2),
                          min: 0.0,
                          value: _currentInput2,
                          onChanged: (value) {
                            setState(() {
                              _currentInput2 = value;
                            });
                          },
                        ),
                        padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                      ),
                      flex: 3
                  ),
                  Expanded(
                      child: GCWMassDropDownButton(
                        value: _currentMassUnit,
                        onChanged: (value) {
                          setState(() {
                            _currentMassUnit = value;
                          });
                        },
                      ),
                      flex: 1
                  )
                ],
              ),
            ]
        )
          : null,
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String calculate = '';
    String result = '';

    switch (_currentCalculateMode){
      case CalculateProjectilesMode.ENERGY:
        calculate = 'projectiles_energy';
        result = calculateEnergy(
            convert(_currentInput1 , _currentMassUnit, MASS_GRAM) / 1000,
            convert(_currentInput2 , _currentVelocityUnit, VELOCITY_MS)
            )
            .toStringAsFixed(3) + ' Joule';
        break;
      case CalculateProjectilesMode.MASS:
        calculate = 'projectiles_mass';
        result = calculateMass(
            convert(_currentInput1 , _currentEnergyUnit, ENERGY_JOULE),
            convert(_currentInput2 , _currentVelocityUnit, VELOCITY_MS)
            ).toStringAsFixed(3) + ' kg';
        break;
      case CalculateProjectilesMode.SPEED:
        calculate = 'projectiles_speed';
        result = calculateSpeed(
            convert(_currentInput1 , _currentEnergyUnit, ENERGY_JOULE),
            convert(_currentInput2 , _currentMassUnit, MASS_GRAM) / 1000
            ).toStringAsFixed(3) + 'm/s';
        break;
    }

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWTextDivider(
              text: i18n(context, calculate)
          ),

          GCWOutputText(
              text: result
          ),
        ],
      ),
    );
  }
}