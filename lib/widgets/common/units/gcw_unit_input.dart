import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';
import 'package:gc_wizard/widgets/common/units/gcw_unit_dropdownbutton.dart';

class GCWUnitInput extends StatefulWidget {
  final min;
  final numberDecimalDigits;
  final double value;
  final List<Unit> unitList;
  final title;

  final Function onChanged;

  GCWUnitInput({
    Key key,
    this.title,
    this.min,
    this.numberDecimalDigits: 3,
    this.value: 0.0,
    this.unitList,
    this.onChanged
  }) : super(key: key);

  @override
  _GCWUnitInputState createState() => _GCWUnitInputState();
}

class _GCWUnitInputState extends State<GCWUnitInput> {
  var _currentUnit;
  var _currentValue;

  @override
  void initState() {
    super.initState();

    _currentValue = widget.value;
    _currentUnit = getReferenceUnit(widget.unitList);

    print(_currentUnit.symbol);
  }

  @override
  Widget build(BuildContext context) {
    return
      Row(
        children: [
          Expanded(
            child: Container(
              child: GCWDoubleSpinner(
                title: widget.title,
                min: widget.min,
                numberDecimalDigits: widget.numberDecimalDigits,
                value: _currentValue,
                onChanged: (value) {
                  setState(() {
                    _currentValue = value;
                    _convertToReferenceAndEmitOnChange();
                  });
                },
              ),
              padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
            ),
            flex: 3
          ),
          Expanded(
            child: GCWUnitDropDownButton(
              value: _currentUnit,
              unitList: widget.unitList,
              onChanged: (value) {
                setState(() {
                  _currentUnit = value;
                  _convertToReferenceAndEmitOnChange();
                });
              },
            ),
            flex: 1
          )
      ]
    );
  }

  _convertToReferenceAndEmitOnChange() {
    var referenceValue = _currentUnit.toReference(_currentValue);
    widget.onChanged(referenceValue);
  }
}
