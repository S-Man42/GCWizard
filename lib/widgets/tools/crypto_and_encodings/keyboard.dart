import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/keyboard.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class Keyboard extends StatefulWidget {
  @override
  KeyboardState createState() => KeyboardState();
}

class KeyboardState extends State<Keyboard> {
  var _inputController;


  String _currentInput = '';

  KeyboardMode _currentKeyboardModeFrom = KeyboardMode.QWERTZ_T1;
  KeyboardMode _currentKeyboardModeTo = KeyboardMode.Dvorak;

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
    var KeyboardModeItemsFrom = {
      KeyboardMode.QWERTZ_T1 : i18n(context, 'keyboard_mode_qwertz_t1'),
      KeyboardMode.QWERTY_US_INT : i18n(context, 'keyboard_mode_qwerty_us_int'),
      KeyboardMode.Dvorak : i18n(context, 'keyboard_mode_dvorak'),
      KeyboardMode.Dvorak_II_DEU : i18n(context, 'keyboard_mode_dvorak_II'),
      KeyboardMode.Dvorak_I_DEU1 : i18n(context, 'keyboard_mode_dvorak_I1'),
      KeyboardMode.Dvorak_I_DEU2 : i18n(context, 'keyboard_mode_dvorak_I2'),
      KeyboardMode.COLEMAK : i18n(context, 'keyboard_mode_colemak'),
      KeyboardMode.RISTOME : i18n(context, 'keyboard_mode_ristome'),
      KeyboardMode.NEO : i18n(context, 'keyboard_mode_neo'),
    };
    var KeyboardModeItemsTo = {
      KeyboardMode.QWERTZ_T1 : i18n(context, 'keyboard_mode_qwertz_t1'),
      KeyboardMode.QWERTY_US_INT : i18n(context, 'keyboard_mode_qwerty_us_int'),
      KeyboardMode.Dvorak : i18n(context, 'keyboard_mode_dvorak'),
      KeyboardMode.Dvorak_II_DEU : i18n(context, 'keyboard_mode_dvorak_II'),
      KeyboardMode.Dvorak_I_DEU1 : i18n(context, 'keyboard_mode_dvorak_I1'),
      KeyboardMode.Dvorak_I_DEU2 : i18n(context, 'keyboard_mode_dvorak_I2'),
      KeyboardMode.COLEMAK : i18n(context, 'keyboard_mode_colemak'),
      KeyboardMode.RISTOME : i18n(context, '_keyboard_mode_ristome'),
      KeyboardMode.NEO : i18n(context, 'keyboard_mode_neo'),
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
                  text: i18n(context, 'keyboard_from')
              ),
            ),
            Expanded(
              flex: 1,
              child: GCWTextDivider(
                  text: i18n(context, 'keyboard_to')
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GCWDropDownButton(
                value: _currentKeyboardModeFrom,
                onChanged: (value) {
                  setState(() {
                    _currentKeyboardModeFrom = value;
                  });
                },
                items: KeyboardModeItemsFrom.entries.map((mode) {
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
                value: _currentKeyboardModeTo,
                onChanged: (value) {
                  setState(() {
                    _currentKeyboardModeTo = value;
                  });
                },
                items: KeyboardModeItemsTo.entries.map((mode) {
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
          text: encodeKeyboard(_currentInput, _currentKeyboardModeFrom, _currentKeyboardModeTo),
      )
    );
  }
}