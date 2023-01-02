import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/gcw_dropdownbutton.dart';

//TODO: Maybe we should make the normal GCWDropDownButton stateful.
class GCWStatefulDropDownButton extends StatefulWidget {
  final Function onChanged;
  final List<GCWDropDownMenuItem> items;
  final value;
  final DropdownButtonBuilder selectedItemBuilder;

  const GCWStatefulDropDownButton({Key key, this.value, this.items, this.onChanged, this.selectedItemBuilder})
      : super(key: key);

  @override
  _GCWStatefulDropDownButtonState createState() => _GCWStatefulDropDownButtonState();
}

class _GCWStatefulDropDownButtonState extends State<GCWStatefulDropDownButton> {
  var _currentValue;

  @override
  Widget build(BuildContext context) {
    if (_currentValue == null) _currentValue = widget.value;

    return GCWDropDownButton(
      value: _currentValue,
      items: widget.items,
      onChanged: (value) {
        setState(() {
          _currentValue = value;
        });
        widget.onChanged(value);
      },
      selectedItemBuilder: widget.selectedItemBuilder,
    );
  }
}
