import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/common/units/length.dart';
import 'package:gc_wizard/logic/common/units/unit_category.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_double_textfield.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';

class GCWDistance extends StatefulWidget {
  final Function onChanged;
  final String hintText;
  final double value;

  const GCWDistance({Key key, this.onChanged, this.hintText, this.value}) : super(key: key);

  @override
  _GCWDistanceState createState() => _GCWDistanceState();
}

class _GCWDistanceState extends State<GCWDistance> {
  var _controller;

  var _currentInput = {'text': '','value': 0.0};
  Length _currentLengthUnit = UNITCATEGORY_LENGTH.defaultUnit;

  @override
  void initState() {
    super.initState();

    if (widget.value != null)
      _currentInput = {'text' : widget.value.toString(), 'value': widget.value};

    _controller = TextEditingController (
      text: _currentInput['text']
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            child: GCWDoubleTextField(
              hintText: widget.hintText ?? i18n(context, 'common_distance_hint'),
              min: 0.0,
              controller: _controller,
              onChanged: (ret) {
                setState(() {
                  _currentInput = ret;
                  _setCurrentValueAndEmitOnChange();
                });
              },
            ),
            padding: EdgeInsets.only(right: DOUBLE_DEFAULT_MARGIN)
          )
        ),
        Expanded(
          flex: 1,
          child: GCWUnitDropDownButton(
            unitList: allLengths(),
            value: _currentLengthUnit,
            onChanged: (Length value) {
              setState(() {
                _currentLengthUnit = value;
                _setCurrentValueAndEmitOnChange();
              });
            }
          ),
        )
      ],
    );
  }

  _setCurrentValueAndEmitOnChange([setTextFieldText = false]) {
    if (setTextFieldText)
      _controller.text = _currentInput.toString();

    double _currentValue = _currentInput['value'];
    var _meters = _currentLengthUnit.toMeter(_currentValue);
    widget.onChanged(_meters);
  }
}
