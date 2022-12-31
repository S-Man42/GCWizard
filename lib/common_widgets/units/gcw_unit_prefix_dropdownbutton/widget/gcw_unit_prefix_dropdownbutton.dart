import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/common_widgets/units/logic/unit_prefix.dart';
import 'package:gc_wizard/common_widgets/base/gcw_dropdownbutton/widget/gcw_dropdownbutton.dart';
import 'package:gc_wizard/common_widgets/base/gcw_text/widget/gcw_text.dart';

class GCWUnitPrefixDropDownButton extends StatefulWidget {
  final Function onChanged;
  final UnitPrefix value;
  final bool onlyShowSymbols;

  const GCWUnitPrefixDropDownButton({Key key, this.onChanged, this.value, this.onlyShowSymbols}) : super(key: key);

  @override
  GCWUnitPrefixDropDownButtonState createState() => GCWUnitPrefixDropDownButtonState();
}

class GCWUnitPrefixDropDownButtonState extends State<GCWUnitPrefixDropDownButton> {
  var _currentPrefix;

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) _currentPrefix = widget.value;

    return GCWDropDownButton(
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
