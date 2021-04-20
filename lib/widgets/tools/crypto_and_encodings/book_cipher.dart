import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/book_cipher.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class BookCipher extends StatefulWidget {
  @override
  BookCipherState createState() => BookCipherState();
}

class BookCipherState extends State<BookCipher> {
  var _currentInput = '';
  var _currentMode = GCWSwitchPosition.right;
  var _currentDecodeMode = GCWSwitchPosition.left;
  var _currentText = '';
  var _currentWord = '';
  var _currentPositions = '';
  var _currentSearchFormat = searchFormat.SectionRowWord;
  var _currentDecodeOutFormat = decodeOutFormat.SectionRowWord;
  var _currentEncodeOutFormat = encodeOutFormat.RowWordLetter;
  var _textController;
  var _wordController;
  var _positionsController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _textController);
    _wordController = TextEditingController(text: _wordController);
    _positionsController = TextEditingController(text: _positionsController);
  }

  @override
  void dispose() {
    _textController.dispose();
    _wordController.dispose();
    _positionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _Book_CipherSearchFormatItems = {
      searchFormat.SectionRowWord: i18n(context, 'book_cipher_section') +
          ", " +
          i18n(context, 'book_cipher_row') +
          ", " +
          i18n(context, 'book_cipher_word'),
      searchFormat.RowWord: i18n(context, 'book_cipher_row') + ", " + i18n(context, 'book_cipher_word'),
      searchFormat.Word: i18n(context, 'book_cipher_word'),
      searchFormat.SectionRowWordLetter: i18n(context, 'book_cipher_section') +
          ", " +
          i18n(context, 'book_cipher_row') +
          ", " +
          i18n(context, 'book_cipher_word') +
          ", " +
          i18n(context, 'book_cipher_letter'),
      searchFormat.RowWordLetter: i18n(context, 'book_cipher_row') +
          ", " +
          i18n(context, 'book_cipher_word') +
          ", " +
          i18n(context, 'book_cipher_letter'),
      searchFormat.WordLetter: i18n(context, 'book_cipher_word') + ", " + i18n(context, 'book_cipher_letter'),
      searchFormat.Letter: i18n(context, 'book_cipher_letter'),
    };

    var _Book_CipherdDecodeOutFormatItems = {
      decodeOutFormat.SectionRowWord: i18n(context, 'book_cipher_section') +
          ", " +
          i18n(context, 'book_cipher_row') +
          ", " +
          i18n(context, 'book_cipher_word'),
      decodeOutFormat.RowWord: i18n(context, 'book_cipher_row') + ", " + i18n(context, 'book_cipher_word'),
      decodeOutFormat.Word: i18n(context, 'book_cipher_word'),
    };

    var _Book_CipherdEncodeOutFormatItems = {
      encodeOutFormat.SectionRowWordLetter: i18n(context, 'book_cipher_section') +
          "." +
          i18n(context, 'book_cipher_row') +
          "." +
          i18n(context, 'book_cipher_word') +
          "." +
          i18n(context, 'book_cipher_letter'),
      encodeOutFormat.RowWordLetter: i18n(context, 'book_cipher_row') +
          "." +
          i18n(context, 'book_cipher_word') +
          "." +
          i18n(context, 'book_cipher_letter'),
      encodeOutFormat.WordLetter: i18n(context, 'book_cipher_word') + "." + i18n(context, 'book_cipher_letter'),
      encodeOutFormat.Letter: i18n(context, 'book_cipher_letter'),
    };

    return Column(
      children: <Widget>[
        GCWTextField(onChanged: (text) {
          setState(() {
            _currentInput = text;
          });
        }),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left ? Container() : _buildDecodeModusControl(context),
        _currentMode == GCWSwitchPosition.left ? _buildEncodeInputControl(context) : _buildDecodeInputControl(context),
        _currentMode == GCWSwitchPosition.left
            ? _buildEncodeFormatDividerControl(context)
            : _buildDecodeFormatDividerControl(context),
        _currentMode == GCWSwitchPosition.left
            ? _buildEncodeFormatControl(context, _Book_CipherdEncodeOutFormatItems)
            : _buildDecodeFormatControl(context, _Book_CipherdDecodeOutFormatItems, _Book_CipherSearchFormatItems),
        GCWDefaultOutput(child: _buildOutput())
      ],
    );
  }

  Widget _buildDecodeModusControl(BuildContext context) {
    return GCWTwoOptionsSwitch(
      title: i18n(context, 'book_cipher_modus'),
      leftValue: i18n(context, 'book_cipher_searchposition'),
      rightValue: i18n(context, 'book_cipher_searchword'),
      value: _currentDecodeMode,
      onChanged: (value) {
        setState(() {
          _currentDecodeMode = value;
        });
      },
    );
  }

  Widget _buildDecodeInputControl(BuildContext context) {
    return _currentDecodeMode == GCWSwitchPosition.left
        ? GCWTextField(
            controller: _positionsController,
            hintText: i18n(context, 'book_cipher_searchposition'),
            onChanged: (text) {
              setState(() {
                _currentPositions = text;
              });
            })
        : GCWTextField(
            controller: _wordController,
            hintText: i18n(context, 'book_cipher_searchword'),
            onChanged: (text) {
              setState(() {
                _currentWord = text;
              });
            });
  }

  Widget _buildDecodeFormatDividerControl(BuildContext context) {
    return _currentDecodeMode == GCWSwitchPosition.left
        ? GCWTextDivider(text: i18n(context, 'book_cipher_input_format'))
        : GCWTextDivider(text: i18n(context, 'book_cipher_output_format'));
  }

  Widget _buildDecodeFormatControl(BuildContext context, Map<decodeOutFormat, String> _bookChiffredDecodeOutFormatItems,
      Map<searchFormat, String> _bookChiffreSearchFormatItems) {
    return _currentDecodeMode == GCWSwitchPosition.left
        ? GCWDropDownButton(
            value: _currentSearchFormat,
            onChanged: (value) {
              setState(() {
                _currentSearchFormat = value;
              });
            },
            items: _bookChiffreSearchFormatItems.entries.map((item) {
              return GCWDropDownMenuItem(
                value: item.key,
                child: item.value,
              );
            }).toList(),
          )
        : GCWDropDownButton(
            value: _currentDecodeOutFormat,
            onChanged: (value) {
              setState(() {
                _currentDecodeOutFormat = value;
              });
            },
            items: _bookChiffredDecodeOutFormatItems.entries.map((item) {
              return GCWDropDownMenuItem(
                value: item.key,
                child: item.value,
              );
            }).toList());
  }

  Widget _buildEncodeInputControl(BuildContext context) {
    return GCWTextField(
      controller: _textController,
      hintText: i18n(context, 'book_cipher_random_output_hint'),
      onChanged: (text) {
        setState(() {
          _currentText = text;
        });
      },
    );
  }

  Widget _buildEncodeFormatDividerControl(BuildContext context) {
    return GCWTextDivider(text: i18n(context, 'book_cipher_output_format'));
  }

  Widget _buildEncodeFormatControl(
      BuildContext context, Map<encodeOutFormat, String> _bookChiffredEncodeOutFormatItems) {
    return GCWDropDownButton(
      value: _currentEncodeOutFormat,
      onChanged: (value) {
        setState(() {
          _currentEncodeOutFormat = value;
        });
      },
      items: _bookChiffredEncodeOutFormatItems.entries.map((item) {
        return GCWDropDownMenuItem(
          value: item.key,
          child: item.value,
        );
      }).toList(),
    );
  }

  _buildOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return encodeText(_currentInput, _currentText, _currentEncodeOutFormat);
    } else {
      if (_currentDecodeMode == GCWSwitchPosition.left) {
        return decodeFindWord(_currentInput, _currentPositions, _currentSearchFormat);
      } else {
        return decodeSearchWord(_currentInput, _currentWord, _currentDecodeOutFormat,
            i18n(context, 'book_cipher_section'), i18n(context, 'book_cipher_row'), i18n(context, 'book_cipher_word'));
      }
    }
  }
}
