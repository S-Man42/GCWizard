import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/units/length.dart';
import 'package:gc_wizard/logic/units/unit.dart';
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

  List<Unit> _lengths;

  @override
  void initState() {
    super.initState();

    _lengths = [
      LENGTH_M,
      Length(
          symbol: 'km',
          inMeters: 1000.0
      ),
      LENGTH_MI,
      LENGTH_IN,
      LENGTH_FT,
      LENGTH_YD,
      LENGTH_NM
    ];
  }

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
      items: _lengths.map((length) {
        return DropdownMenuItem(
          value: length,
          child: Text(length.symbol),
        );
      }).toList(),
    );
  }
}
