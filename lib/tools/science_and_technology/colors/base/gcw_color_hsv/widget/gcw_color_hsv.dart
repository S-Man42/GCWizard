import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_double_spinner.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_hue.dart';

class GCWColorHSV extends StatefulWidget {
  final Function onChanged;
  final HSV color;

  const GCWColorHSV({Key key, this.onChanged, this.color}) : super(key: key);

  @override
  _GCWColorHSVState createState() => _GCWColorHSVState();
}

class _GCWColorHSVState extends State<GCWColorHSV> {
  double _currentHue = 0.0;
  double _currentSaturation = 0.0;
  double _currentValue = 50.0;

  @override
  Widget build(BuildContext context) {
    if (widget.color != null) {
      _currentHue = widget.color.hue;
      _currentSaturation = widget.color.saturation * 100.0;
      _currentValue = widget.color.value * 100.0;
    }

    return Column(
      children: [
        GCWDoubleSpinner(
          title: 'H',
          min: 0.0,
          max: 360.0,
          value: _currentHue,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentHue = value;
            _emitOnChange();
          },
        ),
        GCWDoubleSpinner(
          title: 'S',
          min: 0.0,
          max: 100.0,
          value: _currentSaturation,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentSaturation = value;
            _emitOnChange();
          },
        ),
        GCWDoubleSpinner(
          title: 'V',
          min: 0.0,
          max: 100.0,
          value: _currentValue,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentValue = value;
            _emitOnChange();
          },
        ),
      ],
    );
  }

  _emitOnChange() {
    widget.onChanged(HSV(_currentHue, _currentSaturation / 100.0, _currentValue / 100.0));
  }
}
