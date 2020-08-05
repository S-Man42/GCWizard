import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';


class GCWNumeralBaseSpinner extends StatefulWidget {
  final Function onChanged;
  final value;

  const GCWNumeralBaseSpinner({Key key, this.onChanged, this.value: 10}) : super(key: key);

  @override
  GCWNumeralBaseSpinnerState createState() => GCWNumeralBaseSpinnerState();
}

class GCWNumeralBaseSpinnerState extends State<GCWNumeralBaseSpinner> {
  int _currentValue;

  final list2To62 = List.generate(61, (i) => i + 2);

  @override
  Widget build(BuildContext context) {
    var list = [];
    list.addAll(list2To62);
    list.addAll(list2To62.map((i) => -i));
    list.sort((a, b) {
      return a.compareTo(b);
    });

    var items = list.map((i) {
      switch (i) {
        case 2: return '$i (${i18n(context, 'common_numeralbase_binary')})';
        case 3: return '$i (${i18n(context, 'common_numeralbase_ternary')})';
        case 4: return '$i (${i18n(context, 'common_numeralbase_quaternary')})';
        case 5: return '$i (${i18n(context, 'common_numeralbase_quinary')})';
        case 6: return '$i (${i18n(context, 'common_numeralbase_senary')})';
        case 7: return '$i (${i18n(context, 'common_numeralbase_septenary')})';
        case 8: return '$i (${i18n(context, 'common_numeralbase_octenary')})';
        case 9: return '$i (${i18n(context, 'common_numeralbase_nonary')})';
        case 10: return '$i (${i18n(context, 'common_numeralbase_denary')})';
        case 11: return '$i (${i18n(context, 'common_numeralbase_undenary')})';
        case 12: return '$i (${i18n(context, 'common_numeralbase_duodenary')})';
        case 16: return '$i (${i18n(context, 'common_numeralbase_hexadecimal')})';
        case 20: return '$i (${i18n(context, 'common_numeralbase_vigesimal')})';
        case 60: return '$i (${i18n(context, 'common_numeralbase_sexagesimal')})';
        default: return '$i';
      }
    }).toList();

    return GCWDropDownSpinner(
      value: _currentValue ?? list.indexOf(widget.value),
      items: items.asMap().map((index, value) {
        return MapEntry(
            index,
            DropdownMenuItem(
              value: index,
              child: Text(value)
            )
        );
      }).values.toList(),
      onChanged: (value) {
        setState(() {
          _currentValue = value;
          widget.onChanged(list[_currentValue]);
        });
      },
    );
  }
}