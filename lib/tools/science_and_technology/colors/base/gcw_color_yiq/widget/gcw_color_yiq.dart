import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/spinners/gcw_double_spinner.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_yuv.dart';

class GCWColorYIQ extends StatefulWidget {
  final Function onChanged;
  final YIQ color;

  const GCWColorYIQ({Key key, this.onChanged, this.color}) : super(key: key);

  @override
  _GCWColorYIQState createState() => _GCWColorYIQState();
}

class _GCWColorYIQState extends State<GCWColorYIQ> {
  double _currentY = 50.0;
  double _currentI = 0.0;
  double _currentQ = 0.0;

  @override
  Widget build(BuildContext context) {
    if (widget.color != null) {
      _currentY = widget.color.y * 100.0;
      _currentI = widget.color.i * 100.0;
      _currentQ = widget.color.q * 100.0;
    }

    return Column(
      children: [
        GCWDoubleSpinner(
          title: 'Y',
          min: 0.0,
          max: 100.0,
          value: _currentY,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentY = value;
            _emitOnChange();
          },
        ),
        GCWDoubleSpinner(
          title: 'I',
          min: -YIQ.I_MAX * 100.0,
          max: -YIQ.I_MAX * 100.0,
          value: _currentI,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentI = value;
            _emitOnChange();
          },
        ),
        GCWDoubleSpinner(
          title: 'Q',
          min: -YIQ.Q_MAX * 100.0,
          max: YIQ.Q_MAX * 100.0,
          value: _currentQ,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentQ = value;
            _emitOnChange();
          },
        ),
      ],
    );
  }

  _emitOnChange() {
    widget.onChanged(YUV(_currentY / 100.0, _currentI / 100.0, _currentQ / 100.0));
  }
}
