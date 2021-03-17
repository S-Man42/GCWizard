import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

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

  Widget _buildOutput(BuildContext context) {
    Map<String, String> numeralWordsOverview = new Map<String, String>();
    numeralWordsOverview = NumWords[_currentLanguage];

    return GCWDefaultOutput(
        child: Column(
      children: columnedMultiLineOutput(
          context,
          numeralWordsOverview.entries.map((entry) {
            if (int.tryParse(entry.value) != null) return [entry.value, entry.key];
          }).toList(),
          flexValues: [1, 3]),
    ));
  }
}
