import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chef.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Chef extends StatefulWidget {

  @override
  ChefState createState() => ChefState();
}

class ChefState extends State<Chef> {
  var _textController;
  var _inputController;
  var _remarkController;
  var _timeController;
  var _temperatureController;

  var _currentText = '';
  var _currentInput = '';
  var _currentRemark = '';
  var _currentTime = '';
  var _currentTemperature = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _currentText);
    _inputController = TextEditingController(text: _currentInput);
    _remarkController = TextEditingController(text: _currentRemark);
    _timeController = TextEditingController(text: _currentTime);
    _temperatureController = TextEditingController(text: _currentTemperature);
  }

  @override
  void dispose() {
    _textController.dispose();
    _inputController.dispose();
    _remarkController.dispose();
    _timeController.dispose();
    _temperatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'chef_interpret'),
          rightValue: i18n(context, 'chef_generate'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextField(
          controller: _textController,
          hintText: _currentMode == GCWSwitchPosition.left ? i18n(context, 'chef_code') : i18n(context, 'chef_recipetitle'),
          onChanged: (text) {
            setState(() {
              _currentText = text;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
        ? Column(
            children: <Widget>[
              GCWTextField(
                controller: _remarkController,
                hintText: i18n(context, 'chef_remark'),
                onChanged: (text) {
                  setState(() {
                    _currentRemark = text;
                  });
                },
              ),
              GCWTextField(
                controller: _timeController,
                hintText: i18n(context, 'chef_time'),
                onChanged: (text) {
                  setState(() {
                    _currentTime = text;
                  });
                },
              ),
              GCWTextField(
                controller: _temperatureController,
                hintText: i18n(context, 'chef_temperature'),
                onChanged: (text) {
                  setState(() {
                    _currentTemperature = text;
                  });
                },
              ),
              GCWTextField(
                controller: _inputController,
                hintText: i18n(context, 'chef_input'),
                onChanged: (text) {
                  setState(() {
                    _currentInput = text;
                  });
                },
              )
            ],
          )
        : GCWTextField(
            controller: _inputController,
            hintText: i18n(context, 'chef_input'),
            onChanged: (text) {
              setState(() {
                _currentInput = text;
              });
            },
        ),
        GCWTextDivider(
            text: i18n(context, 'common_output')
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    String output = '';
    List<String>outputInterpret = new List<String>();

    if (_currentMode == GCWSwitchPosition.right) {
      output = generateChef(_currentText, _currentRemark, _currentTime, _currentTemperature, _currentInput);
    } else {
      if (isValid(_currentInput)) {
        outputInterpret = interpretChef(_currentText.toLowerCase(), _currentInput);
        output = '';
        outputInterpret.forEach((element) {
          if (element.startsWith('chef_')) {
            output = output + i18n(context, element) + ' ';
          } else
            output = output + element + ' ';
        });
      } else
        output = i18n(context, 'chef_invalid_intput');
    }
    return GCWOutputText(
        text: output,
        isMonotype: true,
    );
  }

}