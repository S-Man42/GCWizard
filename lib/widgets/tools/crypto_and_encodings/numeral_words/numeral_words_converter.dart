import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumeralWordsConverter extends StatefulWidget {
  @override
  NumeralWordsConverterState createState() => NumeralWordsConverterState();
}

class NumeralWordsConverterState extends State<NumeralWordsConverter> {
  TextEditingController _decodeController;

  var _currentDecodeInput = '';

  var _currentLanguage = NumeralWordsLanguage.NAVI;

  int _currentNumber = 0;

  SplayTreeMap<String, NumeralWordsLanguage> _LANGUAGES;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;


  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _decodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_LANGUAGES == null) {
      _LANGUAGES = SplayTreeMap.from(
          switchMapKeyValue(NUMERALWORDS_LANGUAGES_CONVERTER).map((key, value) => MapEntry(
              i18n(context, key),
              value
          ))
      );
    }

    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentLanguage,
          onChanged: (value) {
            setState(() {
              _currentLanguage = value;
            });
          },
          items: _LANGUAGES.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.value,
              child: mode.key,
            );
          }).toList(),
        ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        if (_currentMode == GCWSwitchPosition.right) // decode
          GCWTextField(
            controller: _decodeController,
            onChanged: (text) {
              setState(() {
                _currentDecodeInput = text;
              });
            },
          )
        else // encode
          GCWIntegerSpinner(
            title: i18n(context, 'numeralwords_converter_number'),
            min: 0,
            max: 32767,
            value: _currentNumber,
            onChanged: (value) {
              setState(() {
                _currentNumber = value;
              });
            },
          ),

        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String output = '';
    if (_currentMode == GCWSwitchPosition.right) { // decode
      output = decodeNumeralWordToNumber(_currentLanguage, removeAccents(_currentDecodeInput));
      if (output.startsWith('numeralwords_converter_error_navi'))
        output = i18n(context, 'numeralwords_converter_error_navi');
    } else
      output = encodeNumberToNumeralWord(_currentLanguage, _currentNumber);

    return GCWDefaultOutput(
        child: Column(
          children: <Widget>[
            if (_currentLanguage == NumeralWordsLanguage.NAVI)
              Column(
                children: <Widget>[
                  GCWTextDivider(
                      text: i18n(context, 'common_numeralbase_octenary')
                  ),
                  if (_currentMode == GCWSwitchPosition.left)  // encode
                    GCWOutputText(
                      text: convertBase(_currentNumber.toString(), 10, 8),
                    )
                  else
                    GCWOutputText(
                      text: convertBase(output, 10, 8),
                    )
                ],
              ),
            if (_currentMode == GCWSwitchPosition.right)  // decode
              GCWTextDivider(
                  text: i18n(context, 'common_numeralbase_denary')
              )
            else
              GCWTextDivider(
                text: i18n(context, 'numeralwords_converter_numeralword')
              ),
            GCWOutputText(
              text: output,
            ),
          ]
        ));
  }
}
