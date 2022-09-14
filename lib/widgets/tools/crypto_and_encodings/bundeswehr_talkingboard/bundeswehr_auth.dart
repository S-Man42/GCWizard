import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bundeswehr_talkingboard/bundeswehr_auth.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_dropdown_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class BundeswehrAuth extends StatefulWidget {
  @override
  BundeswehrAuthState createState() => BundeswehrAuthState();
}

class BundeswehrAuthState extends State<BundeswehrAuth> {
  var _inputAuthController;
  var _callSignController;
  var _letterControllerAuth;
  var _letterControllerCallSign;
  var _authTableCustom;
  var _numeralCodeCustomXaxis;
  var _numeralCodeCustomYaxis;

  String _currentAuthInput = '';
  String _currentCallSign = '';
  String _currentLetterAuth = '';
  String _currentLetterCallSign = '';
  String _currentAuthTableCustom = '';
  String _currentNumeralCodeXaxisCustom = '';
  String _currentNumeralCodeYaxisCustom = '';

  BundeswehrAuthentificationTable _tableNumeralCode;
  BundeswehrAuthentificationTable _tableAuthentificationCode;

  String _authTableString = '';
  String _numeralCodeString = '';

  var _currentMode = GCWSwitchPosition.right;
  var _currentTableMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputAuthController = TextEditingController(text: _currentAuthInput);
    _callSignController = TextEditingController(text: _currentCallSign);
    _letterControllerAuth = TextEditingController(text: _currentLetterAuth);
    _letterControllerCallSign = TextEditingController(text: _currentLetterCallSign);
    _authTableCustom = TextEditingController(text: _currentAuthTableCustom);
    _numeralCodeCustomXaxis = TextEditingController(text: _currentNumeralCodeXaxisCustom);
    _numeralCodeCustomYaxis = TextEditingController(text: _currentNumeralCodeYaxisCustom);

