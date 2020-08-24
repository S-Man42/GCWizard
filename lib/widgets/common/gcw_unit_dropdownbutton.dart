import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/units/mass.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';


class GCWUnitDropDownButton extends StatefulWidget {
  final Function onChanged;
  final value;
  final items;

  const GCWUnitDropDownButton({Key key, this.onChanged, this.value, this.items}) : super(key: key);

  @override
  _GCWUnitDropDownButtonState createState() => _GCWUnitDropDownButtonState();
}


class _GCWUnitDropDownButtonState extends State<GCWUnitDropDownButton> {
  var _currentUnit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: widget.value ?? _currentUnit,
      onChanged: (newValue) {
        setState(() {
          _currentUnit = newValue;
          widget.onChanged(newValue);
        });
      },
      items: widget.items.map((mass) {
        return DropdownMenuItem(
          value: mass,
          child: Text(mass.symbol),
        );
      }).toList(),
    );
  }
}
