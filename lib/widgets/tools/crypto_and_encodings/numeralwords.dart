import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeralwords.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumeralWords extends StatefulWidget {
  @override
  NumeralWordsState createState() => NumeralWordsState();
}

class NumeralWordsState extends State<NumeralWords> {
  TextEditingController _decodeController;

  var _currentDecodeInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentDecodeMode = GCWSwitchPosition.left;
  var _currentLanguage = NumeralWordsLanguage.DEU;

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

    return Column(
      children: <Widget>[
        GCWDropDownButton(
          value: _currentLanguage,
          onChanged: (value) {
            setState(() {
              _currentLanguage = value;
            });
          },
          items: languageList(context).entries.map((mode) {
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
                  )],
              ),
        GCWTextDivider(
            text: i18n(context, 'common_output')
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_currentLanguage == NumeralWordsLanguage.ALL)
        return GCWOutputText(
          text: i18n(context, 'numeralwords_language_all_not_feasible'),
        );
      else {
        return GCWDefaultOutput(
          child: Column(
            children: columnedMultiLineOutput(
              numeralWordsMap(_currentLanguage).entries.map((entry) {
                if (int.tryParse(entry.value) != null)
                  return [entry.key, entry.value];
              }).toList()
            ),
          ),
        );
      }
    } else
      return GCWOutputText(
        text: decodeNumeralwords(_currentDecodeInput.toLowerCase(), _currentLanguage, (_currentDecodeMode == GCWSwitchPosition.left)),
        isMonotype: true,
      );
  }
}