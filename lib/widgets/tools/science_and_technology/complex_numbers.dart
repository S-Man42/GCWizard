import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/complex_numbers.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class ComplexNumbers extends StatefulWidget {
  @override
  ComplexNumbersState createState() => ComplexNumbersState();
}

class ComplexNumbersState extends State<ComplexNumbers> {
  var _currentA = '';
  var _currentB = '';
  var _currentRadius = '';
  var _currentAngle = '';
  var _aController;
  var _bController;
  var _radiusController;
  var _angleController;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _aController = TextEditingController(text: _currentA);
    _bController = TextEditingController(text: _currentB);
    _radiusController = TextEditingController(text: _currentRadius);
    _angleController = TextEditingController(text: _currentAngle);
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _radiusController.dispose();
    _angleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'complex_numbers_cartesian'),
          rightValue: i18n(context, 'complex_numbers_polar'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
            ? Row(
          children: <Widget>[
            Expanded(child: GCWTextField(
            controller: _aController,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
            hintText: i18n(context, 'complex_numbers_hint_a'),
            onChanged: (value) {
              setState(() {
                _currentA = value;
              });
            },
          )),
            Expanded(
              child: GCWTextField(
                controller: _bController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
                hintText: i18n(context, 'complex_numbers_hint_b'),
                onChanged: (value) {
                  setState(() {
                    _currentB = value;
                  });
                },
              )
            )
          ],
        )
            : Row(
          children: <Widget>[
            Expanded(child: GCWTextField(
              controller: _radiusController,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
              hintText: i18n(context, 'complex_numbers_hint_radius'),
              onChanged: (value) {
                setState(() {
                  _currentRadius = value;
                });
              },
            )),
            Expanded(child: GCWTextField(
              controller: _angleController,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]'))],
              hintText: i18n(context, 'complex_numbers_hint_angle'),
              onChanged: (value) {
                setState(() {
                  _currentAngle = value;
                });
              },
            )),
          ],
        ),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.right) {
      return CartesianToPolar(_currentA, _currentB);
    } else {
      return PolarToCartesian(_currentRadius, _currentAngle);
    }
  }
}
