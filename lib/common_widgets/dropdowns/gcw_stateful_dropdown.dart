import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';

//TODO: Maybe we should make the normal GCWDropDown stateful.
class GCWStatefulDropDown extends StatefulWidget {
  final void Function(Object?) onChanged;
  final List<GCWDropDownMenuItem> items;
  final value;
  final DropdownButtonBuilder? selectedItemBuilder;

  const GCWStatefulDropDown({Key? key, this.value, required this.items, required this.onChanged, this.selectedItemBuilder})
      : super(key: key);

  @override
  _GCWStatefulDropDownState createState() => _GCWStatefulDropDownState();
}

class _GCWStatefulDropDownState extends State<GCWStatefulDropDown> {
  dynamic _currentValue;

  @override
  Widget build(BuildContext context) {
    if (_currentValue == null) _currentValue = widget.value;

    return GCWDropDown(
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
