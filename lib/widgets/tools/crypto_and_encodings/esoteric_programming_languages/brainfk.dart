import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/brainfk_trivialsubstitutions.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:gc_wizard/utils/common_utils.dart';

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
  var _inputController_greater;
  var _inputController_smaller;
  var _inputController_plus;
  var _inputController_minus;
  var _inputController_dot;
  var _inputController_komma;
  var _inputController_open;
  var _inputController_close;

  var _currentSubstitition = BrainfkTrivial.PIKALANG;

  var _currentText = '';
  var _currentInput = '';
  var _currentInput_greater;
  var _currentInput_smaller;
  var _currentInput_plus;
  var _currentInput_minus;
  var _currentInput_dot;
  var _currentInput_komma;
  var _currentInput_open;
  var _currentInput_close;

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;
  GCWSwitchPosition _currentOriginal = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _currentText);
    _inputController = TextEditingController(text: _currentInput);
    _inputController_greater = TextEditingController(text: _currentInput_greater);
    _inputController_smaller = TextEditingController(text: _currentInput_smaller);
    _inputController_plus = TextEditingController(text: _currentInput_plus);
    _inputController_minus = TextEditingController(text: _currentInput_minus);
    _inputController_dot = TextEditingController(text: _currentInput_dot);
    _inputController_komma = TextEditingController(text: _currentInput_komma);
    _inputController_open = TextEditingController(text: _currentInput_open);
    _inputController_close = TextEditingController(text: _currentInput_close);
  }

  @override
  void dispose() {
    _textController.dispose();
    _inputController.dispose();
    _inputController_greater.dispose();
    _inputController_smaller.dispose();
    _inputController_plus.dispose();
    _inputController_minus.dispose();
    _inputController_dot.dispose();
    _inputController_komma.dispose();
    _inputController_open.dispose();
    _inputController_close.dispose();
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
        GCWTwoOptionsSwitch(
          leftValue: i18n(context, 'brainfk_original'),
          rightValue: i18n(context, 'brainfk_substitition'),
          value: _currentOriginal,
          onChanged: (value) {
            setState(() {
              _currentOriginal = value;
            });
          },
        ),
        _currentOriginal == GCWSwitchPosition.left
            ? Container()
            : Column(
            children: <Widget>[
              GCWDropDownButton(
                value: _currentSubstitition,
                onChanged: (value) {
                  setState(() {
                    _currentSubstitition = value;
                  });
                },
                items: BRAINFK_TRIVIAL_LIST.entries.map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode.key,
                    //child: i18n(context, mode.value),
                    child: mode.value,
                  );
                }).toList(),
              ),
              _currentSubstitition == BrainfkTrivial.CUSTOM
                  ? Column(
                  children: [
                    GCWTextField(
                      controller: _inputController_greater,
                      hintText: i18n(context, 'brainfk_input_greater'),
                      onChanged: (text) {
                        setState(() {
                          _currentInput_greater = text;
                        });
                      },
                    ),
                    GCWTextField(
                      controller: _inputController_smaller,
                      hintText: i18n(context, 'brainfk_input_smaller'),
                      onChanged: (text) {
                        setState(() {
                          _currentInput_smaller = text;
                        });
                      },
                    ),
                    GCWTextField(
                      controller: _inputController_plus,
                      hintText: i18n(context, 'brainfk_input_plus'),
                      onChanged: (text) {
                        setState(() {
                          _currentInput_plus = text;
                        });
                      },
                    ),
                    GCWTextField(
                      controller: _inputController_minus,
                      hintText: i18n(context, 'brainfk_input_minus'),
                      onChanged: (text) {
                        setState(() {
                          _currentInput_minus = text;
                        });
                      },
                    ),
                    GCWTextField(
                      controller: _inputController_dot,
                      hintText: i18n(context, 'brainfk_input_dot'),
                      onChanged: (text) {
                        setState(() {
                          _currentInput_dot = text;
                        });
                      },
                    ),
                    GCWTextField(
                      controller: _inputController_komma,
                      hintText: i18n(context, 'brainfk_input_komma'),
                      onChanged: (text) {
                        setState(() {
                          _currentInput_komma = text;
                        });
                      },
                    ),
                    GCWTextField(
                      controller: _inputController_open,
                      hintText: i18n(context, 'brainfk_input_open'),
                      onChanged: (text) {
                        setState(() {
                          _currentInput_open = text;
                        });
                      },
                    ),
                    GCWTextField(
                      controller: _inputController_close,
                      hintText: i18n(context, 'brainfk_input_close'),
                      onChanged: (text) {
                        setState(() {
                          _currentInput_close = text;
                        });
                      },
                    ),
                  ]
              )
                  : Container(),
            ]
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
      if (_currentOriginal == GCWSwitchPosition.left)
        try {
          return widget.interpret == null ? interpretBrainfk(_currentText, input: _currentInput) : widget.interpret(_currentText, input: _currentInput);
        } on FormatException catch(e) {
          return printErrorMessage(context, e.message);
        }
      else {
        if (_currentSubstitition == BrainfkTrivial.CUSTOM)
          try {
            return interpretBrainfk(substitution(_currentText, {_currentInput_smaller : '<' , _currentInput_greater : '>', _currentInput_minus : '-', _currentInput_plus : '+', _currentInput_open : '[', _currentInput_close : ']', _currentInput_komma : ',', _currentInput_dot : '.'}), input: _currentInput);
          } catch(e) {
            return printErrorMessage(context, 'brainfk_error_customundefined');
          }
        else
          return interpretBrainfk(substitution(_currentText, switchMapKeyValue(brainfkTrivialSubstitutions[BRAINFK_TRIVIAL_LIST[_currentSubstitition]])), input: _currentInput);
      }
    } else
    {
      if (_currentOriginal == GCWSwitchPosition.left)
        return widget.generate == null ? generateBrainfk(_currentText) : widget.generate(_currentText);
      else {
        if (_currentSubstitition == BrainfkTrivial.CUSTOM)
          try {
            return substitution(generateBrainfk(_currentText).split('').join(' '), {'<' : _currentInput_smaller, '>' : _currentInput_greater, '-' : _currentInput_minus, '+' : _currentInput_plus, '[' : _currentInput_open, ']' : _currentInput_close, ',' : _currentInput_komma, '.' : _currentInput_dot});
          } catch(e) {
            return printErrorMessage(context, 'brainfk_error_customundefined');
          }
        else
          switch (_currentSubstitition) {
            case BrainfkTrivial.DETAILEDFUCK:
            case BrainfkTrivial.OMAM:
            case BrainfkTrivial.REVOLUTION9:
              return substitution(generateBrainfk(_currentText).split('').join('\n'), brainfkTrivialSubstitutions[BRAINFK_TRIVIAL_LIST[_currentSubstitition]]);
              break;
            default: return substitution(generateBrainfk(_currentText).split('').join(' '), brainfkTrivialSubstitutions[BRAINFK_TRIVIAL_LIST[_currentSubstitition]]);
          }
      }
    }
  }
}
