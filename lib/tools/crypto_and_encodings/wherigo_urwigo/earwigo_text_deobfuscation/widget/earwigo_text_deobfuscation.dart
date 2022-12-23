import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/wherigo_urwigo/logic/earwigo_tools.dart';
import 'package:gc_wizard/tools/common/base/gcw_text/widget/gcw_text.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_output/widget/gcw_output.dart';
import 'package:gc_wizard/tools/common/gcw_twooptions_switch/widget/gcw_twooptions_switch.dart';

class EarwigoTextDeobfuscation extends StatefulWidget {
  @override
  EarwigoTextDeobfuscationState createState() => EarwigoTextDeobfuscationState();
}

class EarwigoTextDeobfuscationState extends State<EarwigoTextDeobfuscation> {
  var _inputController;
  var _inputObfuscateController;

  var _currentInput = '';
  var _currentObfuscateInput = '';

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _inputObfuscateController = TextEditingController(text: _currentObfuscateInput);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _inputObfuscateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          leftValue: i18n(context, 'urwigo_textdeobfuscation_mode_obfuscate'),
          rightValue: i18n(context, 'urwigo_textdeobfuscation_mode_de_obfuscate'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.right
            ? Row(
                // de-obfuscate
                children: [
                  Expanded(
                    child: GCWText(text: i18n(context, 'earwigo_textdeobfuscation_text')),
                    flex: 1,
                  ),
                  Expanded(
                      child: GCWTextField(
                        controller: _inputController,
                        onChanged: (text) {
                          setState(() {
                            _currentInput = text;
                          });
                        },
                      ),
                      flex: 3)
                ],
              )
            : Row(
                // obfuscate
                children: [
                  Expanded(
                    child: GCWText(text: i18n(context, 'urwigo_textdeobfuscation_obfuscate_text')),
                    flex: 1,
                  ),
                  Expanded(
                      child: GCWTextField(
                        controller: _inputObfuscateController,
                        onChanged: (text) {
                          setState(() {
                            _currentObfuscateInput = text;
                          });
                        },
                      ),
                      flex: 3)
                ],
              ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentMode == GCWSwitchPosition.right)
      return Column(children: <Widget>[
        GCWOutput(
            title: i18n(context, 'earwigo_textdeobfuscation_tool_gsub'),
            child: deobfuscateEarwigoText(_currentInput, EARWIGO_DEOBFUSCATION.GSUB_WIG)),
        GCWOutput(
            title: i18n(context, 'earwigo_textdeobfuscation_tool_wwb'),
            child: deobfuscateEarwigoText(_currentInput, EARWIGO_DEOBFUSCATION.WWB_DEOBF)),
      ]);
    else
      return Column(children: <Widget>[
        GCWOutput(
            title: i18n(context, 'earwigo_textdeobfuscation_tool_gsub'),
            child: obfuscateEarwigoText(_currentObfuscateInput, EARWIGO_DEOBFUSCATION.GSUB_WIG)),
        GCWOutput(
            title: i18n(context, 'earwigo_textdeobfuscation_tool_wwb'),
            child: obfuscateEarwigoText(_currentObfuscateInput, EARWIGO_DEOBFUSCATION.WWB_DEOBF)),
      ]);
  }
}
