/*
        GCWUnitInput(
          title: i18n(context, titleInput1),
          min: 0.0,
          numberDecimalDigits: 3,
          value: _currentInput1,
          unit, _currentUnit1,
          items: unit1,
          onChanged: (value) {
            setState(() {
              _currentInput1 = value;
              _currentUnit1 = unit;
            }
          }

         */


import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/gcw_unit_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_double_spinner.dart';


class GCWUnitInput extends StatefulWidget {
  final Function onValueChanged;
  final Function onUnitChanged;
  final min;
  final numberDecimalDigits;
  var value;
  var unit;
  final items;
  final title;

  GCWUnitInput({Key key, this.title, this.min, this. numberDecimalDigits, this.value, this.unit, this.items, this.onValueChanged, this.onUnitChanged}) : super(key: key);

  @override
  _GCWUnitInputState createState() => _GCWUnitInputState();
}


class _GCWUnitInputState extends State<GCWUnitInput> {
  var _currentUnit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
                child: Container(
                  child: GCWDoubleSpinner(
                    title: i18n(context, widget.title),
                    min: widget.min,
                    numberDecimalDigits: widget.numberDecimalDigits,
                    value: widget.value,
                    onChanged: (value) {
                      setState(() {
                        widget.value = value;
                      });
                    },
                  ),
                  padding: EdgeInsets.only(right: 2 * DEFAULT_MARGIN),
                ),
                flex: 3
            ),
            Expanded(
                child: GCWUnitDropDownButton(
                  value: widget.unit,
                  onChanged: (value) {
                    setState(() {
                      widget.unit = value;
                    });
                  },
                ),
                flex: 1
            )
          ], // children
        ),
      ]
    );
  }
}
