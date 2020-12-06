import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/burrows_wheeler.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';

class BurrowsWheeler extends StatefulWidget {
  @override
  BurrowsWheelerState createState() => BurrowsWheelerState();
}

class BurrowsWheelerState extends State<BurrowsWheeler> {
  var _plainController;
  var _chiffreController;
  var _indexNumberController;
  var _indexCharacterController;

  var _currentMode = GCWSwitchPosition.left;

  String _currentInputPlain = '';
  String _currentInputChiffre = '';
  String _IndexSymbol = '#';
  bool _encodeIndex = false;
  int _IndexPosition = 1;
  int _currentInputLen = 0;

  @override
  void initState() {
    super.initState();
    _plainController = TextEditingController(text: _currentInputPlain);
    _chiffreController = TextEditingController(text: _currentInputChiffre);
    _indexCharacterController = TextEditingController(text: _IndexSymbol);
  }

  @override
  void dispose() {
    _plainController.dispose();
    _chiffreController.dispose();
    _indexCharacterController.dispose();

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
        GCWOnOffSwitch(
          notitle: false,
          title: i18n(context, 'burrowswheeler_index_encode'),
          value: _encodeIndex,
          onChanged: (value) {
            setState(() {
              _encodeIndex = value;
            });
          },
        ),

        _currentMode == GCWSwitchPosition.left
        ? Column(
          children: <Widget>[
            GCWTextField(
              controller: _plainController,
              hintText: i18n(context, 'burrowswheeler_inputplain'),
              onChanged: (text) {
                setState(() {
                  _currentInputPlain = text;
                  if (_currentInputPlain == '' || _currentInputPlain == null)
                    _currentInputLen = 0;
                  else
                  _currentInputLen = _currentInputPlain.length;
                });
              },
            ),
            _encodeIndex == false
                ? Container()
                : GCWTextField(
                controller: _indexCharacterController,
                hintText: i18n(context, 'burrowswheeler_index_symbol'),
                onChanged: (text) {
                  setState(() {
                    _IndexSymbol = text;
                  });
                }
            ),

          ]
        )
        : Column(
          children: <Widget>[
            GCWTextField(
              controller: _chiffreController,
              hintText: i18n(context, 'burrowswheeler_inputchiffre'),
              onChanged: (text) {
                setState(() {
                  _currentInputChiffre = text;
                  if (_currentInputChiffre == '' || _currentInputChiffre == null)
                    _currentInputLen = 0;
                  else
                    _currentInputLen = _currentInputChiffre.length;
                });
              },
            ),
            _encodeIndex == false
                ? GCWIntegerSpinner(
                    controller: _indexNumberController,
                    min: 1,
                    max: _currentInputLen,
                    value: _IndexPosition,
                    onChanged: (value) {
                      setState(() {
                        _IndexPosition = value;
                      });
                    },
                  )
                : GCWTextField(
                      controller: _indexCharacterController,
                      hintText: i18n(context, 'burrowswheeler_index_symbol'),
                      onChanged: (text) {
                        setState(() {
                          _IndexSymbol = text;
                        });
                      }
                  ),
          ],
        ),

        _buildOutput()
      ],
    );
  }

  _buildOutput() {

    BWTOutput _currentOutput;

    if (_currentMode == GCWSwitchPosition.left) { // encrypt
      if (_encodeIndex) {
        if (_IndexSymbol == '' || _IndexSymbol == null)
          _currentOutput = BWTOutput(i18n(context, 'burrowswheeler_error_no_index'), '');
        else if (_currentInputPlain.contains(_IndexSymbol))
          _currentOutput = BWTOutput(i18n(context, 'burrowswheeler_error_char_index'), '');
        else
          _currentOutput = encryptBurrowsWheeler(_currentInputPlain, _IndexSymbol);
      } else {
          _currentOutput = encryptBurrowsWheeler(_currentInputPlain, '0');
      }
    } else { // decrypt
      if (_encodeIndex) {
        if (_IndexSymbol == '' || _IndexSymbol == null)
          _currentOutput = BWTOutput(i18n(context, 'burrowswheeler_error_no_index'), '');
        else
          _currentOutput = decryptBurrowsWheeler(_currentInputChiffre, _IndexSymbol);
      } else {
        _currentOutput = decryptBurrowsWheeler(_currentInputChiffre, _IndexPosition.toString());
      }
    }

    return GCWMultipleOutput(
      children: [
        _currentOutput.text,
        GCWOutput(
            title: i18n(context, 'burrowswheeler_index'),
            child: GCWOutputText(
              text: _currentOutput.index,
            )
        )
      ],
    );
  }
}