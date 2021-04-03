import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/vanity.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class VanityWordsTextSearch extends StatefulWidget {
  @override
  VanityWordsTextSearchState createState() => VanityWordsTextSearchState();
}

class VanityWordsTextSearchState extends State<VanityWordsTextSearch> {
  TextEditingController _decodeController;

  var _currentDecodeInput = '';
  var _currentLanguage = NumeralWordsLanguage.DEU;

  Map<NumeralWordsLanguage, String> _languageList;

  @override
  void initState() {
    super.initState();
    _decodeController = TextEditingController(text: _currentDecodeInput);

    _languageList = {};
    _languageList.addAll(VANITYWORDS_LANGUAGES);
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
          items: _languageList.entries.map((mode) {
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
          ],
        ),
        GCWTextDivider(text: i18n(context, 'common_output')),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    List<NumeralWordsDecodeOutput> detailedOutput;
    String output = '';

    detailedOutput = decodeVanityWords(removeAccents(_currentDecodeInput.toLowerCase()), _currentLanguage);
    print(detailedOutput.toString());
      for (int i = 0; i < detailedOutput.length; i++) {
        if ((detailedOutput[i].number == '?'))
          output = output + ' .';
        else
        if (detailedOutput[i].number != '') if (detailedOutput[i].number.startsWith('numeralwords_'))
          output = output + i18n(context, detailedOutput[i].language);
        else
          output = output + ' ' + detailedOutput[i].language;
      }

    List<List<String>> columnData = new List<List<String>>();
    var flexData;
    String columnDataRowNumber;
    String columnDataRowNumWord;
    String columnDataRowLanguage;
    if (_currentLanguage == NumeralWordsLanguage.ALL) {
      for (int i = 0; i < detailedOutput.length; i++) {
        columnDataRowNumber = detailedOutput[i].number;
        if (detailedOutput[i].numWord.startsWith('numeralwords_'))
          columnDataRowNumWord = i18n(context, detailedOutput[i].numWord);
        else
          columnDataRowNumWord = detailedOutput[i].numWord;
        columnDataRowLanguage = i18n(context, detailedOutput[i].language);
        int j = i + 1;
        while (j < detailedOutput.length && detailedOutput[j].number == '') {
          columnDataRowNumber = columnDataRowNumber + '\n' + '';
          columnDataRowNumWord = columnDataRowNumWord + '\n' + detailedOutput[j].numWord;
          columnDataRowLanguage = columnDataRowLanguage + '\n' + i18n(context, detailedOutput[j].language);
          j++;
        }
        i = j - 1;
        columnData.add([columnDataRowNumber, columnDataRowNumWord, columnDataRowLanguage]);
      }
      flexData = [1, 3, 1];
    } else {
      for (int i = 0; i < detailedOutput.length; i++) {
        if (detailedOutput[i].number.startsWith('numeralwords_'))
          columnDataRowNumber = i18n(context, detailedOutput[i].number);
        else
          columnDataRowNumber = detailedOutput[i].number;
        if (detailedOutput[i].numWord.startsWith('numeralwords_'))
          columnDataRowNumWord = i18n(context, detailedOutput[i].numWord);
        else
          columnDataRowNumWord = detailedOutput[i].numWord;
        columnDataRowLanguage = detailedOutput[i].language;
        columnData.add([columnDataRowNumber, columnDataRowNumWord, columnDataRowLanguage]);
      }
      flexData = [2, 2, 1];
    }

    return Column(
      children: <Widget>[
        GCWOutputText(
          text: output,
        ),
        output.length == 0
            ? Container()
            : GCWOutput(
          title: i18n(context, 'common_outputdetail'),
          child:
          Column(children: columnedMultiLineOutput(context, columnData, flexValues: flexData, copyColumn: 1)),
        ),
      ],
    );
  }
}
