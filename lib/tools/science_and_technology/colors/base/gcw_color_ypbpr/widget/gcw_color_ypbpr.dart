import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/gcw_double_spinner/gcw_double_spinner.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors.dart';
import 'package:gc_wizard/tools/science_and_technology/colors/logic/colors_yuv.dart';

class GCWColorYPbPr extends StatefulWidget {
  final Function onChanged;
  final YPbPr color;

  const GCWColorYPbPr({Key key, this.onChanged, this.color}) : super(key: key);

  @override
  _GCWColorYPbPrState createState() => _GCWColorYPbPrState();
}

class _GCWColorYPbPrState extends State<GCWColorYPbPr> {
  double _currentY = 50.0;
  double _currentPb = 0.0;
  double _currentPr = 0.0;

  @override
  Widget build(BuildContext context) {
    if (widget.color != null) {
      _currentY = widget.color.y * 100.0;
      _currentPb = widget.color.pb * 100.0;
      _currentPr = widget.color.pr * 100.0;
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
          title: 'Pb',
          min: -0.5 * 100.0,
          max: 0.5 * 100.0,
          value: _currentPb,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentPb = value;
            _emitOnChange();
          },
        ),
        GCWDoubleSpinner(
          title: 'Pr',
          min: -0.5 * 100.0,
          max: 0.5 * 100.0,
          value: _currentPr,
          numberDecimalDigits: COLOR_DOUBLE_PRECISION,
          onChanged: (value) {
            _currentPr = value;
            _emitOnChange();
          },
        ),
      ],
    );
  }

  _emitOnChange() {
    widget.onChanged(YPbPr(_currentY / 100.0, _currentPb / 100.0, _currentPr / 100.0));
  }
}
