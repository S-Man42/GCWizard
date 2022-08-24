import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/trifid.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_spinner.dart';
import 'package:gc_wizard/widgets/common/gcw_multiple_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Trifid extends StatefulWidget {
  @override
  TrifidState createState() => TrifidState();
}

class TrifidState extends State<Trifid> {
  var _inputController;
  var _alphabetController;

  var _currentMode = GCWSwitchPosition.right;

  String _currentInput = '';
  String _currentAlphabet = '';
  int _currentBlockSize = 4;

  PolybiosMode _currentTrifidMode = PolybiosMode.AZ09;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _alphabetController = TextEditingController(text: _currentAlphabet);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _alphabetController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var TrifidModeItems = {
      PolybiosMode.AZ09: i18n(context, 'trifid_mode_az09'),
      PolybiosMode.ZA90: i18n(context, 'trifid_mode_za90'),
      PolybiosMode.CUSTOM: i18n(context, 'trifid_mode_custom'),
    };

    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        GCWTextField(
          controller: _inputController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[A-Za-z+]')),
          ],
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),
        GCWIntegerSpinner(
          title: i18n(context, 'trifid_block_size'),
          value: _currentBlockSize,
          min: 2,
          onChanged: (value) {
            setState(() {
              _currentBlockSize = value;
            });
          },
        ),
        GCWTextDivider(text: i18n(context, 'common_alphabet')),
        GCWDropDownButton(
          value: _currentTrifidMode,
          onChanged: (value) {
            setState(() {
              _currentTrifidMode = value;
            });
          },
          items: TrifidModeItems.entries.map((mode) {
            return GCWDropDownMenuItem(
              value: mode.key,
              child: mode.value,
            );
          }).toList(),
        ),
        _currentTrifidMode == PolybiosMode.CUSTOM
            ? GCWTextField(
                hintText: i18n(context, 'common_alphabet'),
                controller: _alphabetController,
                onChanged: (text) {
                  setState(() {
                    _currentAlphabet = text;
                  });
                },
              )
            : Container(),
        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    String output = '';
    if (_currentInput == null || _currentInput.length == 0) return GCWDefaultOutput(child: '');

    var _currentOutput = TrifidOutput('', '');
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput =
          encryptTrifid(_currentInput, _currentBlockSize, mode: _currentTrifidMode, alphabet: _currentAlphabet);
    } else {
      _currentOutput =
          decryptTrifid(_currentInput, _currentBlockSize, mode: _currentTrifidMode, alphabet: _currentAlphabet);
    }

    if (_currentOutput.output.startsWith('trifid'))
      output = i18n(context, _currentOutput.output);
    else
      output = _currentOutput.output;
    return GCWMultipleOutput(
      children: [
        output,
        GCWOutput(
            title: i18n(context, 'trifid_usedgrid'),
            child: GCWOutputText(
              text: _currentOutput.grid,
              isMonotype: true,
            ))
      ],
    );
  }
}
