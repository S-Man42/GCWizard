import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_hue.dart';
import 'package:gc_wizard/common_widgets/gcw_double_spinner/widget/gcw_double_spinner.dart';

class GCWColorHSI extends StatefulWidget {
  final Function onChanged;
  final HSI color;

  const GCWColorHSI({Key key, this.onChanged, this.color}) : super(key: key);

  @override
  _GCWColorHSIState createState() => _GCWColorHSIState();
}

class _GCWColorHSIState extends State<GCWColorHSI> {
  double _currentHue = 0.0;
  double _currentSaturation = 0.0;
  double _currentIntensity = 50.0;

  @override
  Widget build(BuildContext context) {
    if (widget.color != null) {
      _currentHue = widget.color.hue;
      _currentSaturation = widget.color.saturation * 100.0;
      _currentIntensity = widget.color.intensity * 100.0;
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
          title: 'I',
          min: 0.0,
          max: 100.0,
          value: _currentIntensity,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentIntensity = value;
            _emitOnChange();
          },
        ),
      ],
    );
  }

  _emitOnChange() {
    widget.onChanged(HSI(_currentHue, _currentSaturation / 100.0, _currentIntensity / 100.0));
  }
}
