import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/application/i18n/logic/app_localizations.dart';
import 'package:gc_wizard/application/theme/theme.dart';
import 'package:gc_wizard/application/theme/theme_colors.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_button.dart';
import 'package:gc_wizard/common_widgets/buttons/gcw_iconbutton.dart';
import 'package:gc_wizard/common_widgets/clipboard/gcw_clipboard.dart';
import 'package:gc_wizard/common_widgets/outputs/gcw_default_output.dart';
import 'package:gc_wizard/common_widgets/switches/gcw_twooptions_switch.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_code_textfield.dart';
import 'package:gc_wizard/common_widgets/textfields/gcw_textfield.dart';
import 'package:gc_wizard/tools/games/letter_grid/logic/letter_grid.dart';

class LetterGrid extends StatefulWidget {
  const LetterGrid({Key? key}) : super(key: key);

  @override
  LetterGridState createState() => LetterGridState();
}

class LetterGridState extends State<LetterGrid> {
  GCWSwitchPosition _currentEncryptDecryptMode = GCWSwitchPosition.right;
  GCWSwitchPosition _currentTextGraphicMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentNumberExcelMode = GCWSwitchPosition.left;

  late CodeController _encodeGraphicController;
  late TextEditingController _encodeTextController;
  late TextEditingController _decodeController;
  late TextEditingController _plainGenerateController;

  String _currentDecode = '';
  String _currentTextEncode = '';

  List<Uint8List> _decodeOutput = [];

  @override
  void initState() {
    super.initState();

    _encodeTextController = TextEditingController(text: _currentTextEncode);
    _decodeController = TextEditingController(text: _currentDecode);
    //_plainGenerateController = TextEditingController(text: _decodeOutput);
  }

