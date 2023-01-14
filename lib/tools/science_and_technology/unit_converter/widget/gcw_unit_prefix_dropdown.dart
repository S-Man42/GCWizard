import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/gcw_text.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/science_and_technology/unit_converter/logic/unit_prefix.dart';

class GCWUnitPrefixDropDown extends StatefulWidget {
  final Function onChanged;
  final UnitPrefix value;
  final bool onlyShowSymbols;

  const GCWUnitPrefixDropDown({Key key, this.onChanged, this.value, this.onlyShowSymbols}) : super(key: key);

  @override
  GCWUnitPrefixDropDownState createState() => GCWUnitPrefixDropDownState();
}

class GCWUnitPrefixDropDownState extends State<GCWUnitPrefixDropDown> {
  var _currentPrefix;

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) _currentPrefix = widget.value;

    return GCWDropDown(
        value: _currentPrefix,
        items: unitPrefixes.map((prefix) {
          return GCWDropDownMenuItem(
            value: prefix,
            child: prefix.key == null ? '' : i18n(context, prefix.key) + ' (${prefix.symbol})',
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _currentPrefix = value;
            widget.onChanged(_currentPrefix);
          });
        },
        selectedItemBuilder: (context) {
          return unitPrefixes.map((prefix) {
            return Align(
              child: GCWText(
                  text: widget.onlyShowSymbols
                      ? prefix.symbol ?? ''
                      : ((i18n(context, prefix.key) ?? '') + (prefix.symbol == null ? '' : ' (${prefix.symbol})'))),
              alignment: Alignment.centerLeft,
            );
          }).toList();
        });
  }
}
