import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';

class GCWSlider extends StatefulWidget {
  final String title;
  final Function onChanged;
  final double value;
  final double min;
  final double max;
  final bool suppressReset;

  const GCWSlider({Key key, this.title, this.value, this.onChanged, this.min, this.max, this.suppressReset: false})
      : super(key: key);

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
            value: widget.value ?? _currentValue,
            min: widget.min,
            max: widget.max,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
                widget.onChanged(_currentValue);
              });
            },
            activeColor: themeColors().switchThumb2(),
            inactiveColor: themeColors().switchTrack2(),
          ),
          flex: 3,
        ),
        if (!widget.suppressReset)
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
