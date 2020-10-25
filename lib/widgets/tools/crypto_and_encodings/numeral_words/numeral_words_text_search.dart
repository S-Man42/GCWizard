import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class NumeralWordsTextSearch extends StatefulWidget {
  @override
  NumeralWordsTextSearchState createState() => NumeralWordsTextSearchState();
}

class NumeralWordsTextSearchState extends State<NumeralWordsTextSearch> {
  TextEditingController _decodeController;

  var _currentDecodeInput = '';
  GCWSwitchPosition _currentDecodeMode = GCWSwitchPosition.left;
  var _currentLanguage = NumeralWordsLanguage.DEU;
  Map<NumeralWordsLanguage, String> _languageList;

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
          items: NUMERALWORDS_LANGUAGES.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: i18n(context, mode.value),
            );
          }).toList(),
        ),
        Column(
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
              value: _currentDecodeMode,
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

  List<Widget> _columnedDetailedOutput(BuildContext context, List<NumeralWordsDecodeOutput> data){
    if (data != null) {
      var odd = true;
      List<Widget> outputList = new List<Widget>();
      Widget outputRow;

      for (int i = 0; i < data.length; i++) {
        var row = Container(
          child: Row(
              children: <Widget>[
                Expanded(
                    child: GCWText(
                      //text: numbers[i]
                        text: data[i].number
                    ),
                    flex: 1
                ),
                Expanded(
                    child: GCWText(
                      //text: numWords[i]
                        text: data[i].numWord
                    ),
                    flex: 4
                ),
                Expanded(
                    child: GCWText(
                      //text: i18n(context, languages[i])
                        text: _currentLanguage == NumeralWordsLanguage.ALL
                            ? i18n(context, data[i].language)
                            : ''
                    ),
                    flex: 1
                )
              ]
          ),
          margin: EdgeInsets.only(
              top: 6,
              bottom: 6
          ),
        );

        if (odd) {
          outputRow = Container(
              color: themeColors().outputListOddRows(),
              child: row
          );
        } else {
          outputRow = Container(
              child: row
          );
        }
        odd = !odd;
        outputList.add(outputRow);
      }
      return outputList;
    } else
      return [Container()];
  }

  Widget _buildOutput(BuildContext context) {
    var detailedOutput;
    String output = '';
    if (_currentLanguage != NumeralWordsLanguage.KYR) {
       detailedOutput = decodeNumeralwords(removeAccents(_currentDecodeInput.toLowerCase()), _currentLanguage,
          (_currentDecodeMode == GCWSwitchPosition.left));
      for (int i = 0; i < detailedOutput.length; i++) {
        if (detailedOutput[i].number != '')
          output = output + ' ' + detailedOutput[i].number;
      }
    } else {
      output = i18n(context, 'numeralwords_language_not_implemented');
      detailedOutput = null;
    }
    return Column(
      children: <Widget>[
        GCWOutputText(
          text: output,
        ),
        GCWOutput(
          title: i18n(context, 'common_outputdetail'),
          child: Column(
            children: _columnedDetailedOutput(context, detailedOutput)
          ),
        ),
      ],
    );
  }
}