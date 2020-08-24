import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';


class GCWUnitDropDownButton extends StatefulWidget {
  final Function onChanged;
  final value;
  final items;

  const GCWUnitDropDownButton({Key key, this.onChanged, this.value, this.items}) : super(key: key);

  @override
  GCWUnitDropDownButtonState createState() => GCWUnitDropDownButtonState();
}


class GCWUnitDropDownButtonState extends State<GCWUnitDropDownButton> {
  var _currentUnit;

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

      items: widget.items.map((element) {
        return DropdownMenuItem(
          value: element,
          child: Text(element.symbol),
        );
      }).toList(),
    );
  }
}
