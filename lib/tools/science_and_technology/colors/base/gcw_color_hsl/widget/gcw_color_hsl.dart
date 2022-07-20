import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_hue.dart';
import 'package:gc_wizard/tools/common/gcw_double_spinner/widget/gcw_double_spinner.dart';

class GCWColorHSL extends StatefulWidget {
  final Function onChanged;
  final HSL color;

  const GCWColorHSL({Key key, this.onChanged, this.color}) : super(key: key);

  @override
  _GCWColorHSLState createState() => _GCWColorHSLState();
}

class _GCWColorHSLState extends State<GCWColorHSL> {
  double _currentHue = 0.0;
  double _currentSaturation = 0.0;
  double _currentLightness = 50.0;

  @override
  Widget build(BuildContext context) {
    if (widget.color != null) {
      _currentHue = widget.color.hue;
      _currentSaturation = widget.color.saturation * 100.0;
      _currentLightness = widget.color.lightness * 100.0;
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
          title: 'L',
          min: 0.0,
          max: 100.0,
          value: _currentLightness,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentLightness = value;
            _emitOnChange();
          },
        ),
      ],
    );
  }

  _emitOnChange() {
    widget.onChanged(HSL(_currentHue, _currentSaturation / 100.0, _currentLightness / 100.0));
  }
}
