import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/units/unit.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';

var _prefixes = [
  {'name': 'common_unit_prefix_exa', 'symbol' : 'E', 'value': 1.0e18},
  {'name': 'common_unit_prefix_peta', 'symbol' : 'P', 'value': 1.0e15},
  {'name': 'common_unit_prefix_tera', 'symbol' : 'T', 'value': 1.0e12},
  {'name': 'common_unit_prefix_giga', 'symbol' : 'G', 'value': 1.0e9},
  {'name': 'common_unit_prefix_mega', 'symbol' : 'M', 'value': 1.0e6},
  {'name': 'common_unit_prefix_kilo', 'symbol' : 'k', 'value': 1.0e3},
  {'name': 'common_unit_prefix_hecto', 'symbol' : 'h', 'value': 1.0e2},
  {'name': 'common_unit_prefix_deca', 'symbol' : 'da', 'value': 1.0e1},
  {'name': null, 'symbol' : null, 'value': 1.0},
  {'name': 'common_unit_prefix_deci', 'symbol' : 'd', 'value': 1.0e-1},
  {'name': 'common_unit_prefix_centi', 'symbol' : 'c', 'value': 1.0e-2},
  {'name': 'common_unit_prefix_milli', 'symbol' : 'm', 'value': 1.0e-3},
  {'name': 'common_unit_prefix_micro', 'symbol' : '\u00B5', 'value': 1.0e-6},
  {'name': 'common_unit_prefix_nano', 'symbol' : 'n', 'value': 1.0e-9},
  {'name': 'common_unit_prefix_pico', 'symbol' : 'p', 'value': 1.0e-12},
  {'name': 'common_unit_prefix_femto', 'symbol' : 'f', 'value': 1.0e-15},
  {'name': 'common_unit_prefix_atto', 'symbol' : 'a', 'value': 1.0e-18},
];

class GCWUnitPrefixDropDownButton extends StatefulWidget {
  final Function onChanged;
  final double value;

  const GCWUnitPrefixDropDownButton({Key key, this.onChanged, this.value}) : super(key: key);

  @override
  GCWUnitPrefixDropDownButtonState createState() => GCWUnitPrefixDropDownButtonState();
}

class GCWUnitPrefixDropDownButtonState extends State<GCWUnitPrefixDropDownButton> {
  var _currentPrefix;

  @override
  void initState() {
    super.initState();

    _currentPrefix = _prefixes.firstWhere((element) => widget.value == element['value']);
  }

  @override
  Widget build(BuildContext context) {
    return GCWDropDownButton(
      value: _currentPrefix,
      items: _prefixes.map((prefix) {
        return DropdownMenuItem(
          value: prefix,
          child:  Text(prefix['name'] == null ? '' : i18n(context, prefix['name']) + ' (${prefix['symbol']})'),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _currentPrefix = value;
          widget.onChanged(_currentPrefix);
        });
      },
      selectedItemBuilder: (context) {
        return _prefixes.map((prefix) {
          return Align(
            child: Text(
              prefix['symbol'] == null ? '' : prefix['symbol']
            ),
            alignment: Alignment.centerLeft,
          );
        }).toList();
      }
    );
  }
}
