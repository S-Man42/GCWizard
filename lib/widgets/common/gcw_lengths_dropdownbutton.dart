import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/units/length.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';

class GCWLengthsDropDownButton extends StatefulWidget {
  final Function onChanged;
  final value;

  const GCWLengthsDropDownButton({Key key, this.onChanged, this.value}) : super(key: key);

  @override
  _GCWLengthsDropDownButtonState createState() => _GCWLengthsDropDownButtonState();
}

class _GCWLengthsDropDownButtonState extends State<GCWLengthsDropDownButton> {
  Length _currentLengthUnit = defaultLength;

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: widget.value ?? _currentLengthUnit,
      onChanged: (newValue) {
        setState(() {
          _currentLengthUnit = newValue;
          widget.onChanged(newValue);
        });
      },
      items: lengths.map((length) {
        return DropdownMenuItem(
          value: length,
          child: Text(length.symbol),
        );
      }).toList(),
    );
  }
}
