import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/befunge.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class Befunge extends StatefulWidget {
  @override
  BefungeState createState() => BefungeState();
}

class BefungeState extends State< Befunge > {
  var _textEncodeController;
  var _textDecodeController;
  var _inputController;
  var _scrollController = ScrollController();

  var _currentEncodeText = '';
  var _currentDecodeText = '';
  var _currentInput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _textEncodeController = TextEditingController(text: _currentEncodeText);
    _textDecodeController = TextEditingController(text: _currentDecodeText);
    _inputController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _textEncodeController.dispose();
    _textDecodeController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'common_programming_mode_interpret'),
          rightValue: i18n(context, 'common_programming_mode_generate'),
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
        // https://stackoverflow.com/questions/67475181/flutter-scrollbar-on-textfield
            ? TextField(
              controller: _textDecodeController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              autocorrect: true,
              //hintText: i18n(context, 'common_programming_hint_sourcecode'),
              onChanged: (text) {
                setState(() {
                  _currentDecodeText = text;
                });
              },
              )
            : GCWTextField(
          controller: _textEncodeController,
          //inputFormatters: [TextInputFormatter.allow('A-Z0-9')],
          hintText: i18n(context, 'common_programming_hint_output'),
          onChanged: (text) {
            setState(() {
              _currentEncodeText = text;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
          controller: _inputController,
          hintText: i18n(context, 'common_programming_hint_input'),
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
        BefungeOutput output = interpretBefunge(_currentDecodeText, input: _currentInput);
        if (output.error == '')
          return output.output;
        else
          return output.output + '\n' + i18n(context, output.error);
      } on FormatException catch (e) {
        return printErrorMessage(context, e.message);
      }
    } else {
      return generateBefunge (_currentEncodeText);
    }
  }
}
