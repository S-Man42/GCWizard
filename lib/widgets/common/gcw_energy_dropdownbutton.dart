import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/units/energy.dart' as logic;
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';

class GCWEnergyDropDownButton extends StatefulWidget {
  final Function onChanged;
  final value;

  const GCWEnergyDropDownButton({Key key, this.onChanged, this.value}) : super(key: key);

  @override
  _GCWEnergyDropDownButtonState createState() => _GCWEnergyDropDownButtonState();
}

class _GCWEnergyDropDownButtonState extends State<GCWEnergyDropDownButton> {
  logic.Energy _currentEnergyUnit = logic.defaultEnergy;

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: widget.value ?? _currentEnergyUnit,
      onChanged: (newValue) {
        setState(() {
          _currentEnergyUnit = newValue;
          widget.onChanged(newValue);
        });
      },
      items: logic.energies.map((energy) {
        return DropdownMenuItem(
          value: energy,
          child: Text(energy.symbol),
        );
      }).toList(),
    );
  }
}
