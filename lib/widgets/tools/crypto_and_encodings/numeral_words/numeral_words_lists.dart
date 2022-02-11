import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/numeral_words.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/utils/AppBuilder.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:prefs/prefs.dart';

class NumeralWordsLists extends StatefulWidget {
  @override
  NumeralWordsListsState createState() => NumeralWordsListsState();
}

class NumeralWordsListsState extends State<NumeralWordsLists> {
  TextEditingController _decodeController;

  var _currentDecodeInput = '';
  var _currentLanguage = NumeralWordsLanguage.DEU;
  int _valueFontsize = Prefs.getDouble('theme_font_size').floor();

  SplayTreeMap<String, NumeralWordsLanguage> _LANGUAGES;

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
          switchMapKeyValue(NUMERALWORDS_LANGUAGES).map((key, value) => MapEntry(i18n(context, key), value)));
    }

    return Column(
      children: <Widget>[
        GCWIntegerSpinner(
          title: i18n(context, 'settings_general_theme_font_size'),
          value: _valueFontsize,
          min: 10,
          max: 30,
          onChanged: (value) {
            setState(() {
              _valueFontsize = value;
            });
          },
        ),        GCWDropDownButton(
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
          flexValues: [1, 3],
          fontsize: _valueFontsize * 1.0),
    ));
  }
}
