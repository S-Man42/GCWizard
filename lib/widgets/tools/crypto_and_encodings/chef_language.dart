import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chef.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';

class Chef extends StatefulWidget {

  @override
  ChefState createState() => ChefState();
}

class ChefState extends State<Chef> {
  var _recipeController;
  var _inputController;
  var _titleController;
  var _remarkController;
  var _timeController;
  var _temperatureController;
  var _outputController;

  var _currentRecipe = '';
  var _currentInput = '';
  var _currentTitle = '';
  var _currentRemark = '';
  var _currentTime = '';
  var _currentTemperature = '';
  var _currentOutput = '';

  var TimeInputFormatter = WrapperForMaskTextInputFormatter(
      mask: '#' * 10000, // allow 10000 characters input
      filter: {"#": RegExp(r'[0-9]')}
  );
  var TemperatureInputFormatter = WrapperForMaskTextInputFormatter(
      mask: '#' * 10000, // allow 10000 characters input
      filter: {"#": RegExp(r'[0-9]')}
  );
  var DigitSpacesInputFormatter  = WrapperForMaskTextInputFormatter(
      mask: '#' * 10000, // allow 10000 characters input
      filter: {"#": RegExp(r'[0-9] ')}
  );

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentLanguage = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _recipeController = TextEditingController(text: _currentRecipe);
    _inputController = TextEditingController(text: _currentInput);
    _titleController = TextEditingController(text: _currentTitle);
    _remarkController = TextEditingController(text: _currentRemark);
    _timeController = TextEditingController(text: _currentTime);
    _temperatureController = TextEditingController(text: _currentTemperature);
    _outputController = TextEditingController(text: _currentOutput);
  }

  @override
  void dispose() {
    _recipeController.dispose();
    _inputController.dispose();
    _titleController.dispose();
    _remarkController.dispose();
    _timeController.dispose();
    _temperatureController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'common_language_german'),
          rightValue: i18n(context, 'common_language_english'),
          value: _currentLanguage,
          onChanged: (value) {
            setState(() {
              _currentLanguage = value;
            });
          },
        ),
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
        _currentMode == GCWSwitchPosition.right
        ? Column(
            children: <Widget>[
              GCWTextField(
                controller: _titleController,
                hintText: i18n(context, 'chef_recipetitle'),
                onChanged: (text) {
                  setState(() {
                    _currentTitle = text;
                  });
                },
              ),
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
                inputFormatters: [TimeInputFormatter],
                hintText: i18n(context, 'chef_time'),
                onChanged: (text) {
                  setState(() {
                    _currentTime = text;
                  });
                },
              ),
              GCWTextField(
                controller: _temperatureController,
                inputFormatters: [TemperatureInputFormatter],
                hintText: i18n(context, 'chef_temperature'),
                onChanged: (text) {
                  setState(() {
                    _currentTemperature = text;
                  });
                },
              ),
              GCWTextField(
                controller: _outputController,
                hintText: i18n(context, 'chef_output'),
                onChanged: (text) {
                  setState(() {
                    _currentOutput = text;
                  });
                },
              )
            ],
          )
        : Column(
            children: <Widget>[
              GCWTextField(
                controller: _recipeController,
                hintText: i18n(context, 'chef_code'),
                onChanged: (text) {
                  setState(() {
                    _currentRecipe = text;
                  });
                },
              ),
              GCWTextField(
                controller: _inputController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9 ]')),],
                hintText: i18n(context, 'chef_input'),
                onChanged: (text) {
                  setState(() {
                    _currentInput = text;
                  });
                },
              ),
              ],
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

    String language = 'ENG';
    if (_currentLanguage == GCWSwitchPosition.left)
      language = 'DEU';
    if (_currentMode == GCWSwitchPosition.right) {
      output = generateChef(language, _currentTitle, _currentRemark, _currentTime, _currentTemperature, _currentInput);
    } else {
      if (isValid(_currentInput)) {
        outputInterpret = interpretChef(_currentRecipe.toLowerCase(), _currentInput);
        output = '';
        outputInterpret.forEach((element) {
          if (element.startsWith('chef_')) {
            output = output + i18n(context, element) + ' ';
          } else
            output = output + element + ' ';
        });
      } else
        output = i18n(context, 'chef_invalid_input');
    }
    return GCWOutputText(
        text: output.trim(),
        isMonotype: true,
    );
  }

}