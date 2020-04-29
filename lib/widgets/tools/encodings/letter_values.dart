import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/alphanum_values.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_crosstotal_output.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class LetterValues extends StatefulWidget {
  @override
  LetterValuesState createState() => LetterValuesState();
}

class LetterValuesState extends State<LetterValues> {
  var _encodeController;
  var _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  bool _currentCrosstotalMode = true;
  
  String _output = '';

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
          leftValue: i18n(context, 'lettervalues_mode_left'),
          rightValue: i18n(context, 'lettervalues_mode_right'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
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

  _buildCrossTotals() {
    if (!_currentCrosstotalMode)
      return Container();

    if (_currentMode == GCWSwitchPosition.left) {
      return GCWCrosstotalOutput(_currentEncodeInput, AlphabetValues().textToValues(_currentEncodeInput, keepNumbers: true));
    } else {
      var text = AlphabetValues().valuesToText(List<int>.from(_currentDecodeInput['values']));
      return GCWCrosstotalOutput(text, _currentDecodeInput['values']);
    }
  }

  _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      return intListToString(AlphabetValues().textToValues(_currentEncodeInput, keepNumbers: true), delimiter: ' | ');
    } else {
      return AlphabetValues().valuesToText(List<int>.from(_currentDecodeInput['values']));
    }
  }
}