import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/substitution.dart';
import 'package:gc_wizard/theme/theme_colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_onoff_switch.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';

class Substitution extends StatefulWidget {
  final String input;
  final Map<String, String> substitutions;

  const Substitution({Key key, this.input, this.substitutions}) : super(key: key);

  @override
  SubstitutionState createState() => SubstitutionState();
}

class SubstitutionState extends State<Substitution> {
  var _fromController;
  var _toController;
  var _inputController;

  var _currentInput = '';
  var _currentFromInput = '';
  var _currentToInput = '';
  var _currentCaseSensitive = false;

  var _currentEditedKey = '';
  var _currentEditedValue = '';
  var _currentEditId;
  var _editKeyController;
  var _editValueController;

  var _currentIdCount = 0;
  var _currentSubstitutions = <int, Map<String, String>>{};

  String _output = '';

  @override
  void initState() {
    super.initState();

    if (widget.substitutions != null) {
      widget.substitutions.entries.forEach((element) {
        _currentSubstitutions.putIfAbsent(++_currentIdCount, () => {element.key: element.value});
      });
    }

    if (widget.input != null) {
      _currentInput = widget.input;
      _calculateOutput();
    }

    _inputController = TextEditingController(text: _currentInput);
    _fromController = TextEditingController(text: _currentFromInput);
    _toController = TextEditingController(text: _currentToInput);

    _editKeyController = TextEditingController(text: _currentEditedKey);
    _editValueController = TextEditingController(text: _currentEditedValue);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _fromController.dispose();
    _toController.dispose();

    _editKeyController.dispose();
    _editValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
              _calculateOutput();
            });
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'substitution_from'),
                controller: _fromController,
                onChanged: (text) {
                  setState(() {
                    _currentFromInput = text;
                    _calculateOutput();
                  });
                },
              )
            ),
            Icon(
              Icons.arrow_forward,
              color: themeColors().mainFont(),
            ),
            Expanded(
              child: GCWTextField(
                hintText: i18n(context, 'substitution_to'),
                controller: _toController,
                onChanged: (text) {
                  setState(() {
                    _currentToInput = text;
                    _calculateOutput();
                  });
                },
              ),
            ),
            GCWIconButton(
              iconData: Icons.add,
              onPressed: () {
                setState(() {
                  _addNewSubstitution();
                  _calculateOutput();
                });
              },
            )
          ],
        ),
        GCWOnOffSwitch(
          title: i18n(context, 'substitution_case_sensitive'),
          value: false,
          onChanged: (value) {
            setState(() {
              _currentCaseSensitive = value;
              _calculateOutput();
            });
          },
        ),
        _buildSubstitutionList(context),
        GCWDefaultOutput(
          child: _output
        )
      ],
    );
  }

  _addNewSubstitution() {
    if (_currentFromInput.length > 0) {
      _currentSubstitutions.putIfAbsent(++_currentIdCount, () => {_currentFromInput: _currentToInput});

      _fromController.clear();
      _toController.clear();
      _currentFromInput = '';
      _currentToInput = '';
    }
  }

  _buildSubstitutionList(BuildContext context) {
    var odd = true;
    var rows = _currentSubstitutions.entries.map((substitution) {
      Widget output;

      var row = Container(
          child: Row (
            children: <Widget>[
              Expanded(
                child: Container(
                  child: _currentEditId == substitution.key
                    ? GCWTextField (
                        controller: _editKeyController,
                        onChanged: (text) {
                          setState(() {
                            _currentEditedKey = text;
                          });
                        },
                      )
                    : GCWText (
                        text: substitution.value.keys.first
                      ),
                  margin: EdgeInsets.only(left: 10),
                ),
                flex: 1,
              ),
              Icon(
                Icons.arrow_forward,
                color: themeColors().mainFont(),
              ),
              Expanded(
                  child: Container(
                    child: _currentEditId == substitution.key
                      ? GCWTextField(
                          controller: _editValueController,
                          autofocus: true,
                          onChanged: (text) {
                            setState(() {
                              _currentEditedValue = text;
                            });
                          },
                        )
                      : GCWText (
                          text: substitution.value.values.first
                        ),
                    margin: EdgeInsets.only(left: 10),
                  ),
                  flex: 3
              ),
              _currentEditId == substitution.key
                ? GCWIconButton(
                    iconData: Icons.check,
                    onPressed: () {

                      _currentSubstitutions[_currentEditId] = {_currentEditedKey: _currentEditedValue};

                      setState(() {
                        _currentEditId = null;
                        _editKeyController.clear();
                        _editValueController.clear();

                        _calculateOutput();
                      });
                    },
                  )
                : GCWIconButton(
                    iconData: Icons.edit,
                    onPressed: () {
                      setState(() {
                        _currentEditId = substitution.key;
                        _editKeyController.text = substitution.value.keys.first;
                        _editValueController.text = substitution.value.values.first;
                        _currentEditedKey = substitution.value.keys.first;
                        _currentEditedValue = substitution.value.values.first;
                      });
                    },
                  ),
              GCWIconButton(
                iconData: Icons.remove,
                onPressed: () {
                  setState(() {
                    _currentSubstitutions.remove(substitution.key);

                    _calculateOutput();
                  });
                },
              )
            ],
          )
      );

      if (odd) {
        output = Container(
          color: themeColors().outputListOddRows(),
          child: row
        );
      } else {
        output = Container(
          child: row
        );
      }
      odd = !odd;

      return output;
    }).toList();

    if (rows.length > 0) {
      rows.insert(0,
        GCWTextDivider(
          text: i18n(context, 'substitution_current_substitutions')
        )
      );
    }

    return Column(
      children: rows
    );
  }

  _calculateOutput() {
    var _substitutions = <String, String>{};
    _currentSubstitutions.entries.forEach((entry) {
      _substitutions.putIfAbsent(entry.value.keys.first, () => entry.value.values.first);
    });

    if (_currentFromInput != null && _currentFromInput.length > 0 && _currentToInput != null) {
      _substitutions.putIfAbsent(_currentFromInput, () => _currentToInput);
    }

    _output = substitution(_currentInput, _substitutions, caseSensitive: _currentCaseSensitive);
  }
}