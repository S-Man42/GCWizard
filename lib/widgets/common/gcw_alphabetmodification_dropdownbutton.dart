import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';


class GCWAlphabetModificationDropDownButton extends StatefulWidget {
  final Function onChanged;
  final value;

  const GCWAlphabetModificationDropDownButton({
    Key key,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  GCWAlphabetModificationDropDownButtonState createState() => GCWAlphabetModificationDropDownButtonState();
}

class GCWAlphabetModificationDropDownButtonState extends State<GCWAlphabetModificationDropDownButton> {
  AlphabetModificationMode _currentValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GCWText(
            text: i18n(context, 'common_alphabetmodification_title') + ':'
          ),
          flex: 1
        ),
        Expanded(
          child: GCWDropDownButton(
            value: _currentValue ?? widget.value ?? AlphabetModificationMode.J_TO_I,
            onChanged: (newValue) {
              setState(() {
                _currentValue = newValue;
                widget.onChanged(_currentValue);
              });
            },
            items: [
              {'mode': AlphabetModificationMode.J_TO_I, 'text' : 'common_alphabetmodification_jtoi'},
              {'mode': AlphabetModificationMode.C_TO_K, 'text' : 'common_alphabetmodification_ctok'},
              {'mode': AlphabetModificationMode.W_TO_VV, 'text' : 'common_alphabetmodification_wtovv'},
              {'mode': AlphabetModificationMode.REMOVE_Q, 'text' : 'common_alphabetmodification_removeq'},
            ].map((entry) {
              return DropdownMenuItem(
                value: entry['mode'],
                child: Text(i18n(context, entry['text'])),
              );
            }).toList(),
          ),
          flex: 2
        )
      ],
    );
  }
}