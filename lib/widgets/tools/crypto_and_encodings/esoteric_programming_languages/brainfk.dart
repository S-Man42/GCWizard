import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Brainfk extends StatefulWidget {
  final Function interpret;
  final Function generate;

  const Brainfk({Key key, this.interpret, this.generate}) : super(key: key);

  @override
  BrainfkState createState() => BrainfkState();
}

class BrainfkState extends State<Brainfk> {
  var _textController;
  var _inputController;

  var _currentText = '';
  var _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _currentText);
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _textController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'brainfk_interpret'),
          rightValue: i18n(context, 'brainfk_generate'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextField(
          controller: _textController,
          hintText:
              _currentMode == GCWSwitchPosition.left ? i18n(context, 'brainfk_code') : i18n(context, 'brainfk_text'),
          onChanged: (text) {
            setState(() {
              _currentText = text;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
                controller: _inputController,
                hintText: i18n(context, 'brainfk_input'),
                onChanged: (text) {
                  setState(() {
                    _currentInput = text;
                  });
                },
              )
            : Container(),
        GCWDefaultOutput(child: _calculateOutput())
      ],
    );
  }

  _calculateOutput() {
    if (_currentMode == GCWSwitchPosition.left) {
      try {
        return widget.interpret == null
            ? interpretBrainfk(_currentText, input: _currentInput)
            : widget.interpret(_currentText, input: _currentInput);
      } on FormatException catch (e) {
        return printErrorMessage(context, e.message);
      }
    } else {
      return widget.generate == null ? generateBrainfk(_currentText) : widget.generate(_currentText);
    }
  }
}
