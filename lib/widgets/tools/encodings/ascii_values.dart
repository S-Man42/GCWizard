import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_output.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class ASCIIValues extends StatefulWidget {
  @override
  ASCIIValuesState createState() => ASCIIValuesState();
}

class ASCIIValuesState extends State<ASCIIValues> {
  var _encodeController;
  var _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  var _currentModeLeft = 'A-Z → ASCII';
  var _currentModeRight = 'ASCII → A-Z';
  GCWSwitchPosition _currentOutputMode = GCWSwitchPosition.left;
  bool _currentCrosstotalMode = true;

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
          leftValue: _currentModeLeft,
          rightValue: _currentModeRight,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          leftValue: 'ASCII',
          rightValue: i18n(context, 'common_numeralbase_binary'),
          onChanged: (value) {
            setState(() {
              _currentOutputMode = value;
              if (_currentOutputMode == GCWSwitchPosition.left) {
                _currentModeLeft = 'A-Z → ASCII';
                _currentModeRight = 'ASCII → A-Z';
              } else {
                _currentModeLeft = 'A-Z → ' + i18n(context, 'common_numeralbase_binary');
                _currentModeRight = i18n(context, 'common_numeralbase_binary') + ' → A-Z';
              }
            });
          },
        ),
        GCWCrosstotalSwitch(
          onChanged: (value) {
            setState(() {
              _currentCrosstotalMode = value;
            });
          },
        ),
        GCWDefaultOutput(
          text: _calculateOutput()
        ),
        _buildCrossTotals()
      ],
    );
  }

  _sanitizeDecodeInput() {
    final MAX_UTF16 = 1112064;

    var list = List<int>.from(_currentDecodeInput['values']);
    return list.where((value) => value < MAX_UTF16);
  }

  _buildCrossTotals() {
    if (!_currentCrosstotalMode)
      return Container();

    if (_currentMode == GCWSwitchPosition.left) {
      return GCWCrosstotalOutput(_currentEncodeInput, _currentEncodeInput.codeUnits);
    } else {
      var text = String.fromCharCodes(_sanitizeDecodeInput());
      return GCWCrosstotalOutput(text, _currentDecodeInput['values']);
    }
  }

  _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_currentOutputMode == GCWSwitchPosition.left) {
        return intListToString(_currentEncodeInput.codeUnits, delimiter: ', ');
      } else {
        var out = [];
        _currentEncodeInput.codeUnits.forEach((ascii) {
          out.add(ascii.toRadixString(2).padLeft(8, '0'));
        });
        return out.join(' ');
      }
    } else {
      if (_currentOutputMode == GCWSwitchPosition.left) {
        return String.fromCharCodes(List<int>.from(_currentDecodeInput['values']));
      } else {
        var out = textToBinaryList(_currentDecodeInput['text']).map((value) {
          return int.tryParse(convertBase(value, 2, 10));
        }).toList();
        return String.fromCharCodes(out);
      }
    }
  }
}