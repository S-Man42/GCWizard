import 'package:flutter/material.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/common_widgets/spinners/spinner_constants.dart';

class GCWDropDownSpinner extends StatefulWidget {
  final void Function(int) onChanged;
  final int index;
  final List<Object> items;
  final SpinnerLayout layout;
  final String? title;

  const GCWDropDownSpinner(
      {Key? key, required this.onChanged, this.title, required this.index, required this.items, this.layout = SpinnerLayout.HORIZONTAL})
      : super(key: key);

  @override
  GCWDropDownSpinnerState createState() => GCWDropDownSpinnerState();
}

class GCWDropDownSpinnerState extends State<GCWDropDownSpinner> {
  late int _currentIndex;

  void _increaseValue() {
    setState(() {
      _setValueAndEmitOnChange((_currentIndex + 1) % widget.items.length);
    });
  }

  void _decreaseValue() {
    setState(() {
      _setValueAndEmitOnChange((_currentIndex - 1) % widget.items.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentIndex = widget.index;

    if (widget.layout == SpinnerLayout.HORIZONTAL) {
      return Row(
        children: <Widget>[
          _buildTitle(),
          Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    child: GCWIconButton(icon: Icons.remove, onPressed: _decreaseValue),
                    margin: EdgeInsets.only(right: DEFAULT_MARGIN),
                  ),
                  Expanded(child: _buildDropDown()),
                  Container(
                    child: GCWIconButton(icon: Icons.add, onPressed: _increaseValue),
                    margin: EdgeInsets.only(left: DEFAULT_MARGIN),
                  )
                ],
              ),
              flex: 3)
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          _buildTitle(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GCWIconButton(icon: Icons.arrow_drop_up, onPressed: _increaseValue),
                _buildDropDown(),
                GCWIconButton(icon: Icons.arrow_drop_down, onPressed: _decreaseValue),
              ],
            ),
          )
        ],
      );
    }
  }

  Widget _buildTitle() {
    return widget.title == null ? Container() : Expanded(child: GCWText(text: widget.title! + ':'), flex: 1);
  }

  Container _buildDropDown() {
    return Container(
      child: GCWDropDown<int>(
        value: widget.index % widget.items.length,
        onChanged: (int newValue) {
          setState(() {
            _setValueAndEmitOnChange(newValue);
          });
        },
        items: (widget.items is List<GCWDropDownMenuItem>)
            ? widget.items as List<GCWDropDownMenuItem>
            : widget.items
                .asMap()
                .map((index, item) {
                  return MapEntry(index, GCWDropDownMenuItem(value: index, child: item));
                })
                .values
                .toList(),
      ),
      padding: EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
    );
  }

  void _setValueAndEmitOnChange(int newIndex) {
    _currentIndex = newIndex;
    widget.onChanged(_currentIndex);
  }
}
