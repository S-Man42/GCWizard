import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/units/unit_category.dart';
import 'package:gc_wizard/logic/units/velocity.dart' as logic;
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';

class GCWVelocityDropDownButton extends StatefulWidget {
  final Function onChanged;
  final value;

  const GCWVelocityDropDownButton({Key key, this.onChanged, this.value}) : super(key: key);

  @override
  _GCWVelocityDropDownButtonState createState() => _GCWVelocityDropDownButtonState();
}

class _GCWVelocityDropDownButtonState extends State<GCWVelocityDropDownButton> {
  logic.Velocity _currentVelocityUnit = UNITCATEGORY_VELOCITY.defaultUnit;

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: widget.value ?? _currentVelocityUnit,
      onChanged: (newValue) {
        setState(() {
          _currentVelocityUnit = newValue;
          widget.onChanged(newValue);
        });
      },
      items: logic.velocities.map((length) {
        return DropdownMenuItem(
          value: length,
          child: Text(length.symbol),
        );
      }).toList(),
    );
  }
}
