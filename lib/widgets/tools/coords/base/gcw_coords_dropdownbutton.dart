import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';

class GCWCoordsDropDownButton extends StatefulWidget {
  final Function onChanged;
  final String value;
  final List<dynamic> itemList;

  const GCWCoordsDropDownButton({Key key, this.itemList, this.onChanged, this.value}) : super(key: key);

  @override
  _GCWCoordsDropDownButtonState createState() => _GCWCoordsDropDownButtonState();
}

class _GCWCoordsDropDownButtonState extends State<GCWCoordsDropDownButton> {

  var _dropdownValue;

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: widget.value ?? _dropdownValue,
      onChanged: (newValue) {
        setState(() {
          _dropdownValue = newValue;
          widget.onChanged(newValue);
        });
      },
      items: widget.itemList.map((entry) {
        return DropdownMenuItem(
          value: entry.key,
          child: Text(entry.name),
        );
      }).toList(),
    );
  }
}
