import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';


class GCWUnitDropDownButton extends StatefulWidget {
  final Function onChanged;
  final Unit value;
  final List<Unit> unitList;
  final bool onlyShowSymbols;

  const GCWUnitDropDownButton({Key key, this.onChanged, this.value, this.unitList, this.onlyShowSymbols}) : super(key: key);

  @override
  GCWUnitDropDownButtonState createState() => GCWUnitDropDownButtonState();
}

class GCWUnitDropDownButtonState extends State<GCWUnitDropDownButton> {
  var _currentUnit;

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: widget.value ?? _currentUnit,
      onChanged: (newValue) {
        setState(() {
          _currentUnit = newValue;
          widget.onChanged(newValue);
        });
      },
      items: widget.unitList.map((unit) {
        return DropdownMenuItem(
          value: unit,
          child: Text(i18n(context, unit.name) + (unit.symbol == null ? '' : ' (${unit.symbol})')),
        );
      }).toList(),
      selectedItemBuilder: (context) {
        return widget.unitList.map((unit) {
          return Align(
            child: Text(
              widget.onlyShowSymbols
                ? unit.symbol ?? ''
                : (i18n(context, unit.name) + (unit.symbol == null ? '' : ' (${unit.symbol})'))
            ),
            alignment: Alignment.centerLeft,
          );
        }).toList();
      }
    );
  }
}
