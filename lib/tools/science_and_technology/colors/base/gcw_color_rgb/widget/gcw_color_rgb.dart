import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_rgb.dart';
import 'package:gc_wizard/common_widgets/gcw_double_spinner/widget/gcw_double_spinner.dart';

class GCWColorRGB extends StatefulWidget {
  final Function onChanged;
  final RGB color;

  const GCWColorRGB({Key key, this.onChanged, this.color}) : super(key: key);

  @override
  _GCWColorRGBState createState() => _GCWColorRGBState();
}

class _GCWColorRGBState extends State<GCWColorRGB> {
  double _currentRed = 128.0;
  double _currentGreen = 128.0;
  double _currentBlue = 128.0;

  @override
  Widget build(BuildContext context) {
    if (widget.color != null) {
      _currentRed = widget.color.red;
      _currentGreen = widget.color.green;
      _currentBlue = widget.color.blue;
    }

    return Column(
      children: [
        GCWDoubleSpinner(
          title: 'R',
          min: 0.0,
          max: 255.0,
          value: _currentRed,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentRed = value;
            _emitOnChange();
          },
        ),
        GCWDoubleSpinner(
          title: 'G',
          min: 0.0,
          max: 255.0,
          value: _currentGreen,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentGreen = value;
            _emitOnChange();
          },
        ),
        GCWDoubleSpinner(
          title: 'B',
          min: 0.0,
          max: 255.0,
          value: _currentBlue,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentBlue = value;
            _emitOnChange();
          },
        ),
      ],
    );
  }

  _emitOnChange() {
    widget.onChanged(RGB(_currentRed, _currentGreen, _currentBlue));
  }
}
