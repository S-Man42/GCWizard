import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bundeswehr_auth.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_expandable.dart';
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

  String _currentAuthInput = '';
  String _currentCallSign = '';
  String _currentLetterAuth = '';
  String _currentLetterCallSign = '';

  List<String> _colTitle = [];
  List<String> _rowTitle = [];

  String _authTableString = '';
  Map<String, Map<String, String>> _authTable = {};

  String _numeralCodeString = '';
  List<String> _numeralCode = [];

  var _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputAuthController = TextEditingController(text: _currentAuthInput);
    _callSignController = TextEditingController(text: _currentCallSign);
    _letterControllerAuth = TextEditingController(text: _currentLetterAuth);
    _letterControllerCallSign = TextEditingController(text: _currentLetterCallSign);

    _colTitle = _buildTitles().column;
    _rowTitle = _buildTitles().row;

    _buildAuthTable();
    _buildNumeralCode();

  }

  @override
  void dispose() {
    _inputAuthController.dispose();
    _callSignController.dispose();
    _letterControllerAuth.dispose();
    _letterControllerCallSign.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          rightValue: i18n(context, 'bundeswehr_auth_mode_auth_check'),
          leftValue: i18n(context, 'bundeswehr_auth_mode_auth'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextField(
          controller: _callSignController,
          hintText: i18n(context, 'bundeswehr_auth_call_sign'),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Z]')),],
          onChanged: (text) {
            setState(() {
              _currentCallSign = text;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
        ? Column( // decode - checkAuth
          children: <Widget>[
            GCWTextField(
              controller: _inputAuthController,
              onChanged: (text) {
                setState(() {
                  _currentAuthInput = text;
                });
              },
            ),
          ],
        )
        : Column( // encode - auth
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: GCWTextField(
                      controller: _letterControllerAuth,
                      hintText: i18n(context, 'bundeswehr_auth_letter_auth'),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[VWXYZ]')),],
                      onChanged: (text) {
                        setState(() {
                          _currentLetterAuth = text;
                        });
                      },
                    ),
                ),
                Expanded(
                    child: GCWTextField(
                      controller: _letterControllerCallSign,
                      hintText: i18n(context, 'bundeswehr_auth_letter_callsign'),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[A-Z]')),],
                      onChanged: (text) {
                        setState(() {
                          _currentLetterCallSign = text;
                        });
                      },
                    ),
                )
              ]
            ),
          ],
        ),
        GCWExpandableTextDivider(
          text: i18n(context, 'bundeswehr_auth_numeral_code'),
          child:  GCWOutputText(
                    text: _numeralCodeString,
                    isMonotype: true,
                 )
        ),
        GCWExpandableTextDivider(
          text: i18n(context, 'bundeswehr_auth_authentification_code'),
          child:  GCWOutputText(
                    text: _authTableString,
                    isMonotype: true,
                  )
          ),
        GCWDefaultOutput(
          child: GCWOutputText(
            text: _calculateOutput(),
            isMonotype: true,
          ),
        )
      ],
    );
  }

  _calculateOutput() {
    var output = '';

    if (_currentMode == GCWSwitchPosition.right) {
      output = i18n(context, checkAuthBundeswehr(_currentCallSign, _currentAuthInput));
    } else {
      output = buildAuthBundeswehr(_currentCallSign, _currentLetterAuth, _currentLetterCallSign, _rowTitle, _colTitle, _numeralCode, _authTable);
    }

    return output ?? '';
  }

  String _buildAuthTable(){
    List<int> authCode = [];
    var random = new Random();
    int rnd = 0;
    while (authCode.length != 65) {
      rnd = random.nextInt(100);
      if (authCode.contains(rnd)) {

      } else {
        authCode.add(rnd);
      }
    }

    int i = 0;
    ['A', 'D', 'E', 'G', 'H', 'I', 'L', 'N', 'O', 'R', 'S', 'T', 'U',].forEach((row) {
      Map<String, String> authTableRow = {'V': '0', 'W': '0', 'X': '0', 'Y': '0', 'Z':'0'};
      ['V', 'W', 'X', 'Y', 'Z', ].forEach((col) {
        authTableRow[col] = authCode[i].toString().padLeft(2, '0');
        i++;
      });
      _authTable[row] = authTableRow;
    });

    i = 0;
    _authTableString = '     V   W   X   Y   Z \n-----------------------\n';
    ['A', 'D', 'E', 'G', 'H', 'I', 'L', 'N', 'O', 'R', 'S', 'T', 'U',].forEach((element) {
      _authTableString = _authTableString + ' ' + element + '   ' + authCode[i].toString().padLeft(2, '0')
          + '  ' + authCode[i + 1].toString().padLeft(2, '0')
          + '  ' + authCode[i + 2].toString().padLeft(2, '0')
          + '  ' + authCode[i + 3].toString().padLeft(2, '0')
          + '  ' + authCode[i + 4].toString().padLeft(2, '0') + '\n';
      i = i + 5;
    });
  }

  String _buildNumeralCode(){
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
    _numeralCodeString = '   ' + _colTitle.join(' ') +'\n----------------------------\n ';
    _rowTitle.forEach((row) {
      _numeralCodeString = _numeralCodeString + row + ' ';
      for (int j = 0; j < 13; j++) {
        _numeralCodeString = _numeralCodeString + _numeralCode[i * 13 + j] + ' ';
      }
      i++;
      _numeralCodeString = _numeralCodeString + '\n ';
    });
  }

  TableTitle _buildTitles(){
    List<String> alphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',];
    var random = new Random();
    int rnd = 0;
    String description = '';
    while (alphabet.length > 0) {
      rnd = random.nextInt(alphabet.length);
      description = description + alphabet[rnd];
      alphabet.removeAt(rnd);
    }
    return TableTitle(description.substring(0, 13).split(''), description.substring(13).split(''));
  }

}
