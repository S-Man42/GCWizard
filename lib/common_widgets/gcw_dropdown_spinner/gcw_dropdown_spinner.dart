import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/gcw_dropdownbutton.dart';
import 'package:gc_wizard/common_widgets/base/gcw_iconbutton/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/base/gcw_text/gcw_text.dart';
import 'package:gc_wizard/tools/utils/common_widget_utils/widget/common_widget_utils.dart';

class GCWDropDownSpinner extends StatefulWidget {
  final Function onChanged;
  final index;
  final List<dynamic> items;
  final SpinnerLayout layout;
  final String title;

  const GCWDropDownSpinner(
      {Key key, this.onChanged, this.title, this.index, this.items, this.layout: SpinnerLayout.HORIZONTAL})
      : super(key: key);

  @override
  GCWDropDownSpinnerState createState() => GCWDropDownSpinnerState();
}

class GCWDropDownSpinnerState extends State<GCWDropDownSpinner> {
  int _currentIndex;

  _increaseValue() {
    setState(() {
      _setValueAndEmitOnChange((_currentIndex + 1) % widget.items.length);
    });
  }

  _decreaseValue() {
    setState(() {
      _setValueAndEmitOnChange((_currentIndex - 1) % widget.items.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentIndex = widget.index ?? 0;

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
                  Expanded(child: _buildDropDownButton()),
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
                _buildDropDownButton(),
                GCWIconButton(icon: Icons.arrow_drop_down, onPressed: _decreaseValue),
              ],
            ),
          )
        ],
      );
    }
  }

  Widget _buildTitle() {
    return widget.title == null ? Container() : Expanded(child: GCWText(text: widget.title + ':'), flex: 1);
  }

  _buildDropDownButton() {
    return Container(
      child: GCWDropDownButton(
        value: (widget.index ?? _currentIndex) % widget.items.length,
        onChanged: (newValue) {
          setState(() {
            _setValueAndEmitOnChange(newValue);
          });
        },
        items: (widget.items is List<GCWDropDownMenuItem>)
            ? widget.items
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

  _setValueAndEmitOnChange(int newIndex) {
    _currentIndex = newIndex;
    widget.onChanged(_currentIndex);
  }
}
