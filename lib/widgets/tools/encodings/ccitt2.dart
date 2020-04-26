import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/encodings/ccitt2.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/utils/common_utils.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_list_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class CCITT2 extends StatefulWidget {
  @override
  CCITT2State createState() => CCITT2State();
}

class CCITT2State extends State<CCITT2> {
  var _controller;

  var _currentInput = defaultIntegerListText;
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentOutputCoding = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentInput['text']);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left ?
          GCWTextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {
                _currentInput = {'text': text, 'values' : []};
              });
            },
          ) :
          GCWIntegerListTextField(
            controller: _controller,
            onChanged: (text) {
              setState(() {
                _currentInput = text;
              });
            },
          ),
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;

              if (_currentMode == GCWSwitchPosition.right) {
                var text = _currentInput['text'];
                _currentInput = {'text': text, 'values': textToIntList(text)};
              }
            });
          },
        ),
        GCWTwoOptionsSwitch(
          title: i18n(context, 'ccitt2_numeral_base'),
          leftValue: i18n(context, 'common_numeralbase_denary'),
          rightValue: i18n(context, 'common_numeralbase_binary'),
          value: _currentOutputCoding,
          onChanged: (value) {
            setState(() {
              _currentOutputCoding = value;

            });
          },
        ),
        GCWDefaultOutput(
          text: _buildOutput()
        ),
      ],
    );
  }

  _buildOutput() {
    var output = '';

    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeCCITT2(_currentInput['text']);
      if (_currentOutputCoding == GCWSwitchPosition.right) {
        output = output.split(' ').map((value) {
          var out = convertBase(value, 10, 2);
          return out.padLeft(5, '0');
        }).join(' ');
      }
      return output;
    } else {
      if (_currentOutputCoding == GCWSwitchPosition.right) {
        return decodeCCITT2(
          textToBinaryList(_currentInput['text']).map((value) {
            return int.tryParse(convertBase(value, 2, 10));
          }).toList()
        );
      }

      return decodeCCITT2(_currentInput['values']);
    }
  }
}