    _buildAuthTable(context, custom: _currentTableMode == GCWSwitchPosition.left, authTable: _currentAuthTableCustom);
    _buildNumeralCode(context,
        custom: _currentTableMode == GCWSwitchPosition.left,
        xAxis: _currentNumeralCodeXaxisCustom,
        yAxis: _currentNumeralCodeYaxisCustom);
  }

  @override
  void dispose() {
    _inputAuthController.dispose();
    _callSignController.dispose();
    _letterControllerAuth.dispose();
    _letterControllerCallSign.dispose();
    _authTableCustom.dispose();
    _numeralCodeCustomXaxis.dispose();
    _numeralCodeCustomYaxis.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          rightValue: i18n(context, 'bundeswehr_talkingboard_auth_mode_auth_check'),
          leftValue: i18n(context, 'bundeswehr_talkingboard_auth_mode_auth'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextField(
          title: i18n(context, 'bundeswehr_talkingboard_auth_call_sign'),
          controller: _callSignController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
          ],
          onChanged: (text) {
            setState(() {
              _currentCallSign = text;
            });
          },
        ),
        GCWDropDownSpinner(
          title: i18n(context, 'bundeswehr_talkingboard_auth_letter_auth'),
          index: 0,
          items: AUTH_TABLE_X_AXIS.map((item) => Text(item.toString(), style: gcwTextStyle())).toList(),
          onChanged: (value) {
            setState(() {
              _currentLetterAuth = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
            ? GCWTextField(
                title: i18n(context, 'bundeswehr_talkingboard_auth_authentification_code'),
                controller: _inputAuthController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ,.]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentAuthInput = text;
                  });
                },
              )
            : GCWTextField(
                title: i18n(context, 'bundeswehr_talkingboard_auth_letter_callsign'),
                controller: _letterControllerCallSign,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                ],
                onChanged: (text) {
                  setState(() {
                    _currentLetterCallSign = text;
                  });
                },
              ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'bundeswehr_talkingboard_auth_table_mode'),
          rightValue: i18n(context, 'bundeswehr_talkingboard_auth_table_mode_random'),
          leftValue: i18n(context, 'bundeswehr_talkingboard_auth_table_mode_custom'),
          value: _currentTableMode,
          onChanged: (value) {
            setState(() {
              _currentTableMode = value;
              _buildAuthTable(context,
                  custom: _currentTableMode == GCWSwitchPosition.left, authTable: _currentAuthTableCustom);
              _buildNumeralCode(context,
                  custom: _currentTableMode == GCWSwitchPosition.left,
                  xAxis: _currentNumeralCodeXaxisCustom,
                  yAxis: _currentNumeralCodeYaxisCustom);
            });
          },
        ),
        GCWExpandableTextDivider(
            text: i18n(context, 'bundeswehr_talkingboard_auth_numeral_code'),
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
                            hintText: i18n(context, 'bundeswehr_talkingboard_auth_authentification_code_x_axis'),
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
                            hintText: i18n(context, 'bundeswehr_talkingboard_auth_authentification_code_y_axis'),
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
                      ),
              ],
            )),
        GCWExpandableTextDivider(
            text: i18n(context, 'bundeswehr_talkingboard_auth_authentification_code'),
            child: Column(children: <Widget>[
              _currentTableMode == GCWSwitchPosition.right
                  ? GCWOutputText(
                      text: _authTableString,
                      isMonotype: true,
                    )
                  : GCWTextField(
                      controller: _authTableCustom,
                      hintText: i18n(context, 'bundeswehr_talkingboard_auth_authentification_code'),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),
                      ],
                      onChanged: (text) {
                        setState(() {
                          _currentAuthTableCustom = text;
                        });
                      },
                    ),
            ])),
        GCWTextDivider(
          text: i18n(context, 'common_output'),
        ),
        _calculateOutput(context),
      ],
    );
  }

  Widget _calculateOutput(BuildContext context) {
    BundeswehrAuthentificationOutput output;

    if (_currentTableMode == GCWSwitchPosition.left) {
      // custom tables
      _buildAuthTable(context, custom: _currentTableMode == GCWSwitchPosition.left, authTable: _currentAuthTableCustom);
      _buildNumeralCode(context,
          custom: _currentTableMode == GCWSwitchPosition.left,
          xAxis: _currentNumeralCodeXaxisCustom,
          yAxis: _currentNumeralCodeYaxisCustom);
    }

    if (_currentMode == GCWSwitchPosition.right) {
      // check auth
      output = checkAuthBundeswehr(_currentCallSign.toUpperCase(), _currentAuthInput.toUpperCase(),
          _currentLetterAuth.toUpperCase(), _tableNumeralCode, _tableAuthentificationCode);
      if (output.ResponseCode == AUTH_RESPONSE_OK) {
        return Column(
          children: <Widget>[
            GCWText(text: i18n(context, 'bundeswehr_talkingboard_auth_response_ok')),
            GCWExpandableTextDivider(
              text: i18n(context, 'bundeswehr_talkingboard_auth_details'),
              expanded: false,
              child: GCWText(text: output.Details),
            )
          ],
        );
      } else {
        return GCWText(
          text: i18n(context, output.ResponseCode),
        );
      }
    } else {
      // build auth
      output = buildAuthBundeswehr(_currentCallSign.toUpperCase(), _currentLetterAuth.toUpperCase(),
          _currentLetterCallSign.toUpperCase(), _tableNumeralCode, _tableAuthentificationCode);
      if (output.ResponseCode == AUTH_RESPONSE_OK) {
        return Row(children: <Widget>[
          Expanded(
            child: Padding(
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text(
                      _currentLetterCallSign.toUpperCase(),
                    )),
                    GCWDropDownButton(
                      onChanged: (value) {
                        setState(() {});
                      },
                      items: output.Tupel1.map((mode) {
                        return GCWDropDownMenuItem(
                          value: mode,
                          child: mode,
                        );
                      }).toList(),
                    )
                  ],
                ),
                padding: EdgeInsets.only(right: 2)),
          ),
          Expanded(
            child: Padding(
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text(
                      output.Number[0],
                    )),
                    GCWDropDownButton(
                      onChanged: (value) {
                        setState(() {});
                      },
                      items: output.Tupel2.map((mode) {
                        return GCWDropDownMenuItem(
                          value: mode,
                          child: mode,
                        );
                      }).toList(),
                    )
                  ],
                ),
                padding: EdgeInsets.only(left: 2, right: 2)),
          ),
          Expanded(
            child: Padding(
                child: Column(
                  children: <Widget>[
                    Center(
                        child: Text(
                      output.Number[1],
                    )),
                    GCWDropDownButton(
                      onChanged: (value) {
                        setState(() {});
                      },
                      items: output.Tupel3.map((mode) {
                        return GCWDropDownMenuItem(
                          value: mode,
                          child: mode,
                        );
                      }).toList(),
                    )
                  ],
                ),
                padding: EdgeInsets.only(
                  left: 2,
                )),
          ),
        ]);
      } else
        return GCWText(
          text: i18n(context, output.ResponseCode),
        );
    }
  }

  void _buildAuthTable(BuildContext context, {bool custom, String authTable}) {
    List<String> authCode = [];
    Map<String, Map<String, String>> _authTable = {};

    if (custom) {
      if (authTable.trim().split(' ').length != 65) {
        _tableAuthentificationCode = BundeswehrAuthentificationTable(yAxis: [], xAxis: [], Content: []);
        _authTableString = i18n(context, 'bundeswehr_talkingboard_auth_response_invalid_custom_table_auth');
        return;
      }
      authTable.trim().split(' ').forEach((element) {
        if (element.length > 2) {
          _tableAuthentificationCode = BundeswehrAuthentificationTable(yAxis: [], xAxis: [], Content: []);
          _authTableString = i18n(context, 'bundeswehr_talkingboard_auth_response_invalid_custom_table_auth');
          return;
        } else if (element.length == 1)
          authCode.add('0' + element);
        else
          authCode.add(element);
      });
    } else {
      var random = new Random();
      int rnd = 0;
      while (authCode.length != 65) {
        rnd = random.nextInt(100);
        if (authCode.contains(rnd)) {
        } else {
          authCode.add(rnd.toString().padLeft(2, '0'));
        }
      }
    }

    int i = 0;
    AUTH_TABLE_Y_AXIS.forEach((row) {
      Map<String, String> authTableRow = {};
      AUTH_TABLE_X_AXIS.forEach((col) {
        authTableRow[col] = authCode[i];
        i++;
      });
      _authTable[row] = authTableRow;
    });

    i = 0;
    _authTableString = '     V   W   X   Y   Z \n-----------------------\n';
    AUTH_TABLE_Y_AXIS.forEach((element) {
      _authTableString = _authTableString +
          ' ' +
          element +
          '   ' +
          authCode[i].toString().padLeft(2, '0') +
          '  ' +
          authCode[i + 1].toString().padLeft(2, '0') +
          '  ' +
          authCode[i + 2].toString().padLeft(2, '0') +
          '  ' +
          authCode[i + 3].toString().padLeft(2, '0') +
          '  ' +
          authCode[i + 4].toString().padLeft(2, '0') +
          '\n';
      i = i + 5;
    });

    _tableAuthentificationCode =
        BundeswehrAuthentificationTable(yAxis: AUTH_TABLE_Y_AXIS, xAxis: AUTH_TABLE_X_AXIS, Content: authCode);
  }

  void _buildNumeralCode(BuildContext context, {bool custom, String xAxis, String yAxis}) {
    List<String> _colTitle;
    List<String> _rowTitle;
    List<String> _numeralCode = [];

    if (custom) {
      if (_invalidSingleAxisTitle(xAxis)) {
        _tableNumeralCode = BundeswehrAuthentificationTable(yAxis: [], xAxis: [], Content: []);
        _numeralCodeString = i18n(context, 'bundeswehr_talkingboard_auth_response_invalid_x_axis_numeral_code');
        return;
      }

      if (_invalidSingleAxisTitle(yAxis)) {
        _tableNumeralCode = BundeswehrAuthentificationTable(yAxis: [], xAxis: [], Content: []);
        _numeralCodeString = i18n(context, 'bundeswehr_talkingboard_auth_response_invalid_y_axis_numeral_code');
        return;
      }

      if (_invalidAxisDescription(xAxis + yAxis)) {
        _tableNumeralCode = BundeswehrAuthentificationTable(yAxis: [], xAxis: [], Content: []);
        _numeralCodeString = i18n(context, 'bundeswehr_talkingboard_auth_response_invalid_axis_numeral_code');
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
    _tableNumeralCode = BundeswehrAuthentificationTable(xAxis: _rowTitle, yAxis: _colTitle, Content: _numeralCode);
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
