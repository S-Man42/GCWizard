import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/dvorak.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class Dvorak extends StatefulWidget {
  @override
  DvorakState createState() => DvorakState();
}

class DvorakState extends State<Dvorak> {
  var _inputController;


  String _currentInput = '';

  DvorakMode _currentDvorakModeFrom = DvorakMode.QWERTZ_T1;
  DvorakMode _currentDvorakModeTo = DvorakMode.DVORAK;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var DvorakModeItemsFrom = {
      DvorakMode.QWERTZ_T1 : i18n(context, 'dvorak_keyboard_mode_qwertz_t1'),
      DvorakMode.QWERTY_US_INT : i18n(context, 'dvorak_keyboard_mode_qwerty_us_int'),
      DvorakMode.DVORAK : i18n(context, 'dvorak_keyboard_mode_dvorak'),
      DvorakMode.DVORAK_II_DEU : i18n(context, 'dvorak_keyboard_mode_dvorak_II'),
      DvorakMode.DVORAK_I_DEU1 : i18n(context, 'dvorak_keyboard_mode_dvorak_I1'),
      DvorakMode.DVORAK_I_DEU2 : i18n(context, 'dvorak_keyboard_mode_dvorak_I2'),
      DvorakMode.COLEMAK : i18n(context, 'dvorak_keyboard_mode_colemak'),
      DvorakMode.RISTOME : i18n(context, 'dvorak_keyboard_mode_ristome'),
      DvorakMode.NEO : i18n(context, 'dvorak_keyboard_mode_neo'),
    };
    var DvorakModeItemsTo = {
      DvorakMode.QWERTZ_T1 : i18n(context, 'dvorak_keyboard_mode_qwertz_t1'),
      DvorakMode.QWERTY_US_INT : i18n(context, 'dvorak_keyboard_mode_qwerty_us_int'),
      DvorakMode.DVORAK : i18n(context, 'dvorak_keyboard_mode_dvorak'),
      DvorakMode.DVORAK_II_DEU : i18n(context, 'dvorak_keyboard_mode_dvorak_II'),
      DvorakMode.DVORAK_I_DEU1 : i18n(context, 'dvorak_keyboard_mode_dvorak_I1'),
      DvorakMode.DVORAK_I_DEU2 : i18n(context, 'dvorak_keyboard_mode_dvorak_I2'),
      DvorakMode.COLEMAK : i18n(context, 'dvorak_keyboard_mode_colemak'),
      DvorakMode.RISTOME : i18n(context, 'dvorak_keyboard_mode_ristome'),
      DvorakMode.NEO : i18n(context, 'dvorak_keyboard_mode_neo'),
    };

    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GCWTextDivider(
                  text: i18n(context, 'dvorak_keyboard_from')
              ),
            ),
            Expanded(
              flex: 1,
              child: GCWTextDivider(
                  text: i18n(context, 'dvorak_keyboard_to')
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GCWDropDownButton(
                value: _currentDvorakModeFrom,
                onChanged: (value) {
                  setState(() {
                    _currentDvorakModeFrom = value;
                  });
                },
                items: DvorakModeItemsFrom.entries.map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode.key,
                    child: mode.value,
                  );
                }).toList(),
              ),
            ),
            Expanded(
              flex: 1,
              child:         GCWDropDownButton(
                value: _currentDvorakModeTo,
                onChanged: (value) {
                  setState(() {
                    _currentDvorakModeTo = value;
                  });
                },
                items: DvorakModeItemsTo.entries.map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode.key,
                    child: mode.value,
                  );
                }).toList(),
              ),

            )
          ],
        ),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    return GCWDefaultOutput(
      child: GCWOutputText(
          text: encodeDvorak(_currentInput, _currentDvorakModeFrom, _currentDvorakModeTo),
      )
    );
  }
}