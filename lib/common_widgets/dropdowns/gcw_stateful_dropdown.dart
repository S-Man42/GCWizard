import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';

//TODO: Maybe we should make the normal GCWDropDown stateful.
class GCWStatefulDropDown<T extends Object?> extends StatefulWidget {
  final void Function(T) onChanged;
  final List<GCWDropDownMenuItem> items;
  final value;
  final DropdownButtonBuilder? selectedItemBuilder;

  const GCWStatefulDropDown({Key? key, this.value, required this.items, required this.onChanged, this.selectedItemBuilder})
      : super(key: key);

  @override
  _GCWStatefulDropDownState<T> createState() => _GCWStatefulDropDownState<T>();
}

class _GCWStatefulDropDownState<T extends Object?> extends State<GCWStatefulDropDown> {
  late T _currentValue;

  @override
  Widget build(BuildContext context) {
    if (_currentValue == null) _currentValue = widget.value;

    return GCWDropDown<T>(
      value: _currentValue,
      items: widget.items,
      onChanged: (T value) {
        setState(() {
          _currentValue = value;
        });
        widget.onChanged(value);
      },
      selectedItemBuilder: widget.selectedItemBuilder,
    );
  }
}
