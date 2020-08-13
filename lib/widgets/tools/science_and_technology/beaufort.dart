import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/beaufort.dart';
import 'package:gc_wizard/logic/units/velocity.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_velocity_dropdownbutton.dart';
import 'package:intl/intl.dart';

class Beaufort extends StatefulWidget {
  @override
  BeaufortState createState() => BeaufortState();
}

class BeaufortState extends State<Beaufort> {
  var _currentMode = GCWSwitchPosition.left;

  var _currentVelocityInput = 0.0;
  var _currentVelocityUnit = defaultVelocity;

  var _currentBeaufortInput = 0;
  var _currentOutputUnit = defaultVelocity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'beaufort_mode_left'),
          rightValue: i18n(context, 'beaufort_mode_right'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
          ? Row(
              children: [
                Expanded(
                  child: Container(
                    child: GCWDoubleSpinner(
                      min: 0.0,
                      value: _currentVelocityInput,
                      onChanged: (value) {
                        setState(() {
                          _currentVelocityInput = value;
                        });
                      },
                    ),
                    padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                  ),
                  flex: 3
                ),
                Expanded(
                  child: GCWVelocityDropDownButton(
                    value: _currentVelocityUnit,
                    onChanged: (value) {
                      setState(() {
                        _currentVelocityUnit = value;
                      });
                    },
                  ),
                  flex: 1
                )
              ],
            )
          : Column(
              children: [
                GCWIntegerSpinner(
                  min: 0,
                  max: 17,
                  value: _currentBeaufortInput,
                  onChanged: (value) {
                    setState(() {
                      _currentBeaufortInput = value;
                    });
                  },
                ),
                GCWTextDivider(
                  text: 'Output Unit'
                ),
                GCWVelocityDropDownButton(
                  value: _currentOutputUnit,
                  onChanged: (value) {
                    setState(() {
                      _currentOutputUnit = value;
                    });
                  }
                ),
              ],
            ),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      var speed = _currentVelocityUnit.toMS(_currentVelocityInput);
      return meterPerSecondToBeaufort(speed).toString();
    } else {
      var format = NumberFormat('0');
      if (_currentOutputUnit.symbol == 'm/s')
        format = NumberFormat('0.0');

      var range = beaufortToMeterPerSecond(_currentBeaufortInput);
      var lower = _currentOutputUnit.fromMS(range[0]);

      var out = format.format(lower);

      var upper = range[1];
      if (upper.isInfinite) {
        return '\u2265 ' + out;
      } else {
        upper = _currentOutputUnit.fromMS(upper);
        return out + ' - ' + format.format(upper);
      }
    }
  }
}
