import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';


class GCWDropDownSpinner extends StatefulWidget {
  final Function onChanged;
  final value;
  final items;
  final SpinnerLayout layout;

  const GCWDropDownSpinner({
    Key key,
    this.onChanged,
    this.value,
    this.items,
    this.layout:
    SpinnerLayout.horizontal
  }) : super(key: key);

  @override
  GCWDropDownSpinnerState createState() => GCWDropDownSpinnerState();
}

class GCWDropDownSpinnerState extends State<GCWDropDownSpinner> {
  int _currentValue;

  _increaseValue() {
    setState(() {
      _currentValue = (_currentValue + 1) % widget.items.length;
      widget.onChanged(_currentValue);
    });
  }

  _decreaseValue() {
    setState(() {
      _currentValue = (_currentValue - 1) % widget.items.length;
      widget.onChanged(_currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentValue = widget.value ?? 0;

    if (widget.layout == SpinnerLayout.horizontal) {
      return Row(
        children: <Widget>[
          GCWIconButton(
            iconData: Icons.remove,
            onPressed: _decreaseValue
          ),
          Expanded(
            child: _buildDropDownButton()
          ),
          GCWIconButton(
            iconData: Icons.add,
            onPressed: _increaseValue
          ),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GCWIconButton(
                  iconData: Icons.arrow_drop_up,
                  onPressed: _increaseValue
                ),
                _buildDropDownButton(),
                GCWIconButton(
                  iconData: Icons.arrow_drop_down,
                  onPressed: _decreaseValue
                ),
              ],
            ),
          )
        ],
      );
    }
  }

  _buildDropDownButton() {
    return Container(
      child: GCWDropDownButton(
        value: (widget.value ?? _currentValue) % widget.items.length,
        onChanged: (newValue) {
          setState(() {
            _currentValue = newValue;
            widget.onChanged(_currentValue);
          });
        },
        items: widget.items,
      ),
      padding: EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
    );
  }
}