  @override
  void dispose() {
    _encodeGraphicController.dispose();
    _encodeTextController.dispose();
    _decodeController.dispose();
    //_plainGenerateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // GCWTwoOptionsSwitch(
      //   value: _currentEncryptDecryptMode,
      //   onChanged: (value) {
      //     setState(() {
      //       _currentEncryptDecryptMode = value;
      //     });
      //   },
      // ),
      // GCWTwoOptionsSwitch(
      //   value: _currentNumberExcelMode,
      //   leftValue: i18n(context, 'battleship_input_numbers'),
      //   rightValue: i18n(context, 'battleship_input_excel'),
      //   onChanged: (value) {
      //     setState(() {
      //       _currentNumberExcelMode = value;
      //     });
      //   },
      // ),
      // _currentEncryptDecryptMode == GCWSwitchPosition.left // encrypt
      //      Column(children: <Widget>[
              // GCWTwoOptionsSwitch(
              //   title: i18n(context, 'battleship_input_mode'),
              //   leftValue: i18n(context, 'battleship_input_text'),
              //   rightValue: i18n(context, 'battleship_input_graphic'),
              //   value: _currentTextGraphicMode,
              //   onChanged: (value) {
              //     setState(() {
              //       _currentTextGraphicMode = value;
              //     });
              //   },
              // ),
              // _currentTextGraphicMode == GCWSwitchPosition.left // text
                  GCWTextField(
                      controller: _encodeTextController,
                      onChanged: (text) {
                        style: gcwMonotypeTextStyle();
                        setState(() {
                          _currentTextEncode = text;
                        });
                      },
                    ),
                  // : CodeField(
                  //     controller: _encodeGraphicController,
                  //     textStyle: gcwMonotypeTextStyle(),
                  //     lineNumbers: false,
                  //     lineNumberStyle: const LineNumberStyle(
                  //       width: 0.0,
                  //       margin: 0.0,
                  //       textStyle: TextStyle(fontSize: 0.0),
                  //     ),
                  //   )
            // ]),
           GCWTextField(
              controller: _decodeController,
              onChanged: (text) {
                setState(() {
                  _currentDecode = text;
                });
              },
            ),
            GCWButton(
              text: i18n(context, 'common_start'),
              onPressed: () {
                setState(() {
                  _calcOutput();
                });
              },
            ),
            _buildOutput(),
    ]);
  }

  void _calcOutput() {
    _decodeOutput = searchWordList(_currentTextEncode, _currentDecode);
    print(_decodeOutput);
    setState(() {});
  }

  Widget _buildOutput() {
      //_plainGenerateController.text = _decodeOutput;
      return GCWDefaultOutput(
        trailing: Row(
          children: <Widget>[
            GCWIconButton(
              iconColor: themeColors().mainFont(),
              size: IconButtonSize.SMALL,
              icon: Icons.content_copy,
              onPressed: () {
                var copyText = _plainGenerateController.text;
                insertIntoGCWClipboard(context, copyText);
              },
            ),
          ],
        ),
        // child: GCWCodeTextField(
        //   controller: _plainGenerateController,
        //   patternMap: _numeralWordsHiglightMap(),
        // ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: _buildRtfOutput(normalizeAndSplitInput(_currentTextEncode), _decodeOutput),
              style: gcwTextStyle()),
        ),
      );
  }

  List<TextSpan> _buildRtfOutput(List<String> text, List<Uint8List> founds) {
    var textSpan = <TextSpan>[];
    TextSpan actTextSpan;

    if (text.isEmpty || text.first.isEmpty || founds.isEmpty || founds.first.isEmpty) return textSpan;
    var lastColor = _getTextColorValue(founds.first.first);
    var actText = '';

    for (var row=0; row< text.length; row++) {
      if (row > 0) actText += '\n';
      for (var column=0; row< text[row].length; column++) {
        var actColor = _getTextColorValue(founds[row][column]);
        if (actColor != lastColor) {
          actTextSpan = TextSpan(style: gcwTextStyle());
          switch (actColor) {
            case 1: actTextSpan = TextSpan(text: actText, style: gcwTextStyle().copyWith(color: Colors.red)); break;
            case 2: actTextSpan = TextSpan(text: actText,style: gcwTextStyle().copyWith(color: Colors.green)); break;
            case 3: actTextSpan = TextSpan(text: actText,style: gcwTextStyle().copyWith(color: Colors.blue)); break;
            default: actTextSpan = TextSpan(text: actText,style: gcwTextStyle());
          }
          textSpan.add(actTextSpan);
        }
        actText += text[row][column] + ' ';
      }
    }
    return textSpan;
  }

  int _getTextColorValue(int value) {
    if (value == 0) return 0;
    if (value & 1 == 1) return 1;
    if (value & 2 == 2) return 2;
    if (value & 4 == 4) return 3;
    return 0;
  }



  Map<String, TextStyle> _numeralWordsHiglightMap() {
    Map<String, TextStyle> result = {};

    List<String> lines = const LineSplitter().convert(_currentDecode.toUpperCase());
    lines.forEach((line) {
      result.addAll({line.trim().split('').map((char) => char).join(' '): const TextStyle(color: Colors.red)});
    });

    // if (NUMERAL_WORDS_ACCENTS[_currentLanguage] != null) {
    //   for (var element in NUMERAL_WORDS_ACCENTS[_currentLanguage]!) {
    //     if ((int.tryParse(NUMERAL_WORDS[_currentLanguage]![removeAccents(element)] ?? '') ?? 0) < 10) {
    //       result[r'' + element + ''] = const TextStyle(color: Colors.red);
    //       result[r'' + removeAccents(element) + ''] = const TextStyle(color: Colors.red);
    //     } else {
    //       result[r'' + element + ''] = const TextStyle(color: Colors.orange);
    //       result[r'' + removeAccents(element) + ''] = const TextStyle(color: Colors.orange);
    //     }
    //   }
    // }
    //
    // NUMERAL_WORDS[_currentLanguage]!.forEach((key, value) {
    //   if (int.tryParse(value) == null) {
    //     if (value.startsWith('numeral')) {
    //       result[r'' + key + ''] = const TextStyle(color: Colors.blue);
    //     } else {
    //       result[r'' + key + ''] = const TextStyle(color: Colors.green);
    //     }
    //   } else if (int.parse(value) < 10) {
    //     result[r'' + key + ''] = const TextStyle(color: Colors.red);
    //   } else if (int.parse(value) < 100) {
    //     result[r'' + key + ''] = const TextStyle(color: Colors.orange);
    //   } else {
    //     result[r'' + key + ''] = const TextStyle(color: Colors.yellow);
    //   }
    // });
    return result;
  }
}
