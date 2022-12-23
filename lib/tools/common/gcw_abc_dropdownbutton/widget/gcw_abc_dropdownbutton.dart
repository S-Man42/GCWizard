import 'package:flutter/material.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/tools/common/base/gcw_dropdownbutton/widget/gcw_dropdownbutton.dart';

class GCWABCDropDownButton extends StatefulWidget {
  final Function onChanged;
  final value;

  const GCWABCDropDownButton({
    Key key,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  GCWABCDropDownButtonState createState() => GCWABCDropDownButtonState();
}

class GCWABCDropDownButtonState extends State<GCWABCDropDownButton> {
  int _currentValue;

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: _currentValue ?? widget.value ?? 1,
      onChanged: (newValue) {
        setState(() {
          _currentValue = newValue;
          widget.onChanged(_currentValue);
        });
      },
      items: alphabet_AZ.entries.map((entry) {
        return GCWDropDownMenuItem(
          value: entry.value,
          child: '${entry.key} (${entry.value})',
        );
      }).toList(),
    );
  }
}
