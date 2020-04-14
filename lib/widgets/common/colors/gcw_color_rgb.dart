import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors.dart';
import 'package:gc_wizard/logic/tools/miscellaneous/colors/colors_rgb.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';

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
          title: 'Red',
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
          title: 'Green',
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
          title: 'Blue',
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