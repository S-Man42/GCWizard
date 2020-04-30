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
  GCWSwitchPosition _currentRadix = GCWSwitchPosition.left;
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
          leftValue: i18n(context, 'asciivalues_mode_left'),
          rightValue: i18n(context, 'asciivalues_mode_right'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'asciivalues_numeralbase'),
          leftValue: i18n(context, 'common_numeralbase_denary'),
          rightValue: i18n(context, 'common_numeralbase_binary'),
          onChanged: (value) {
            setState(() {
              _currentRadix = value;
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

  List<int> _sanitizeDecodeInput({bool isBinary: false}) {
    final int MAX_UTF16 = 1112064;

    List<int> list = List<int>.from(_currentDecodeInput['values']);
    if (isBinary) {
      list = textToBinaryList(_currentDecodeInput['text']).map((value) {
        return int.tryParse(convertBase(value, 2, 10));
      }).toList();
    }

    return list.where((value) => value != null && value < MAX_UTF16).toList();
  }

  _buildCrossTotals() {
    if (!_currentCrosstotalMode)
      return Container();

    if (_currentMode == GCWSwitchPosition.left) {
      return GCWCrosstotalOutput(_currentEncodeInput, _currentEncodeInput.codeUnits);
    } else {
      var isBinary = _currentRadix == GCWSwitchPosition.right;
      var sanitizedValues = _sanitizeDecodeInput(isBinary: isBinary);

      var text = String.fromCharCodes(sanitizedValues);
      return GCWCrosstotalOutput(text, sanitizedValues);
    }
  }

  _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      if (_currentRadix == GCWSwitchPosition.left) {
        return intListToString(_currentEncodeInput.codeUnits, delimiter: ', ');
      } else {
        var out = [];
        _currentEncodeInput.codeUnits.forEach((ascii) {
          out.add(ascii.toRadixString(2).padLeft(8, '0'));
        });
        return out.join(', ');
      }
    } else {
      if (_currentRadix == GCWSwitchPosition.left) {
        return String.fromCharCodes(_sanitizeDecodeInput());
      } else {
        var out = textToBinaryList(_currentDecodeInput['text']).map((value) {
          return int.tryParse(convertBase(value, 2, 10));
        }).toList();
        return String.fromCharCodes(out);
      }
    }
  }
}