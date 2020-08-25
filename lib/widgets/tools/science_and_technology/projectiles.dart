import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/velocity.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_input.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_prefix_dropdownbutton.dart';
import 'package:intl/intl.dart';

class Projectiles extends StatefulWidget {
  @override
  ProjectilesState createState() => ProjectilesState();
}

class ProjectilesState extends State<Projectiles> {
  CalculateProjectilesMode _currentCalculateMode = CalculateProjectilesMode.ENERGY;

  var _currentOutputVelocityUnit = VELOCITY_MS;
  var _currentOutputMassUnit = MASS_GRAM;
  var _currentOutputEnergyUnit = ENERGY_JOULE;

  double _currentInputMass = 0.0;
  double _currentInputVelocity = 0.0;
  double _currentInputEnergy = 0.0;

  Map<CalculateProjectilesMode, String> _calculateProjectilesModeItems;

  List<Unit> _massesList;

  var _currentPrefix = 1.0;
  var _currentPrefixSymbol = '';

  @override
  void initState() {
    super.initState();

    _calculateProjectilesModeItems = {
      CalculateProjectilesMode.ENERGY: 'projectiles_energy',
      CalculateProjectilesMode.MASS: 'projectiles_mass',
      CalculateProjectilesMode.VELOCITY: 'projectiles_velocity',
    };

    _massesList = List<Unit>.from(masses);
    _massesList.insert(1, MASS_KILOGRAM);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentCalculateMode,
          onChanged: (value) {
            setState(() {
              _currentCalculateMode = value;
            });
          },
          items: _calculateProjectilesModeItems.entries.map((mode) {
            return DropdownMenuItem(
              value: mode.key,
              child: Text(i18n(context, mode.value)),
            );
          }).toList(),
        ),
        _currentCalculateMode != CalculateProjectilesMode.MASS
          ? GCWUnitInput(
              value: _currentInputMass,
              title: i18n(context, 'projectiles_mass'),
              unitList: _massesList,
              onChanged: (value) {
                setState(() {
                  _currentInputMass = value;
                });
              },
            )
          : Container(),
        _currentCalculateMode != CalculateProjectilesMode.ENERGY
          ? GCWUnitInput(
              value: _currentInputEnergy,
              title: i18n(context, 'projectiles_energy'),
              unitList: energies,
              onChanged: (value) {
                setState(() {
                  _currentInputEnergy = value;
                });
              },
            )
          : Container(),
        _currentCalculateMode != CalculateProjectilesMode.VELOCITY
          ? GCWUnitInput(
              value: _currentInputVelocity,
              title: i18n(context, 'projectiles_velocity'),
              unitList: velocities,
              onChanged: (value) {
                setState(() {
                  _currentInputVelocity = value;
                });
              },
            )
          : Container(),
        GCWTextDivider(
          text: 'Output Unit',
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWUnitPrefixDropDownButton(
                value: _currentPrefix,
                onChanged: (value) {
                  setState(() {
                    _currentPrefix = value['value'];
                    _currentPrefixSymbol = value['symbol'];
                  });
                },
              ),
            ),
            _currentCalculateMode == CalculateProjectilesMode.MASS
              ? Expanded(
                  child: GCWUnitDropDownButton(
                    value: _currentOutputMassUnit,
                    unitList: masses,
                    onChanged: (value) {
                      setState(() {
                        _currentOutputMassUnit = value;
                      });
                    },
                  ),
                  flex: 1
                )
              : Container(),
            _currentCalculateMode == CalculateProjectilesMode.ENERGY
              ? Expanded(
                  child: GCWUnitDropDownButton(
                    value: _currentOutputEnergyUnit,
                    unitList: energies,
                    onChanged: (value) {
                      setState(() {
                        _currentOutputEnergyUnit = value;
                      });
                    },
                  ),
                  flex: 1,
                )
              : Container(),
            _currentCalculateMode == CalculateProjectilesMode.VELOCITY
              ? Expanded(
                  child: GCWUnitDropDownButton(
                    value: _currentOutputVelocityUnit,
                    unitList: velocities,
                    onChanged: (value) {
                      setState(() {
                        _currentOutputVelocityUnit = value;
                      });
                    },
                  ),
                  flex: 1,
                )
              : Container(),
          ],
        ),
        GCWDefaultOutput(
          child: _calculateOutput()
        )
      ],
    );
  }

  _calculateOutput() {
    var format = NumberFormat('0.0######');

    switch (_currentCalculateMode){
      case CalculateProjectilesMode.ENERGY:
        return format.format(_currentOutputEnergyUnit.fromReference(calculateEnergy(_currentInputMass, _currentInputVelocity)) / _currentPrefix) + ' ' + _currentPrefixSymbol + _currentOutputEnergyUnit.symbol;
      case CalculateProjectilesMode.MASS:
        return format.format(_currentOutputMassUnit.fromReference(calculateMass(_currentInputEnergy, _currentInputVelocity)) / _currentPrefix) + ' ' + _currentPrefixSymbol + _currentOutputMassUnit.symbol;
      case CalculateProjectilesMode.VELOCITY:
        return format.format(_currentOutputVelocityUnit.fromReference(calculateVelocity(_currentInputEnergy, _currentInputMass)) / _currentPrefix) + ' ' + _currentPrefixSymbol + _currentOutputVelocityUnit.symbol;
      default: return '';
    }
  }
}