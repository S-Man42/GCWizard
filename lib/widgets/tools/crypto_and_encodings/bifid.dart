import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bifid.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_encrypt_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Bifid extends StatefulWidget {
  @override
  BifidState createState() => BifidState();
}

class BifidState extends State<Bifid> {
  var _inputController;
  var _keyController;
  var _alphabetController;
  var _currentOutput = BifidOutput('', '');

  String _currentInput = '';
  String _currentKey = '12345';
  String _currentAlphabet = '';

  PolybiosMode _currentBifidMode = PolybiosMode.AZ09;
  BifidAlphabetMode _currentBifidAlphabetMode = BifidAlphabetMode.JToI;

  GCWSwitchPosition _currentMatrixMode = GCWSwitchPosition.left;         /// switches between 5x5 or 6x6 square

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _keyController = TextEditingController(text: _currentKey);
    _alphabetController = TextEditingController(text: _currentAlphabet);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _keyController.dispose();
    _alphabetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var BifidModeItems = {
      PolybiosMode.AZ09 : i18n(context, 'bifid_mode_az09'),
      PolybiosMode.ZA90 : i18n(context, 'bifid_mode_za90'),
      PolybiosMode.CUSTOM : i18n(context, 'bifid_mode_custom'),
    };
    var BifidAlphabetModeItems = {
      BifidAlphabetMode.JToI : i18n(context, 'bifid_alphabet_mod_jtoi'),
      BifidAlphabetMode.CToK : i18n(context, 'bifid_alphabet_mod_ctok'),
      BifidAlphabetMode.WToVV : i18n(context, 'bifid_alphabet_mod_wtovv'),
    };

    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'common_alphabet')
        ),

        GCWDropDownButton(
          value: _currentBifidMode,
          onChanged: (value) {
            setState(() {
              _currentBifidMode = value;
            });
          },
          items: BifidModeItems.entries.map((mode) {
            return DropdownMenuItem(
              value: mode.key,
              child: Text(mode.value),
            );
          }).toList(),
        ),

        _currentBifidMode == PolybiosMode.CUSTOM ? GCWTextField(
          hintText: i18n(context, 'common_alphabet'),
          controller: _alphabetController,
          onChanged: (text) {
            setState(() {
              _currentAlphabet = text;
            });
          },
        ) : Container(),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'bifid_matrix'),
          leftValue: i18n(context, 'bifid_mode_5x5'),
          rightValue: i18n(context, 'bifid_mode_6x6'),
          onChanged: (value) {
            setState(() {
              _currentMatrixMode = value;
            });
          },
        ),

        _currentMatrixMode == GCWSwitchPosition.left
            ?   GCWTextDivider(
                text: i18n(context, 'bifid_alphabet_mod')
                )
            : Container(), //empty widget

        _currentMatrixMode == GCWSwitchPosition.left
            ?   GCWDropDownButton(
                value: _currentBifidAlphabetMode,
                onChanged: (value) {
                  setState(() {
                    _currentBifidAlphabetMode = value;
                  });
                },
                items: BifidAlphabetModeItems.entries.map((mode) {
                  return DropdownMenuItem(
                    value: mode.key,
                    child: Text(mode.value),
                  );
                }).toList(),
              )
            : Container(), //empty widget

        GCWEncryptButtonBar(
          onPressedEncode: () {
            if (_currentInput == null || _currentInput.length == 0) {
              _currentOutput = BifidOutput("bifid_error_no_encrypt_input", null);
            } else {
              if (_currentMatrixMode == GCWSwitchPosition.left) {
                _currentKey = "12345";
              } else {
                _currentKey = "123456";
              }
              setState(() {
                _currentOutput = encryptBifid(
                    _currentInput, _currentKey, mode: _currentBifidMode,
                    alphabet: _currentAlphabet,
                    alphabetMode: _currentBifidAlphabetMode);
              });
            }
          },
          onPressedDecode: () {
            if (_currentMatrixMode == GCWSwitchPosition.left) {
              _currentKey = "12345";
            } else {
              _currentKey = "123456";
            }
            setState(() {
               _currentOutput = decryptBifid(_currentInput, _currentKey, mode: _currentBifidMode, alphabet: _currentAlphabet, alphabetMode: _currentBifidAlphabetMode);
            });
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentOutput == null || _currentOutput.output.length == 0) {
      return GCWDefaultOutput(
        text: '' //TODO: Exception
      );
    } else {
      switch (_currentOutput.output) {
        case "bifid_error_no_encrypt_input":
          return GCWDefaultOutput(
              text: i18n(context, 'bifid_error_no_encrypt_input') //TODO: Exception
          );
          break;
        case "bifid_error_wrong_griddimension":
          return GCWDefaultOutput(
              text: i18n(context, 'bifid_error_wrong_griddimension') //TODO: Exception
          );
          break;
        case "bifid_error_no_alphabet":
          return GCWDefaultOutput(
              text: i18n(context, 'bifid_error_no_alphabet') //TODO: Exception
          );
          break;
        case "bifid_error_no_output":
          return GCWDefaultOutput(
              text: i18n(context, 'bifid_error_no_output') //TODO: Exception
          );
          break;
        default: break;
      }
    }

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWOutputText(
            text: _currentOutput.output
          ),
          GCWTextDivider(
            text: i18n(context, 'bifid_usedgrid')
          ),
          GCWOutputText(
            text: _currentOutput.grid,
            isMonotype: true,
          )
        ],
      ),
    );
  }
}