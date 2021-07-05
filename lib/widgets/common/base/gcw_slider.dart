import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';

class GCWSlider extends StatefulWidget {
  final String title;
  final Function onChanged;
  final double value;
  final double min;
  final double max;

  const GCWSlider({Key key, this.title, this.value, this.onChanged, this.min, this.max}) : super(key: key);

  @override
  _GCWSliderState createState() => _GCWSliderState();
}

class _GCWSliderState extends State<GCWSlider> {
  var _currentValue;

  var _initialValue;

  @override
  void initState() {
    super.initState();

    _initialValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if ((widget.title ?? '').length > 0) Expanded(child: GCWText(text: widget.title + ':')),
        Expanded(
          child: Slider(
              value: _currentValue ?? widget.value,
              min: widget.min,
              max: widget.max,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                  widget.onChanged(_currentValue);
                });
              }),
          flex: 3,
        ),
        GCWIconButton(
          iconData: Icons.refresh,
          size: IconButtonSize.SMALL,
          onPressed: () {
            setState(() {
              _currentValue = _initialValue;
              widget.onChanged(_currentValue);
            });
          },
        )
      ],
    );
  }
}
