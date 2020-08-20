import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/units/mass.dart' as logic;
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';

class GCWMassDropDownButton extends StatefulWidget {
  final Function onChanged;
  final value;

  const GCWMassDropDownButton({Key key, this.onChanged, this.value}) : super(key: key);

  @override
  _GCWMassDropDownButtonState createState() => _GCWMassDropDownButtonState();
}

class _GCWMassDropDownButtonState extends State<GCWMassDropDownButton> {
  logic.Mass _currentMassUnit = logic.defaultMass;

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: widget.value ?? _currentMassUnit,
      onChanged: (newValue) {
        setState(() {
          _currentMassUnit = newValue;
          widget.onChanged(newValue);
        });
      },
      items: logic.masses.map((length) {
        return DropdownMenuItem(
          value: length,
          child: Text(length.symbol),
        );
      }).toList(),
    );
  }
}
