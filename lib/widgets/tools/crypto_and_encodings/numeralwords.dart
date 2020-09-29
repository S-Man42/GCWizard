import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeralwords.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class NumeralWords extends StatefulWidget {
  @override
  NumeralWordsState createState() => NumeralWordsState();
}

class NumeralWordsState extends State<NumeralWords> {
  TextEditingController _decodeController;

  var _currentDecodeInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentDecodeMode = GCWSwitchPosition.left;
  var _currentLanguage = NumeralWordsLanguage.DE;

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
    var NumeralWordsLanguageItems = {
      NumeralWordsLanguage.DE : i18n(context, 'numeralwords_language_de'),
      NumeralWordsLanguage.EN : i18n(context, 'numeralwords_language_en'),
      NumeralWordsLanguage.FR : i18n(context, 'numeralwords_language_fr'),
      NumeralWordsLanguage.IT : i18n(context, 'numeralwords_language_it'),
      NumeralWordsLanguage.ES : i18n(context, 'numeralwords_language_es'),
      NumeralWordsLanguage.ALL : i18n(context, 'numeralwords_language_all'),
    };

    return Column(
      children: <Widget>[
        GCWDropDownButton(//choose language
          value: _currentLanguage,
          onChanged: (value) {
            setState(() {
              _currentLanguage = value;
            });
          },
          items: NumeralWordsLanguageItems.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'numeralwords_mode_left'),
          rightValue: i18n(context, 'numeralwords_mode_right'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left //show numeralwords for a specific language
            ? Container()
            : Column(
                children: <Widget>[
                  GCWTextField(
                    controller: _decodeController,
                    onChanged: (text) {
                      setState(() {
                        _currentDecodeInput = text;
                      });
                    },
                  ),
                  GCWTwoOptionsSwitch(
                    leftValue: i18n(context, 'numeralwords_decodemode_left'),
                    rightValue: i18n(context, 'numeralwords_decodemode_right'),
                    onChanged: (value) {
                      setState(() {
                        _currentDecodeMode = value;
                      });
                    },
                  )                ],
              ),
        GCWTextDivider(
            text: i18n(context, 'common_output')
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    var output = '';
    Map<String, String> words;

    if (_currentMode == GCWSwitchPosition.left) {//show numeral words for specific language
      switch (_currentLanguage) {
        case NumeralWordsLanguage.DE: words = NumToWordDE;
          break;
        case NumeralWordsLanguage.EN: words = NumToWordEN;
          break;
        case NumeralWordsLanguage.FR: words = NumToWordFR;
          break;
        case NumeralWordsLanguage.IT: words = NumToWordIT;
          break;
        case NumeralWordsLanguage.ES: words = NumToWordES;
          break;
        case NumeralWordsLanguage.ALL:
          return GCWOutputText(
            text: i18n(context, 'numeralwords_language_all_not_feasible'),
          );
          break;
      }
      for (int i = 0; i < words.length; i++){
        if (words[i.toString()] != null)
          output = output + i.toString() + ' - ' + words[i.toString()] + '\n';
      }
    } else
      output = decodeNumeralwords(_currentDecodeInput.toUpperCase(), _currentLanguage, _currentDecodeMode);

    return GCWOutputText(
        text: output,
    );
  }
}