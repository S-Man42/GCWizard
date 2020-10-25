import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';

class NumeralWordsLists extends StatefulWidget {
  @override
  NumeralWordsListsState createState() => NumeralWordsListsState();
}

class NumeralWordsListsState extends State<NumeralWordsLists> {
  TextEditingController _decodeController;

  var _currentDecodeInput = '';
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
          items: NUMERALWORDS_LANGUAGES.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: i18n(context, mode.value),
            );
          }).toList(),
        ),
        _buildOutput(context)
      ],
    );
  }


  List<Widget> _columnedDetailedOutput(var data){
    var odd = true;
    List<Widget> outputList = new List<Widget>();
    Widget outputRow;

    for (int i = 0; i < data.length; i++) {
      var row = Container(
        child: Row(
            children: <Widget>[
              Expanded(
                  child: GCWText(
                      text: data[i][0]
                  ),
                  flex: 2
              ),
              Expanded(
                  child: GCWText(
                      text: removeAccents(data[i][0])
                  ),
                  flex: 2
              ),
              Expanded(
                  child: GCWText(
                      text: data[i][1]
                  ),
                  flex: 1
              )
            ]
        ),
        margin: EdgeInsets.only(
            top : 6,
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
  }


  Widget _buildOutput(BuildContext context) {

    if (_currentLanguage == NumeralWordsLanguage.ALL)
      return GCWDefaultOutput(
        child: GCWOutputText(
          text: i18n(context, 'numeralwords_language_all_not_feasible')
        )
      );
    else {
      Map<String, String> numeralWordsOverview = new Map<String, String>();
      numeralWordsOverview = NumWords[_currentLanguage];
      return GCWDefaultOutput(
        child: Column(
          //children: columnedMultiLineOutput(numeralWordsOverview.entries.map((entry) {return [entry.key, entry.value];}).toList()
          children: _columnedDetailedOutput(numeralWordsOverview.entries.map((entry) {return [entry.key, entry.value];}).toList()
          ),
        ),
      );
    }
  }
}