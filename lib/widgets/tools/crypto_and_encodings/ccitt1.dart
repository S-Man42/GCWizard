import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/ccitt1.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class CCITT1 extends StatefulWidget {
  @override
  CCITT1State createState() => CCITT1State();
}

class CCITT1State extends State<CCITT1> {
  var _encodeController;
  var _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentRadix = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();

    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput['text']);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
          ? GCWTextField(
            controller: _encodeController,
            onChanged: (text) {
              setState(() {
                _currentEncodeInput = text;
              });
            },
          )
          : GCWIntegerListTextField(
            controller: _decodeController,
            onChanged: (text) {
              setState(() {
                _currentDecodeInput = text;
              });
            },
          ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'ccitt1_numeralbase'),
          leftValue: i18n(context, 'common_numeralbase_denary'),
          rightValue: i18n(context, 'common_numeralbase_binary'),
          value: _currentRadix,
          onChanged: (value) {
            setState(() {
              _currentRadix = value;

            });
          },
        ),
        GCWDefaultOutput(
          child: _calculateOutput()
        ),
      ],
    );
  }

  _calculateOutput() {
    var output = '';

    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeCCITT1(_currentEncodeInput);
      if (_currentRadix == GCWSwitchPosition.right) {
        output = output.split(' ').map((value) {
          var out = convertBase(value, 10, 2);
          return out.padLeft(5, '0');
        }).join(' ');
      }
      return output;
    } else {
      if (_currentRadix == GCWSwitchPosition.right) {
        return decodeCCITT1(
          textToBinaryList(_currentDecodeInput['text']).map((value) {
            return int.tryParse(convertBase(value, 2, 10));
          }).toList()
        );
      }

      return decodeCCITT1(List<int>.from(_currentDecodeInput['values']));
    }
  }
}