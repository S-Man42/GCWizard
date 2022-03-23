import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/wherigo_urwigo/earwigo_tools.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class EarwigoTextDeobfuscation extends StatefulWidget {
  @override
  EarwigoTextDeobfuscationState createState() => EarwigoTextDeobfuscationState();
}

class EarwigoTextDeobfuscationState extends State<EarwigoTextDeobfuscation> {
  var _inputController;
  var _inputObfuscateController;

  var _currentInput = '';
  var _currentObfuscateInput = '';
  var _currentObfuscationTool = EARWIGO_DEOBFUSCATION.GSUB_WIG;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.right;
  GCWSwitchPosition _currentTool = GCWSwitchPosition.left;

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
          value: _currentTool,
          title: i18n(context, 'earwigo_textdeobfuscation_tool'),
          leftValue: i18n(context, 'earwigo_textdeobfuscation_tool_gsub'),
          rightValue: i18n(context, 'earwigo_textdeobfuscation_tool_wwb'),
          onChanged: (value) {
            setState(() {
              _currentTool = value;
              switch (_currentTool) {
                case GCWSwitchPosition.left: _currentObfuscationTool = EARWIGO_DEOBFUSCATION.GSUB_WIG; break;
                case GCWSwitchPosition.right: _currentObfuscationTool = EARWIGO_DEOBFUSCATION.WWB_DEOBF; break;
              }
            });
          },
        ),
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
            ? Row( // de-obfuscate
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
            : Row( // obfuscate
                children: [
                  Expanded(
                    child: GCWText(text: i18n(context, 'urwigo_textdeobfuscation_obfuscate_text')),
                    flex: 1,
                  ),
                  Expanded(
                      child: GCWTextField(
                        controller: _inputObfuscateController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z 0-9,.-~]')),
                        ],
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
    if (_currentMode == GCWSwitchPosition.right) {
      return GCWDefaultOutput(child: deobfuscateEarwigoText(_currentInput, _currentObfuscationTool));
    } else {
      return GCWDefaultOutput(child: obfuscateEarwigoText(_currentObfuscateInput, _currentObfuscationTool));
    }
  }
}
