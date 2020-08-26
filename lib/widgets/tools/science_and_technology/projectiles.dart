import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/projectiles.dart';
import 'package:gc_wizard/logic/units/energy.dart';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/unit_category.dart';
import 'package:gc_wizard/logic/units/velocity.dart' as velocityLogic;
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
  ProjectilesMode _currentCalculateMode = ProjectilesMode.ENERGY;

  var _currentOutputVelocityUnit = velocityLogic.VELOCITY_MS;
  var _currentOutputMassUnit = MASS_GRAM;
  var _currentOutputEnergyUnit = ENERGY_JOULE;

  Unit _currentOutputUnit = UNITCATEGORY_ENERGY.defaultUnit;

  double _currentInputMass = 0.0;
  double _currentInputVelocity = 0.0;
  double _currentInputEnergy = 0.0;

  Map<ProjectilesMode, String> _calculateProjectilesModeItems;

  var _currentPrefix = 1.0;
  var _currentPrefixSymbol = '';

  @override
  void initState() {
    super.initState();

    _calculateProjectilesModeItems = {
      ProjectilesMode.ENERGY: 'projectiles_energy',
      ProjectilesMode.MASS: 'projectiles_mass',
      ProjectilesMode.VELOCITY: 'projectiles_velocity',
    };

    print(allMasses().map((e) => e.symbol).toList());
  }

  @override
  Widget build(BuildContext context) {

    var _currentOutputUnitList;
    switch (_currentCalculateMode) {
      case ProjectilesMode.MASS:
        _currentOutputUnitList = baseMasses;
        _currentOutputUnit = UNITCATEGORY_MASS.defaultUnit;
        break;
      case ProjectilesMode.ENERGY:
        _currentOutputUnitList = energies;
        _currentOutputUnit = UNITCATEGORY_ENERGY.defaultUnit;
        break;
      case ProjectilesMode.VELOCITY:
        _currentOutputUnitList = velocityLogic.velocities;
        _currentOutputUnit = UNITCATEGORY_VELOCITY.defaultUnit;
        break;
    }

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
        _currentCalculateMode != ProjectilesMode.MASS
          ? GCWUnitInput(
              value: _currentInputMass,
              title: i18n(context, 'projectiles_mass'),
              unitList: allMasses(),
              onChanged: (value) {
                setState(() {
                  _currentInputMass = value;
                });
              },
            )
          : Container(),
        _currentCalculateMode != ProjectilesMode.ENERGY
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
        _currentCalculateMode != ProjectilesMode.VELOCITY
          ? GCWUnitInput(
              value: _currentInputVelocity,
              title: i18n(context, 'projectiles_velocity'),
              unitList: velocityLogic.velocities,
              onChanged: (value) {
                setState(() {
                  _currentInputVelocity = value;
                });
              },
            )
          : Container(),

        GCWDefaultOutput(
          child: _calculateOutput()
        )
      ],
    );
  }

  _calculateOutput() {
    var format = NumberFormat('0.0######');

    switch (_currentCalculateMode){
      case ProjectilesMode.ENERGY:
        return format.format(_currentOutputEnergyUnit.fromReference(calculateEnergy(_currentInputMass, _currentInputVelocity)) / _currentPrefix) + ' ' + _currentPrefixSymbol + _currentOutputEnergyUnit.symbol;
      case ProjectilesMode.MASS:
        return format.format(_currentOutputMassUnit.fromReference(calculateMass(_currentInputEnergy, _currentInputVelocity)) / _currentPrefix) + ' ' + _currentPrefixSymbol + _currentOutputMassUnit.symbol;
      case ProjectilesMode.VELOCITY:
        return format.format(_currentOutputVelocityUnit.fromReference(calculateVelocity(_currentInputEnergy, _currentInputMass)) / _currentPrefix) + ' ' + _currentPrefixSymbol + _currentOutputVelocityUnit.symbol;
      default: return '';
    }
  }
}