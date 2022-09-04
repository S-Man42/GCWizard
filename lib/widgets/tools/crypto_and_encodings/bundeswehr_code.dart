import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bundeswehr_auth.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bundeswehr_code.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class BundeswehrCode extends StatefulWidget {
  @override
  BundeswehrCodeState createState() => BundeswehrCodeState();
}

class BundeswehrCodeState extends State<BundeswehrCode> {
  var _encodeController;
  var _decodeController;
  var _numeralCodeCustomXaxis;
  var _numeralCodeCustomYaxis;

  String _currentEncode = '';
  String _currentDecode = '';
  String _currentNumeralCodeXaxisCustom = '';
  String _currentNumeralCodeYaxisCustom = '';

  AuthentificationTable _tableNumeralCode;

  String _numeralCodeString = '';

  var _currentMode = GCWSwitchPosition.right;
  var _currentTableMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncode);
    _decodeController = TextEditingController(text: _currentDecode);
    _numeralCodeCustomXaxis = TextEditingController(text: _currentNumeralCodeXaxisCustom);
    _numeralCodeCustomYaxis = TextEditingController(text: _currentNumeralCodeYaxisCustom);

    _buildNumeralCode(context,
        custom: _currentTableMode == GCWSwitchPosition.left,
        xAxis: _currentNumeralCodeXaxisCustom,
        yAxis: _currentNumeralCodeYaxisCustom);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    _numeralCodeCustomXaxis.dispose();
    _numeralCodeCustomYaxis.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
            ? GCWTextField(
                controller: _decodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentDecode = text;
                  });
                },
              )
            : GCWTextField(
                controller: _encodeController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentEncode = text;
                  });
                },
              ),
        GCWTwoOptionsSwitch(
          rightValue: i18n(context, 'bundeswehr_auth_table_mode_random'),
          leftValue: i18n(context, 'bundeswehr_auth_table_mode_custom'),
          value: _currentTableMode,
          onChanged: (value) {
            setState(() {
              _currentTableMode = value;
              _buildNumeralCode(context,
                  custom: _currentTableMode == GCWSwitchPosition.left,
                  xAxis: _currentNumeralCodeXaxisCustom,
                  yAxis: _currentNumeralCodeYaxisCustom);
            });
          },
        ),
        GCWExpandableTextDivider(
            text: i18n(context, 'bundeswehr_auth_numeral_code'),
            child: Column(
              children: <Widget>[
                _currentTableMode == GCWSwitchPosition.right
                    ? GCWOutputText(
                        text: _numeralCodeString,
                        isMonotype: true,
                      )
                    : Column(
                        children: <Widget>[
                          GCWTextField(
                            controller: _numeralCodeCustomXaxis,
                            hintText: i18n(context, 'bundeswehr_auth_authentification_code_x_axis'),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
                            ],
                            onChanged: (text) {
                              setState(() {
                                _currentNumeralCodeXaxisCustom = text;
                              });
                            },
                          ),
                          GCWTextField(
                            controller: _numeralCodeCustomYaxis,
                            hintText: i18n(context, 'bundeswehr_auth_authentification_code_y_axis'),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
                            ],
                            onChanged: (text) {
                              setState(() {
                                _currentNumeralCodeYaxisCustom = text;
                              });
                            },
                          ),
                        ],
                      )
              ],
            )),
        _calculateOutput(context),
      ],
    );
  }

  Widget _calculateOutput(BuildContext context) {
    BundeswehrTalkingBoardCodingOutput output;

    if (_currentTableMode == GCWSwitchPosition.left) {
      _buildNumeralCode(context,
          custom: _currentTableMode == GCWSwitchPosition.left,
          xAxis: _currentNumeralCodeXaxisCustom,
          yAxis: _currentNumeralCodeYaxisCustom);
    }
    if (_currentMode == GCWSwitchPosition.right)
      output = decodeBundeswehr(_currentDecode.toUpperCase(), _tableNumeralCode);
    else
      output = encodeBundeswehr(_currentEncode.toUpperCase(), _tableNumeralCode);

    return Column(
      children: <Widget>[
        GCWDefaultOutput(
          child: output.Details,
        ),
        output.ResponseCode.startsWith('bundeswehr')
            ? GCWText(
                text: i18n(context, output.ResponseCode),
              )
            : Container()
      ],
    );
  }

  void _buildNumeralCode(BuildContext context, {bool custom, String xAxis, String yAxis}) {
    List<String> _colTitle;
    List<String> _rowTitle;
    List<String> _numeralCode = [];
    Map<String, List<String>> _tableEncoding = {};
    if (custom) {
      if (_invalidSingleAxisTitle(xAxis)) {
        _tableNumeralCode = AuthentificationTable(yAxis: [], xAxis: [], Content: [], Encoding: _tableEncoding);
        _numeralCodeString = i18n(context, 'bundeswehr_auth_response_invalid_x_axis_numeral_code');
        return;
      }

      if (_invalidSingleAxisTitle(yAxis)) {
        _tableNumeralCode = AuthentificationTable(yAxis: [], xAxis: [], Content: [], Encoding: _tableEncoding);
        _numeralCodeString = i18n(context, 'bundeswehr_auth_response_invalid_y_axis_numeral_code');
        return;
      }

      if (_invalidAxisDescription(xAxis + yAxis)) {
        _tableNumeralCode = AuthentificationTable(yAxis: [], xAxis: [], Content: [], Encoding: _tableEncoding);
        _numeralCodeString = i18n(context, 'bundeswehr_auth_response_invalid_axis_numeral_code');
        return;
      }

      _colTitle = yAxis.toUpperCase().split('');
      _rowTitle = xAxis.toUpperCase().split('');
    } else {
      List<String> alphabet = [
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I',
        'J',
        'K',
        'L',
        'M',
        'N',
        'O',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'X',
        'Y',
        'Z',
      ];
      var random = new Random();
      int rnd = 0;
      String description = '';
      while (alphabet.length > 0) {
        rnd = random.nextInt(alphabet.length);
        description = description + alphabet[rnd];
        alphabet.removeAt(rnd);
      }
      _colTitle = description.substring(0, 13).split('');
      _rowTitle = description.substring(13).split('');
    }

    _numeralCode.addAll('0123456789ABC'.split(''));
    _numeralCode.addAll('D0123456789EF'.split(''));
    _numeralCode.addAll('GH0123456789I'.split(''));
    _numeralCode.addAll('JKL0123456789'.split(''));
    _numeralCode.addAll('9MNO012345678'.split(''));
    _numeralCode.addAll('89PQR01234567'.split(''));
    _numeralCode.addAll('789STU0123456'.split(''));
    _numeralCode.addAll('6789VWX012345'.split(''));
    _numeralCode.addAll('56789YZA01234'.split(''));
    _numeralCode.addAll('456789DEG0123'.split(''));
    _numeralCode.addAll('3456789HIL012'.split(''));
    _numeralCode.addAll('23456789NOR01'.split(''));
    _numeralCode.addAll('123456789STU0'.split(''));

    int i = 0;
    _numeralCodeString = '   ' + _colTitle.join(' ') + '\n----------------------------\n ';
    _rowTitle.forEach((row) {
      _numeralCodeString = _numeralCodeString + row + ' ';
      for (int j = 0; j < 13; j++) {
        _numeralCodeString = _numeralCodeString + _numeralCode[i * 13 + j] + ' ';
      }
      i++;
      _numeralCodeString = _numeralCodeString + '\n ';
    });

    _tableEncoding['0'] = [
      _colTitle[0] + _rowTitle[0],
      _rowTitle[0] + _colTitle[0],
      _colTitle[1] + _rowTitle[1],
      _rowTitle[1] + _colTitle[1],
      _colTitle[2] + _rowTitle[2],
      _rowTitle[2] + _colTitle[2],
      _colTitle[3] + _rowTitle[3],
      _rowTitle[3] + _colTitle[3],
      _colTitle[4] + _rowTitle[4],
      _rowTitle[4] + _colTitle[4],
      _colTitle[5] + _rowTitle[5],
      _rowTitle[5] + _colTitle[5],
      _colTitle[6] + _rowTitle[6],
      _rowTitle[6] + _colTitle[6],
      _colTitle[7] + _rowTitle[7],
      _rowTitle[7] + _colTitle[7],
      _colTitle[8] + _rowTitle[8],
      _rowTitle[8] + _colTitle[8],
      _colTitle[9] + _rowTitle[9],
      _rowTitle[9] + _colTitle[9],
      _colTitle[10] + _rowTitle[10],
      _rowTitle[10] + _colTitle[10],
      _colTitle[11] + _rowTitle[11],
      _rowTitle[11] + _colTitle[11],
      _colTitle[12] + _rowTitle[12],
      _rowTitle[12] + _colTitle[12],
    ];
    _tableEncoding['1'] = [
      _colTitle[1] + _rowTitle[0],
      _rowTitle[0] + _colTitle[1],
      _colTitle[2] + _rowTitle[1],
      _rowTitle[1] + _colTitle[2],
      _colTitle[3] + _rowTitle[2],
      _rowTitle[2] + _colTitle[3],
      _colTitle[4] + _rowTitle[3],
      _rowTitle[3] + _colTitle[4],
      _colTitle[5] + _rowTitle[4],
      _rowTitle[4] + _colTitle[5],
      _colTitle[6] + _rowTitle[5],
      _rowTitle[5] + _colTitle[6],
      _colTitle[7] + _rowTitle[6],
      _rowTitle[6] + _colTitle[7],
      _colTitle[8] + _rowTitle[7],
      _rowTitle[7] + _colTitle[8],
      _colTitle[9] + _rowTitle[8],
      _rowTitle[8] + _colTitle[9],
      _colTitle[10] + _rowTitle[9],
      _rowTitle[9] + _colTitle[10],
      _colTitle[11] + _rowTitle[10],
      _rowTitle[10] + _colTitle[11],
      _colTitle[12] + _rowTitle[11],
      _rowTitle[11] + _colTitle[12],
      _colTitle[0] + _rowTitle[12],
      _rowTitle[12] + _colTitle[0],
    ];
    _tableEncoding['2'] = [
      _colTitle[2] + _rowTitle[0],
      _rowTitle[0] + _colTitle[2],
      _colTitle[3] + _rowTitle[1],
      _rowTitle[1] + _colTitle[3],
      _colTitle[4] + _rowTitle[2],
      _rowTitle[2] + _colTitle[4],
      _colTitle[5] + _rowTitle[3],
      _rowTitle[3] + _colTitle[5],
      _colTitle[6] + _rowTitle[4],
      _rowTitle[4] + _colTitle[6],
      _colTitle[7] + _rowTitle[5],
      _rowTitle[5] + _colTitle[7],
      _colTitle[8] + _rowTitle[6],
      _rowTitle[6] + _colTitle[8],
      _colTitle[9] + _rowTitle[7],
      _rowTitle[7] + _colTitle[9],
      _colTitle[10] + _rowTitle[8],
      _rowTitle[8] + _colTitle[10],
      _colTitle[11] + _rowTitle[9],
      _rowTitle[9] + _colTitle[11],
      _colTitle[12] + _rowTitle[10],
      _rowTitle[10] + _colTitle[12],
      _colTitle[0] + _rowTitle[11],
      _rowTitle[11] + _colTitle[0],
      _colTitle[1] + _rowTitle[12],
      _rowTitle[12] + _colTitle[1],
    ];
    _tableEncoding['3'] = [
      _colTitle[3] + _rowTitle[0],
      _rowTitle[0] + _colTitle[3],
      _colTitle[4] + _rowTitle[1],
      _rowTitle[1] + _colTitle[4],
      _colTitle[5] + _rowTitle[2],
      _rowTitle[2] + _colTitle[5],
      _colTitle[6] + _rowTitle[3],
      _rowTitle[3] + _colTitle[6],
      _colTitle[7] + _rowTitle[4],
      _rowTitle[4] + _colTitle[7],
      _colTitle[8] + _rowTitle[5],
      _rowTitle[5] + _colTitle[8],
      _colTitle[9] + _rowTitle[6],
      _rowTitle[6] + _colTitle[9],
      _colTitle[10] + _rowTitle[7],
      _rowTitle[7] + _colTitle[10],
      _colTitle[11] + _rowTitle[8],
      _rowTitle[8] + _colTitle[11],
      _colTitle[12] + _rowTitle[9],
      _rowTitle[9] + _colTitle[12],
      _colTitle[0] + _rowTitle[10],
      _rowTitle[10] + _colTitle[0],
      _colTitle[1] + _rowTitle[11],
      _rowTitle[11] + _colTitle[1],
      _colTitle[2] + _rowTitle[12],
      _rowTitle[12] + _colTitle[2],
    ];
    _tableEncoding['4'] = [
      _colTitle[4] + _rowTitle[0],
      _rowTitle[0] + _colTitle[4],
      _colTitle[5] + _rowTitle[1],
      _rowTitle[1] + _colTitle[5],
      _colTitle[6] + _rowTitle[2],
      _rowTitle[2] + _colTitle[6],
      _colTitle[7] + _rowTitle[3],
      _rowTitle[3] + _colTitle[7],
      _colTitle[8] + _rowTitle[4],
      _rowTitle[4] + _colTitle[8],
      _colTitle[9] + _rowTitle[5],
      _rowTitle[5] + _colTitle[9],
      _colTitle[10] + _rowTitle[6],
      _rowTitle[6] + _colTitle[10],
      _colTitle[11] + _rowTitle[7],
      _rowTitle[7] + _colTitle[11],
      _colTitle[12] + _rowTitle[8],
      _rowTitle[8] + _colTitle[12],
      _colTitle[0] + _rowTitle[9],
      _rowTitle[9] + _colTitle[0],
      _colTitle[1] + _rowTitle[10],
      _rowTitle[10] + _colTitle[1],
      _colTitle[2] + _rowTitle[11],
      _rowTitle[11] + _colTitle[2],
      _colTitle[3] + _rowTitle[12],
      _rowTitle[12] + _colTitle[3],
    ];
    _tableEncoding['5'] = [
      _colTitle[5] + _rowTitle[0],
      _rowTitle[0] + _colTitle[5],
      _colTitle[6] + _rowTitle[1],
      _rowTitle[1] + _colTitle[6],
      _colTitle[7] + _rowTitle[2],
      _rowTitle[2] + _colTitle[7],
      _colTitle[8] + _rowTitle[3],
      _rowTitle[3] + _colTitle[8],
      _colTitle[9] + _rowTitle[4],
      _rowTitle[4] + _colTitle[9],
      _colTitle[10] + _rowTitle[5],
      _rowTitle[5] + _colTitle[10],
      _colTitle[11] + _rowTitle[6],
      _rowTitle[6] + _colTitle[11],
      _colTitle[12] + _rowTitle[7],
      _rowTitle[7] + _colTitle[12],
      _colTitle[0] + _rowTitle[8],
      _rowTitle[8] + _colTitle[0],
      _colTitle[1] + _rowTitle[9],
      _rowTitle[9] + _colTitle[1],
      _colTitle[2] + _rowTitle[10],
      _rowTitle[10] + _colTitle[2],
      _colTitle[3] + _rowTitle[11],
      _rowTitle[11] + _colTitle[3],
      _colTitle[4] + _rowTitle[12],
      _rowTitle[12] + _colTitle[4],
    ];
    _tableEncoding['6'] = [
      _colTitle[6] + _rowTitle[0],
      _rowTitle[0] + _colTitle[6],
      _colTitle[7] + _rowTitle[1],
      _rowTitle[1] + _colTitle[7],
      _colTitle[8] + _rowTitle[2],
      _rowTitle[2] + _colTitle[8],
      _colTitle[9] + _rowTitle[3],
      _rowTitle[3] + _colTitle[9],
      _colTitle[10] + _rowTitle[4],
      _rowTitle[4] + _colTitle[10],
      _colTitle[11] + _rowTitle[5],
      _rowTitle[5] + _colTitle[11],
      _colTitle[12] + _rowTitle[6],
      _rowTitle[6] + _colTitle[12],
      _colTitle[0] + _rowTitle[7],
      _rowTitle[7] + _colTitle[0],
      _colTitle[1] + _rowTitle[8],
      _rowTitle[8] + _colTitle[1],
      _colTitle[2] + _rowTitle[9],
      _rowTitle[9] + _colTitle[2],
      _colTitle[3] + _rowTitle[10],
      _rowTitle[10] + _colTitle[3],
      _colTitle[4] + _rowTitle[11],
      _rowTitle[11] + _colTitle[4],
      _colTitle[5] + _rowTitle[12],
      _rowTitle[12] + _colTitle[5],
    ];
    _tableEncoding['7'] = [
      _colTitle[7] + _rowTitle[0],
      _rowTitle[0] + _colTitle[7],
      _colTitle[8] + _rowTitle[1],
      _rowTitle[1] + _colTitle[8],
      _colTitle[9] + _rowTitle[2],
      _rowTitle[2] + _colTitle[9],
      _colTitle[10] + _rowTitle[3],
      _rowTitle[3] + _colTitle[10],
      _colTitle[11] + _rowTitle[4],
      _rowTitle[4] + _colTitle[11],
      _colTitle[12] + _rowTitle[5],
      _rowTitle[5] + _colTitle[12],
      _colTitle[0] + _rowTitle[6],
      _rowTitle[6] + _colTitle[0],
      _colTitle[1] + _rowTitle[7],
      _rowTitle[7] + _colTitle[1],
      _colTitle[2] + _rowTitle[8],
      _rowTitle[8] + _colTitle[2],
      _colTitle[3] + _rowTitle[9],
      _rowTitle[9] + _colTitle[3],
      _colTitle[4] + _rowTitle[10],
      _rowTitle[10] + _colTitle[4],
      _colTitle[5] + _rowTitle[11],
      _rowTitle[11] + _colTitle[5],
      _colTitle[6] + _rowTitle[12],
      _rowTitle[12] + _colTitle[6],
    ];
    _tableEncoding['8'] = [
      _colTitle[8] + _rowTitle[0],
      _rowTitle[0] + _colTitle[8],
      _colTitle[9] + _rowTitle[1],
      _rowTitle[1] + _colTitle[9],
      _colTitle[10] + _rowTitle[2],
      _rowTitle[2] + _colTitle[10],
      _colTitle[11] + _rowTitle[3],
      _rowTitle[3] + _colTitle[11],
      _colTitle[12] + _rowTitle[4],
      _rowTitle[4] + _colTitle[12],
      _colTitle[0] + _rowTitle[5],
      _rowTitle[5] + _colTitle[0],
      _colTitle[1] + _rowTitle[6],
      _rowTitle[6] + _colTitle[1],
      _colTitle[2] + _rowTitle[7],
      _rowTitle[7] + _colTitle[2],
      _colTitle[3] + _rowTitle[8],
      _rowTitle[8] + _colTitle[3],
      _colTitle[4] + _rowTitle[9],
      _rowTitle[9] + _colTitle[4],
      _colTitle[5] + _rowTitle[10],
      _rowTitle[10] + _colTitle[5],
      _colTitle[6] + _rowTitle[11],
      _rowTitle[11] + _colTitle[6],
      _colTitle[7] + _rowTitle[12],
      _rowTitle[12] + _colTitle[7],
    ];
    _tableEncoding['9'] = [
      _colTitle[9] + _rowTitle[0],
      _rowTitle[0] + _colTitle[9],
      _colTitle[10] + _rowTitle[1],
      _rowTitle[1] + _colTitle[10],
      _colTitle[11] + _rowTitle[2],
      _rowTitle[2] + _colTitle[11],
      _colTitle[12] + _rowTitle[3],
      _rowTitle[3] + _colTitle[12],
      _colTitle[0] + _rowTitle[4],
      _rowTitle[4] + _colTitle[0],
      _colTitle[1] + _rowTitle[5],
      _rowTitle[5] + _colTitle[1],
      _colTitle[2] + _rowTitle[6],
      _rowTitle[6] + _colTitle[2],
      _colTitle[3] + _rowTitle[7],
      _rowTitle[7] + _colTitle[3],
      _colTitle[4] + _rowTitle[8],
      _rowTitle[8] + _colTitle[4],
      _colTitle[5] + _rowTitle[9],
      _rowTitle[9] + _colTitle[5],
      _colTitle[6] + _rowTitle[10],
      _rowTitle[10] + _colTitle[6],
      _colTitle[7] + _rowTitle[11],
      _rowTitle[11] + _colTitle[7],
      _colTitle[8] + _rowTitle[12],
      _rowTitle[12] + _colTitle[8],
    ];
    _tableEncoding['A'] = [
      _colTitle[10] + _rowTitle[0],
      _rowTitle[0] + _colTitle[10],
      _colTitle[7] + _rowTitle[8],
      _rowTitle[8] + _colTitle[7],
    ];
    _tableEncoding['B'] = [
      _colTitle[11] + _rowTitle[0],
      _rowTitle[0] + _colTitle[11],
    ];
    _tableEncoding['C'] = [
      _colTitle[12] + _rowTitle[0],
      _rowTitle[0] + _colTitle[12],
    ];
    _tableEncoding['D'] = [
      _colTitle[0] + _rowTitle[1],
      _rowTitle[1] + _colTitle[0],
      _colTitle[6] + _rowTitle[9],
      _rowTitle[9] + _colTitle[6],
    ];
    _tableEncoding['E'] = [
      _colTitle[11] + _rowTitle[1],
      _rowTitle[1] + _colTitle[11],
      _colTitle[7] + _rowTitle[9],
      _rowTitle[9] + _colTitle[7],
    ];
    _tableEncoding['F'] = [
      _colTitle[12] + _rowTitle[1],
      _rowTitle[1] + _colTitle[12],
    ];
    _tableEncoding['G'] = [
      _colTitle[0] + _rowTitle[2],
      _rowTitle[2] + _colTitle[0],
      _colTitle[8] + _rowTitle[9],
      _rowTitle[9] + _colTitle[8],
    ];
    _tableEncoding['H'] = [
      _colTitle[1] + _rowTitle[2],
      _rowTitle[2] + _colTitle[1],
      _colTitle[7] + _rowTitle[10],
      _rowTitle[10] + _colTitle[7],
    ];
    _tableEncoding['I'] = [
      _colTitle[12] + _rowTitle[2],
      _rowTitle[2] + _colTitle[12],
      _colTitle[8] + _rowTitle[10],
      _rowTitle[10] + _colTitle[8],
    ];
    _tableEncoding['J'] = [
      _colTitle[0] + _rowTitle[3],
      _rowTitle[3] + _colTitle[0],
    ];
    _tableEncoding['K'] = [
      _colTitle[1] + _rowTitle[3],
      _rowTitle[3] + _colTitle[1],
    ];
    _tableEncoding['L'] = [
      _colTitle[2] + _rowTitle[3],
      _rowTitle[3] + _colTitle[2],
      _colTitle[9] + _rowTitle[10],
      _rowTitle[10] + _colTitle[9],
    ];
    _tableEncoding['M'] = [
      _colTitle[1] + _rowTitle[4],
      _rowTitle[4] + _colTitle[1],
    ];
    _tableEncoding['N'] = [
      _colTitle[2] + _rowTitle[4],
      _rowTitle[4] + _colTitle[2],
      _colTitle[8] + _rowTitle[11],
      _rowTitle[11] + _colTitle[8],
    ];
    _tableEncoding['O'] = [
      _colTitle[3] + _rowTitle[4],
      _rowTitle[4] + _colTitle[3],
      _colTitle[9] + _rowTitle[11],
      _rowTitle[11] + _colTitle[9],
    ];
    _tableEncoding['P'] = [
      _colTitle[2] + _rowTitle[5],
      _rowTitle[5] + _colTitle[2],
    ];
    _tableEncoding['Q'] = [
      _colTitle[3] + _rowTitle[5],
      _rowTitle[5] + _colTitle[3],
    ];
    _tableEncoding['R'] = [
      _colTitle[4] + _rowTitle[5],
      _rowTitle[5] + _colTitle[4],
      _colTitle[10] + _rowTitle[11],
      _rowTitle[11] + _colTitle[10],
    ];
    _tableEncoding['S'] = [
      _colTitle[3] + _rowTitle[6],
      _rowTitle[6] + _colTitle[3],
      _colTitle[9] + _rowTitle[12],
      _rowTitle[12] + _colTitle[9],
    ];
    _tableEncoding['T'] = [
      _colTitle[4] + _rowTitle[6],
      _rowTitle[6] + _colTitle[4],
      _colTitle[10] + _rowTitle[12],
      _rowTitle[12] + _colTitle[10],
    ];
    _tableEncoding['U'] = [
      _colTitle[5] + _rowTitle[6],
      _rowTitle[6] + _colTitle[5],
      _colTitle[11] + _rowTitle[12],
      _rowTitle[12] + _colTitle[11],
    ];
    _tableEncoding['V'] = [
      _colTitle[4] + _rowTitle[7],
      _rowTitle[7] + _colTitle[4],
    ];
    _tableEncoding['W'] = [
      _colTitle[5] + _rowTitle[7],
      _rowTitle[7] + _colTitle[5],
    ];
    _tableEncoding['X'] = [
      _colTitle[6] + _rowTitle[7],
      _rowTitle[7] + _colTitle[6],
    ];
    _tableEncoding['Y'] = [
      _colTitle[5] + _rowTitle[8],
      _rowTitle[8] + _colTitle[5],
    ];
    _tableEncoding['Z'] = [
      _colTitle[6] + _rowTitle[8],
      _rowTitle[8] + _colTitle[6],
    ];

    _tableNumeralCode =
        AuthentificationTable(xAxis: _rowTitle, yAxis: _colTitle, Content: _numeralCode, Encoding: _tableEncoding);
  }

  bool _invalidSingleAxisTitle(String text) {
    if (text.length != 13) return true;
    List<String> dublicates = [];
    text.split('').forEach((element) {
      if (dublicates.contains(element)) return true;
    });
    return false;
  }

  bool _invalidAxisDescription(String text) {
    List<String> dublicates = [];
    text.split('').forEach((element) {
      if (dublicates.contains(element)) return true;
    });
    return false;
  }
}
