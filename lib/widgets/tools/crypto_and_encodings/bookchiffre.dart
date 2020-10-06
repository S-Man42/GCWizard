import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'file:///D:/tmp/GitHub/GC%20WIzard%201.2.0%20-%20Kopie%20(2)/GCWizard/lib/logic/tools/crypto_and_encodings/bookchiffre.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class BookChiffre extends StatefulWidget {
  @override
  BookChiffreState createState() => BookChiffreState();
}

class BookChiffreState extends State<BookChiffre> {
  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.left;
  var _currentWord = '';
  var _currentPositions = '';
  var _currentSearchFormat = searchFormat.SectionRowWord;
  var _currentOutFormat =  outFormat.SectionRowWord;
  var _wordController;
  var _positionsController;

  @override
  void initState() {
    super.initState();
    _wordController = TextEditingController(text: _wordController);
    _positionsController = TextEditingController(text: _positionsController);
  }

  @override
  void dispose() {
    _wordController.dispose();
    _positionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var _BookChiffreSearchFormatItems = {
      searchFormat.SectionRowWord :  i18n(context, 'bookchiffre_section') + ", " + i18n(context, 'bookchiffre_row') + ", " + i18n(context, 'bookchiffre_word'),
      searchFormat.RowWord : i18n(context, 'bookchiffre_row') + ", " + i18n(context, 'bookchiffre_word'),
      searchFormat.Word : i18n(context, 'bookchiffre_word'),
      searchFormat.SectionRowWordLetter : i18n(context, 'bookchiffre_section') + ", " + i18n(context, 'bookchiffre_row') + ", " + i18n(context, 'bookchiffre_word') + ", " + i18n(context, 'bookchiffre_letter'),
      searchFormat.RowWordLetter : i18n(context, 'bookchiffre_row') + ", " + i18n(context, 'bookchiffre_word') + ", " + i18n(context, 'bookchiffre_letter'),
      searchFormat.WordLetter : i18n(context, 'bookchiffre_word') + ", " + i18n(context, 'bookchiffre_letter'),
      searchFormat.Letter : i18n(context, 'bookchiffre_letter'),
    };

    var _BookChiffreOutFormatItems = {
      outFormat.SectionRowWord : i18n(context, 'bookchiffre_section') + ", " + i18n(context, 'bookchiffre_row') + ", " + i18n(context, 'bookchiffre_word'),
      outFormat.RowWord : i18n(context, 'bookchiffre_row') + ", " + i18n(context, 'bookchiffre_word'),
      outFormat.Word : i18n(context, 'bookchiffre_word'),
    };

    return Column(
      children: <Widget>[
        GCWTextField(
        onChanged: (text) {
          setState(() {
            _currentInput = text;
          });
        }
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'bookchiffre_modus'),
          leftValue: i18n(context, 'bookchiffre_searchword'),
          rightValue: i18n(context, 'bookchiffre_searchposition'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
          ? GCWTextField(
              controller: _wordController,
              hintText : i18n(context, 'bookchiffre_searchword'),
              onChanged: (text) {
              setState(() {
                _currentWord = text;
              });
              },
          )
          : GCWTextField(
          controller: _positionsController,
          hintText : i18n(context, 'bookchiffre_searchposition'),
          onChanged: (text) {
            setState(() {
              _currentPositions = text;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
          ? GCWTextDivider(
            text: i18n(context, 'bookchiffre_output_format')
            )
          : GCWTextDivider(
            text: i18n(context, 'bookchiffre_input_format')
            ),
        _currentMode == GCWSwitchPosition.left
          ? GCWDropDownButton(
            value: _currentOutFormat,
            onChanged: (value) {
              setState(() {
                _currentOutFormat = value;
              });
            },
            items: _BookChiffreOutFormatItems.entries.map((item) {
              return GCWDropDownMenuItem(
                value: item.key,
                child: item.value,
              );
            }).toList(),
            )
          : GCWDropDownButton(
            value: _currentSearchFormat,
            onChanged: (value) {
              setState(() {
                _currentSearchFormat = value;
              });
            },
            items: _BookChiffreSearchFormatItems.entries.map((item) {
              return GCWDropDownMenuItem(
                value: item.key,
                child: item.value,
              );
            }).toList(),
          ),
        GCWDefaultOutput(
          child: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {

    if (_currentMode == GCWSwitchPosition.left) {
      return searchWord(_currentInput, _currentWord, _currentOutFormat, i18n(context, 'bookchiffre_section'), i18n(context, 'bookchiffre_row'), i18n(context, 'bookchiffre_word'));
    } else {
      return findWord(_currentInput, _currentPositions, _currentSearchFormat);
    }
  }
}
