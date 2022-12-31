import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/units/logic/unit.dart';
import 'package:gc_wizard/common_widgets/units/logic/unit_category.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/widget/gcw_dropdownbutton.dart';

class GCWUnitDropDownButton extends StatefulWidget {
  final Function onChanged;
  final Unit value;
  final List<Unit> unitList;
  final UnitCategory unitCategory;
  final bool onlyShowSymbols;

  const GCWUnitDropDownButton(
      {Key key, this.onChanged, this.value, this.unitList, this.onlyShowSymbols: true, this.unitCategory})
      : super(key: key);

  @override
  GCWUnitDropDownButtonState createState() => GCWUnitDropDownButtonState();
}

class GCWUnitDropDownButtonState extends State<GCWUnitDropDownButton> {
  var _currentUnit;

  @override
  Widget build(BuildContext context) {
    var _currentUnitList = widget.unitList ?? widget.unitCategory.units;

    return GCWDropDownButton(
        value: widget.value ?? _currentUnit,
        onChanged: (newValue) {
          setState(() {
            _currentUnit = newValue;
            widget.onChanged(newValue);
          });
        },
        items: _currentUnitList.map((unit) {
          return GCWDropDownMenuItem(
              value: unit,
              child: widget.onlyShowSymbols
                  ? unit.symbol ?? ''
                  : (i18n(context, unit.name) + (unit.symbol == null ? '' : ' (${unit.symbol})')));
        }).toList());
  }
}
