import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/keyboard.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class Keyboard extends StatefulWidget {
  @override
  KeyboardState createState() => KeyboardState();
}

class KeyboardState extends State<Keyboard> {
  var _inputController;


  String _currentInput = '';

  KeyboardLayout _currentKeyboardFrom = KeyboardLayout.QWERTZ_T1;
  KeyboardLayout _currentKeyboardTo = KeyboardLayout.Dvorak;

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
    Map KeyboardModeItemsFrom = buildKeyboardsMap(context);
    Map KeyboardModeItemsTo = buildKeyboardsMap(context);

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
              child: Column(
                children: <Widget>[
                  GCWTextDivider(
                      text: i18n(context, 'keyboard_from')
                  ),
                  GCWDropDownButton(
                    value: _currentKeyboardFrom,
                    onChanged: (value) {
                      setState(() {
                        _currentKeyboardFrom = value;
                      });
                    },
                    items: KeyboardModeItemsFrom.entries.map((mode) {
                      return GCWDropDownMenuItem(
                        value: mode.key,
                        child: mode.value,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  GCWTextDivider(
                      text: i18n(context, 'keyboard_to')
                  ),
                  GCWDropDownButton(
                    value: _currentKeyboardTo,
                    onChanged: (value) {
                      setState(() {
                        _currentKeyboardTo = value;
                      });
                    },
                    items: KeyboardModeItemsTo.entries.map((mode) {
                      return GCWDropDownMenuItem(
                        value: mode.key,
                        child: mode.value,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    return GCWDefaultOutput(
      child: GCWOutputText(
          text: encodeKeyboard(_currentInput, _currentKeyboardFrom, _currentKeyboardTo),
      )
    );
  }
}