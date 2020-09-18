import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/logic/units/unit_category.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';


class GCWUnitDropDownButton extends StatefulWidget {
  final Function onChanged;
  final Unit value;
  final List<Unit> unitList;
  final UnitCategory unitCategory;
  final bool onlyShowSymbols;

  const GCWUnitDropDownButton({Key key, this.onChanged, this.value, this.unitList, this.onlyShowSymbols: true, this.unitCategory}) : super(key: key);

  @override
  GCWUnitDropDownButtonState createState() => GCWUnitDropDownButtonState();
}

class GCWUnitDropDownButtonState extends State<GCWUnitDropDownButton> {
  var _currentUnit;
  var _currentUnitList;

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
        return DropdownMenuItem(
          value: unit,
          child: GCWText(
            text: widget.onlyShowSymbols
              ? unit.symbol ?? ''
              : (i18n(context, unit.name) + (unit.symbol == null ? '' : ' (${unit.symbol})'))
          ),
        );
      }).toList()
    );
  }
}
