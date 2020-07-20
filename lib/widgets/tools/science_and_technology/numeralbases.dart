import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/numeral_bases.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_numeralbase_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class NumeralBases extends StatefulWidget {
  @override
  NumeralBasesState createState() => NumeralBasesState();
}

class NumeralBasesState extends State<NumeralBases> {
  var _controller;

  String _currentInput = '';
  int _currentFromKey = 16;
  int _currentToKey = 10;

  var _currentToMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: _currentInput
    );
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
        GCWTextField(
          controller: _controller,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWTextDivider(
          text: i18n(context, 'numeralbases_from')
        ),
        GCWNumeralBaseSpinner(
          value: _currentFromKey,
          onChanged: (value) {
            setState(() {
              _currentFromKey = value;
            });
          },
        ),GCWTextDivider(
          text: i18n(context, 'numeralbases_to')
        ),
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'numeralbases_showfrequent'),
          rightValue: i18n(context, 'numeralbases_chooseoutput'),
          value: _currentToMode,
          onChanged: (value) {
            setState(() {
              _currentToMode = value;
            });
          },
        ),
        _currentToMode == GCWSwitchPosition.right
          ? GCWNumeralBaseSpinner(
              value: _currentToKey,
              onChanged: (value) {
                setState(() {
                  _currentToKey = value;
                });
              },
            )
          : Container(),
        _buildOutput(context)
      ],
    );
  }

  _buildOutput(BuildContext context) {
    if (_currentInput.startsWith('-') && _currentFromKey < 0) {
      return GCWDefaultOutput(
        text: i18n(context, 'common_notdefined')
      );
    }

    //TODO: React on exceptions
    var testValidInput = convertBase(_currentInput, _currentFromKey, 2);
    if (testValidInput == null || testValidInput.length == 0) {
      return GCWDefaultOutput(
          text: i18n(context, 'common_notdefined')
      );
    }

    if (_currentToMode == GCWSwitchPosition.right) {
      return GCWDefaultOutput(
        text: convertBase(_currentInput, _currentFromKey, _currentToKey)
      );
    }

    var outputData = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,60].map((base) {
      return [base.toString(), convertBase(_currentInput, _currentFromKey, base)];
    }).toList();

    var rows = columnedMultiLineOutput(outputData, flexValues: [1,3]);

    rows.insert(0,
      GCWTextDivider(
        text: i18n(context, 'common_output')
      )
    );

    return Column(
      children: rows
    );
  }

//  _calculateOutput(BuildContext context) {
//
//
//    return _output;
//  }
}