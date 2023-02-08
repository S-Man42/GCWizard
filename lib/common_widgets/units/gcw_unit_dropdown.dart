import 'package:flutter/material.dart';
import 'package:gc_wizard/application/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_category.dart';

class GCWUnitDropDown extends StatefulWidget {
  final void Function(Unit) onChanged;
  final Unit value;
  final List<Unit>? unitList;
  final UnitCategory? unitCategory;
  final bool onlyShowSymbols;

  const GCWUnitDropDown(
      {Key? key, required this.onChanged, required this.value, this.unitList,
        this.onlyShowSymbols = true, this.unitCategory})
      : super(key: key);

  @override
  GCWUnitDropDownState createState() => GCWUnitDropDownState();
}

class GCWUnitDropDownState extends State<GCWUnitDropDown> {
  Unit? _currentUnit;

  @override
  Widget build(BuildContext context) {
    var _currentUnitList = widget.unitList ?? widget.unitCategory?.units ?? [];

    return GCWDropDown<Unit>(
        value: widget.value,
        onChanged: (Unit newValue) {
          setState(() {
            _currentUnit = newValue;
            if (_currentUnit is Unit) widget.onChanged(_currentUnit!);
          });
        },
        items: _currentUnitList.map((unit) {
          return GCWDropDownMenuItem(
              value: unit,
              child: widget.onlyShowSymbols
                  ? unit.symbol ?? ''
                  : (i18n(context, unit.name) + ' (${unit.symbol})'));
        }).toList());
  }
}
